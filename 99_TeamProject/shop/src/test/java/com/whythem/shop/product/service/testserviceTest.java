package com.whythem.shop.product.service;

import com.whythem.shop.product.vo.testvo;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Log4j2
class testserviceTest {
    @Autowired
    private testservice testservice;

    @Test
    void getTestList() {
        Long categoryId = 1L;
        List<testvo> list = testservice.getTestList(categoryId);
        assertThat((list).isEmpty());
        list.forEach(testvo -> log.info("[SUCCESS] ProdID: {}, Name: {}", testvo.getProductId(), testvo.getPrice()));
    }

    @Test
    void findById() {
        Long productId = 60L;
        testvo testvo = testservice.findById(productId);
        assertThat(testvo).isNotNull();
        log.info("조회성공 -> 상품명:{}, 가격:{}",testvo.getProduct_name(),testvo.getPrice());
    }
}