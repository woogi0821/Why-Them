package com.whythem.shop.order.service;

import com.whythem.shop.order.mapper.OrderMapper;
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
    private OrderMapper orderMapper; // 검증(Select)을 위해 매퍼도 주입

    @Test
    @Transactional
    @Rollback(false)
    void processOrder() {
        Long memberId = 1111L;
        List<Long> selectedItemIds = Arrays.asList(18L);    // 장바구니 ItemId

        // 서버에서 계산될 예상 총액 (실제 상품 가격 * 수량의 합계여야 검증 통과)
        Double expectedTotalPrice = 365000.0;

        // 주문 프로세스 실행
        try {
            Long orderId = orderService.processOrder(memberId, selectedItemIds, expectedTotalPrice);

            // Then: 결과 검증
            assertNotNull(orderId, "주문 번호가 생성되어야 합니다.");
            log.info("생성된 주문 번호: {}", orderId);

        } catch (RuntimeException e) {
            log.error("주문 실패 사유: {}", e.getMessage());

            // 금액 불일치 등 예외 발생 시 테스트가 실패하도록 설정
            fail("주문 프로세스 중 예외 발생: " + e.getMessage());
        }
    }

    @Test
    @Transactional
    @Rollback(false)
    void completePayment() {
        Long orderId = 47L;

        try{
            // When: 결제 완료 메서드 실행
            orderService.completePayment(orderId);
            log.info("completePayment 실행 완료");
        } catch (Exception e) {
            log.error("실패 원인: " + e.getMessage());
        }
    }

}