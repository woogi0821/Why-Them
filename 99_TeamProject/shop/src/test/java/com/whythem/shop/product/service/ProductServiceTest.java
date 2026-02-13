package com.whythem.shop.product.service;

import com.whythem.shop.product.vo.ProductVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Log4j2
class ProductServiceTest {
    @Autowired
    private ProductService productService;

    @Test
    @DisplayName("카테고리 상품 조회 - 정상 케이스") // 테스트 목적을 명확히 기록
    void getProductListTest() {
        // 1. Given (테스트에 필요한 환경 설정)
        Long categoryId = 1L;

        // 2. When (실제 기능 실행)
        List<ProductVO> list = productService.getProductList(categoryId ,0L);

        // 3. Then (결과 검증 - 로그는 검증을 위한 보조 수단)
        assertThat(list).isNotEmpty(); // 리스트가 비어있지 않아야 성공

        // 실무에선 필요한 핵심 데이터만 한 줄로 깔끔하게!
        list.forEach(p -> log.info("[SUCCESS] ProdID: {}, Name: {}", p.getProductId(), p.getName()));
    }

    @Test
    @DisplayName("상품 조회 - 정상 케이스") // 테스트 목적을 명확히 기록
    void findById() {
        Long productId = 60L;
        ProductVO productVO = productService.findById(productId);
        assertThat(productVO).isNotNull();
        log.info("조회성공 -> 상품명:{}, 가격:{}", productVO.getName(),productVO.getPrice());
    }
    @Test
    @DisplayName("상품 상세 조회 테스트 - 존재하지 않는 번호")
    void findByIdFailTest() {
        // 1. Given: 절대 없을법한 큰 번호 입력
        Long nonExistId = 999999L;

        // 2. When
        ProductVO product = productService.findById(nonExistId);

        // 3. Then: 데이터가 없으므로 null이어야 함
        assertThat(product).isNull();
        log.info("조회 실패(정상): 존재하지 않는 상품번호입니다. (ID: {})", nonExistId);
    }
}
