package com.whythem.shop.order.service;

import com.whythem.shop.order.mapper.OrderMapper;
import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.order.vo.OrderItemVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Log4j2
@Transactional
class OrderServiceTest {
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderMapper orderMapper;

//  상세 페이지 주문 테스트
    @Test
    @Transactional
    @Rollback(false)
    void processDirectOrder() {
        Long memberId = 1111L;
        Long productId = 80L;
        int quantity = 3;

        Double productPrice = orderMapper.getProductPrice(productId);
        if (productPrice == null) fail(productId + "번 상품이 없습니다.");

        Double requestTotalPrice = productPrice * quantity;
        log.info("단가: {}, 수량: {}, 요청총액: {}", productPrice, quantity, requestTotalPrice);

        try {
            Long orderId = orderService.processDirectOrder(memberId, productId, quantity);
//            List<OrderItemVO> items = orderMapper.getOrderItems(orderId);
//            log.info("상세 데이터 : {}", items.get(0).toString());

            assertNotNull(orderId, "주문 번호가 정상적으로 생성되어야 합니다.");
            log.info("테스트 성공 - 생성된 주문 번호: {}", orderId);

            List<OrderItemVO> items = orderMapper.getOrderItems(orderId);
            assertEquals(productPrice, items.get(0).getPrice(), "DB의 상품 가격과 주문 상세의 가격이 일치해야 합니다.");

        } catch (RuntimeException e) {
            log.error("주문 실패 사유: {}", e.getMessage());
            // 예외 발생 시 테스트 실패 처리
            fail("주문 프로세스 중 예외 발생: " + e.getMessage());
        }
    }

    //  장바구니 상품 주문 테스트
    @Test
    @Transactional
    @Rollback(false)
    void processCartOrder() {
        Long memberId = 1111L;
        List<Long> selectedCartItemIds = Arrays.asList(23L);

        List<CartItemVO> cartItems = orderMapper.getCartItemsByMember(memberId, selectedCartItemIds);
        if (cartItems.isEmpty()) {
            fail("테스트 실패: 선택한 장바구니 아이템(IDs: " + selectedCartItemIds + ")이 없습니다.");
        }

        double expectedTotal = 0;
        for (CartItemVO item : cartItems) {
            expectedTotal += (item.getPrice() * item.getQuantity());
        }
        log.info("조회된 상품 개수: {}개, 계산된 총액: {}", cartItems.size(), expectedTotal);

        try {
            Long orderId = orderService.processCartOrder(memberId, selectedCartItemIds, expectedTotal);

            assertNotNull(orderId);
            log.info("주문 생성 완료 - 주문번호: {}", orderId);

            List<OrderItemVO> orderDetails = orderMapper.getOrderItems(orderId);
            assertEquals(cartItems.size(), orderDetails.size(), "장바구니 아이템 수와 주문 상세 수가 일치해야 합니다.");

            assertNotNull(orderDetails.get(0).getPrice(), "주문 상세의 가격이 null이 아니어야 합니다.");
            log.info("첫 번째 상품 가격 확인: {}", orderDetails.get(0).getPrice());

            List<CartItemVO> remainingCartItems = orderMapper.getCartItemsByMember(memberId, selectedCartItemIds);
            assertTrue(remainingCartItems.isEmpty(), "주문 완료 후 선택한 장바구니 아이템은 DB에서 삭제되어야 합니다.");

            log.info("테스트 최종 성공: 주문 생성 및 장바구니 삭제 완료");

        } catch (RuntimeException e) {
            log.error("테스트 실패 사유: {}", e.getMessage());
            fail("주문 과정 중 예외 발생: " + e.getMessage());
        }
    }


//  결제 단위 테스트
    @Test
    @Transactional
    @Rollback(false)
    void completePayment() {
        Long orderId = 61L;

        try{
            // When: 결제 완료 메서드 실행
//            orderService.completePayment(orderId, );
            log.info("completePayment 실행 완료");
        } catch (Exception e) {
            log.error("실패 원인: " + e.getMessage());
        }
    }

}