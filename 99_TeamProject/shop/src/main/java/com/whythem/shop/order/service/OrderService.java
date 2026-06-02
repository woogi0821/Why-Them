package com.whythem.shop.order.service;

import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.order.mapper.OrderMapper;
import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import com.whythem.shop.order.vo.PaymentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;

    /*
        1. 주문 (상세페이지, 장바구니 주문 공통로직)
    */
    //  상세페이지 주문
    @Transactional
    public Long processDirectOrder(Long memberId, Long productId, int quantity) {
        Double dbPrice = orderMapper.getProductPrice(productId);
        if (dbPrice == null) throw new RuntimeException("상품 정보가 없습니다.");

        OrderItemVO item = new OrderItemVO();
        item.setProductId(productId);
        item.setQuantity(quantity);
        item.setPrice(dbPrice);

        double calculatedTotal = dbPrice * quantity;
        return createOrder(memberId, Collections.singletonList(item), calculatedTotal);
    }

    //  장바구니 주문
    @Transactional
    public Long processCartOrder(Long memberId, List<Long> cartItemIds, Double requestTotalPrice) {
        List<CartItemVO> cartItems = orderMapper.getCartItemsByMember(memberId, cartItemIds);
        if (cartItems.isEmpty()) throw new RuntimeException("주문할 상품이 없습니다.");

        List<OrderItemVO> orderItems = new ArrayList<>();
        for (CartItemVO cart : cartItems) {
            OrderItemVO item = new OrderItemVO();
            item.setProductId(cart.getProductId());
            item.setQuantity(cart.getQuantity());
            item.setPrice(cart.getPrice().doubleValue());
            orderItems.add(item);
        }

        Long orderId = createOrder(memberId, orderItems, requestTotalPrice);
//        orderMapper.deleteSelectedCartItems(memberId, cartItemIds);

        String cartIdsStr = cartItemIds.stream()
            .map(String::valueOf)
            .collect(Collectors.joining(","));
        orderMapper.updatePaymentCartItems(orderId, cartIdsStr);

        return orderId;
    }


    //  주문 생성 공통 로직
    @Transactional
    public Long createOrder(Long memberId, List<OrderItemVO> orderItems, Double requestTotalPrice) {
        double calculatedTotal = 0;
        for (OrderItemVO item : orderItems) {
            calculatedTotal += (item.getPrice() * item.getQuantity());
        }
        if (Double.compare(requestTotalPrice, calculatedTotal) != 0) {
            throw new RuntimeException("결제 금액이 일치하지 않습니다.");
        }

        OrderVO order = new OrderVO();
        order.setMemberId(memberId);
        order.setTotalPrice(calculatedTotal);
        orderMapper.insertOrder(order);

        for (OrderItemVO item : orderItems) {
            item.setOrderId(order.getOrderId());
            orderMapper.insertOrderItem(item);
        }

        PaymentVO payment = new PaymentVO();
        payment.setOrderId(order.getOrderId());
        payment.setAmount(calculatedTotal);
        payment.setPaymentMethod("0");

        orderMapper.insertPayment(payment);

        return order.getOrderId();
    }

    /*
        2. 주문 단계
    */
    public List<OrderItemVO> getOrderItems(Long orderId, Long memberId) {
        List<OrderItemVO> items = orderMapper.selectOrderList(orderId, memberId);

        if (items == null || items.isEmpty()) {
            throw new IllegalArgumentException("주문이 존재하지 않거나 접근 권한이 없습니다.");
        }
        return items;
    }

    public MemberAddressVO getMemberInfo(Long memberId) {
        return orderMapper.selectMemberById(memberId);
    }

    /*
        3. 결제 단계
    */
    @Transactional
    public void completePayment(Long orderId, String paymentMethod, Long memberId) {
        int result = orderMapper.updatePaymentCompleted(orderId, paymentMethod, "PAID");
        if (result == 0) {
            throw new RuntimeException("결제 업데이트 실패: orderId=" + orderId);
        }
        orderMapper.updateOrderStatus(orderId, "ORDERED");

        List<OrderItemVO> itemList = orderMapper.getOrderItems(orderId);
        for (OrderItemVO item : itemList) {
            int updated = orderMapper.reduceStock(item.getProductId(), item.getQuantity());

            if (updated > 0) {
                // 2. 차감 후 남은 재고 확인
                int currentStock = orderMapper.getStockQuantity(item.getProductId());

                // 3. 재고가 0이면 상태를 SOLD_OUT으로 변경
                if (currentStock == 0) {
                    orderMapper.updateProductStatus(item.getProductId(), "SOLD_OUT");
                }
            } else {
                throw new RuntimeException("재고가 부족하여 결제를 진행할 수 없습니다.");
            }

            System.out.println("상품ID=" + item.getProductId() +", 주문 수량= "+item.getQuantity()+", update="+updated);
            if (updated == 0) {
                throw new RuntimeException("재고가 부족한 상품이 포함되었습니다.");
            }
        }

        String cartIdsStr = orderMapper.getCartItemIdsByPayment(orderId);
        if (cartIdsStr != null && !cartIdsStr.isEmpty()) {
            List<Long> cartItemIds = Arrays.stream(cartIdsStr.split(","))
                .map(Long::valueOf)
                .collect(Collectors.toList());
            orderMapper.deleteSelectedCartItems(memberId, cartItemIds);
        }

    }

    public PaymentVO getPaymentInfo(Long orderId) {
        PaymentVO payment = orderMapper.selectPaymentByOrderId(orderId);
        if (payment == null) throw new RuntimeException("결제 정보가 존재하지 않습니다. orderId=" + orderId);
        return payment;
    }

    public List<PaymentVO> getMemberPayments(Long memberId) {
        return orderMapper.selectPaymentsByMemberId(memberId);
    }
}
