package com.whythem.shop.order.service;

import com.whythem.shop.order.mapper.OrderMapper;
import com.whythem.shop.order.vo.CartItemVO;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import com.whythem.shop.order.vo.PaymentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;
/*
    1. 주문 (상세페이지, 장바구니 주문 공통로직)
*/
    //  상세페이지 주문
    @Transactional
    public Long processDirectOrder(Long memberId, Long productId, int quantity, Double requestTotalPrice) {
        // 1. 보안을 위해 DB에서 상품 가격 재조회
        Double dbPrice = orderMapper.getProductPrice(productId);
        if (dbPrice == null) throw new RuntimeException("상품 정보가 없습니다.");

        // 2. 단건 상품을 리스트로 규격화
        OrderItemVO item = new OrderItemVO();
        item.setProductId(productId);
        item.setQuantity(quantity);
        item.setPrice(dbPrice);

        // 3. 공통 로직 호출
        return createOrder(memberId, Collections.singletonList(item), requestTotalPrice);
    }

//  장바구니 주문
    @Transactional
    public Long processCartOrder(Long memberId, List<Long> cartItemIds, Double requestTotalPrice) {
        List<CartItemVO> cartItems = orderMapper.getCartItemsByMember(memberId, cartItemIds);
        if (cartItems.isEmpty()) throw new RuntimeException("주문할 상품이 없습니다.");

        // 2. CartItem -> OrderItem 복사
        List<OrderItemVO> orderItems = new ArrayList<>();
        for (CartItemVO cart : cartItems) {
            OrderItemVO item = new OrderItemVO();
            item.setProductId(cart.getProductId());
            item.setQuantity(cart.getQuantity());
            item.setPrice(cart.getPrice());         // DB에서 가져온 신뢰할 수 있는 가격
            orderItems.add(item);
        }

        // 3. 장바구니 주문 생성
        Long orderId = createOrder(memberId, orderItems, requestTotalPrice);

        // 4. 장바구니 삭제 (공통 로직 성공 시 실행)
        orderMapper.deleteSelectedCartItems(memberId, cartItemIds);

        return orderId;
    }


//  주문 생성 공통 로직
    @Transactional
    public Long createOrder(Long memberId, List<OrderItemVO> orderItems, Double requestTotalPrice) {
        // 1) 서버에서 합계 금액을 계산 (보안 검사)
        double calculatedTotal = 0;
        for (OrderItemVO item : orderItems) {
            calculatedTotal += (item.getPrice() * item.getQuantity());
        }
        if (Double.compare(requestTotalPrice, calculatedTotal) != 0) {
            throw new RuntimeException("결제 금액이 일치하지 않습니다.");
        }

        // 3) 주문 생성
        OrderVO order = new OrderVO();
        order.setMemberId(memberId);
        order.setTotalPrice(calculatedTotal);
        orderMapper.insertOrder(order); // XML 설정에 의해 orderId가 VO에 채워짐

        // 4) 주문 상세 생성 (CartItem -> OrderItem 복사)
        for (OrderItemVO item : orderItems) {
            item.setOrderId(order.getOrderId());

            orderMapper.insertOrderItem(item);
        }

//      5) 결제 대기
        PaymentVO payment = new PaymentVO();
        payment.setOrderId(order.getOrderId());
        payment.setAmount(calculatedTotal);
        payment.setPaymentMethod("0");          // 결제방법 K:카카오, N:네이버, C: CARD
        orderMapper.insertPayment(payment);

        return order.getOrderId(); // 생성된 주문번호 반환
    }

/*
    2. 결제 단계(상태변경 및 재고차감)
*/
    @Transactional
    public void completePayment(Long orderId){
        // 1) 결제 및 주문 상태 변경
        orderMapper.updatePaymentStatus(orderId, "COMPLETE");
        orderMapper.updateOrderStatus(orderId, "ORDERED");

        // 2) 주문 상품 목록 조회(VO 사용)
        List<OrderItemVO> itemList = orderMapper.getOrderItems(orderId);
        for (OrderItemVO item : itemList) {
            // 재고 차감 실행
            int result = orderMapper.reduceStock(item.getProductId(), item.getQuantity());
//            System.out.println("상품ID " + item.getProductId() + " 차감 결과: " + result);

            if(result == 0) {
                throw new RuntimeException("재고가 부족한 상품이 포함되었습니다.");
            }
        }
    }

}
