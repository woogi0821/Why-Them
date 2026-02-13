package com.whythem.shop.order.service;

import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.order.mapper.OrderMapper;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import com.whythem.shop.order.vo.PaymentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;

    //  1. 주문 생성 단계
    @Transactional
    public Long processOrder(Long memberId, List<Long> itemIds, Double requestTotalPrice) {
        // 1) 장바구니 아이템 조회
        List<CartItemVO> cartItems = orderMapper.getCartItemsByMember(memberId, itemIds);
        if (cartItems.isEmpty()) throw new RuntimeException("장바구니가 비어있습니다.");

        // 2) 서버에서 합계 금액을 계산
        double calculatedTotal = 0;
        for (CartItemVO item : cartItems) {
            calculatedTotal += (item.getPrice() * item.getQuantity());
        }
        if (!requestTotalPrice.equals(calculatedTotal)) {
            throw new RuntimeException("결제 금액이 일치하지 않습니다. (보안 위반 의심)");
        }

        // 3) 주문 생성
        OrderVO order = new OrderVO();
        order.setMemberId(memberId);
        order.setTotalPrice(calculatedTotal);
        orderMapper.insertOrder(order); // XML 설정에 의해 orderId가 VO에 채워짐

        // 4) 주문 상세 생성 (CartItem -> OrderItem 복사)
        for (CartItemVO item : cartItems) {
            OrderItemVO orderItem = new OrderItemVO();
            orderItem.setOrderId(order.getOrderId());
            orderItem.setProductId(item.getProductId());
            orderItem.setQuantity(item.getQuantity());
//          orderItem.setPrice(20000.0);                    // 테스트 데이터
            orderItem.setPrice(item.getPrice().doubleValue()); //이부분 CartVO에서 Long으로 선언해놔서 더블밸류만 좀 붙였습니다.

            orderMapper.insertOrderItem(orderItem);
        }

//      5) 결제 대기
        PaymentVO payment = new PaymentVO();
        payment.setOrderId(order.getOrderId());
        payment.setAmount(calculatedTotal);
        payment.setPaymentMethod("0");          // 결제방법 K:카카오, N:네이버, C: Card
        orderMapper.insertPayment(payment);

//      6) 장바구니 삭제
        orderMapper.deleteSelectedCartItems(memberId, itemIds);

        return order.getOrderId(); // 생성된 주문번호 반환
    }

    //  2. 결제 단계
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
