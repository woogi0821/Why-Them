package com.whythem.shop.order.service;

import com.whythem.shop.order.mapper.OrderMapper;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    OrderMapper orderMapper;

    @Transactional
    public Long processOrder(Long memberId, List<Long> itemIds, Double requestTotalPrice) {
        // 1. 장바구니 아이템 조회
        List<CartItemVO> cartItems = orderMapper.getCartItemsByMember(memberId, itemIds);
        if (cartItems.isEmpty()) throw new RuntimeException("장바구니가 비어있습니다.");

        // 2. 서버에서 합계 금액을 계산
        double calculatedTotal = 0;
        for (CartItemVO item : cartItems) {
            calculatedTotal += (item.getPrice() * item.getQuantity());
        }
        if (!requestTotalPrice.equals(calculatedTotal)) {
            throw new RuntimeException("결제 금액이 일치하지 않습니다. (보안 위반 의심)");
        }

        // 2. 주문 생성
        OrderVO order = new OrderVO();
        order.setMemberId(memberId);
        order.setTotalPrice(calculatedTotal);
        orderMapper.insertOrder(order); // XML 설정에 의해 orderId가 VO에 채워짐

        // 3. 주문 상세 삽입 (CartItem -> OrderItem 복사)
        for (CartItemVO item : cartItems) {
            OrderItemVO orderItem = new OrderItemVO();
            orderItem.setOrderId(order.getOrderId());
            orderItem.setProductId(item.getProductId());
            orderItem.setQuantity(item.getQuantity());
//          orderItem.setPrice(20000.0);                    // 테스트 데이터
            orderItem.setPrice(item.getPrice());

            orderMapper.insertOrderItem(orderItem);
        }

        // 4. 장바구니 삭제
        orderMapper.deleteSelectedCartItems(memberId, itemIds);

        return order.getOrderId(); // 생성된 주문번호 반환
    }

}
