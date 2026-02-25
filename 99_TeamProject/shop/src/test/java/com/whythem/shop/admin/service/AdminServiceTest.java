package com.whythem.shop.admin.service;

import com.whythem.shop.admin.vo.AdminVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@SpringBootTest
@Log4j2
class AdminServiceTest {
    @Autowired
    private AdminService adminService;
//[조회] 카테고리별 상품 목록 가져오기
    @Test
    void getAdminProductList() {
        Long categoryId=1L;
        List<AdminVO> list = adminService.getAdminProductList(categoryId);
        assertThat(list).isNotNull();
        list.forEach(adminVO->log.info("SUCCESS ProductId:{}, Name : {}",adminVO.getProductId(),adminVO.getName()));
    }

// 상세조회
    @Test
    void findAdminProductById() {
        Long productId=60L;
        AdminVO adminVO = adminService.findAdminProductById(productId);
        assertThat(adminVO).isNotNull();
        log.info("조회성공 -> 상품명 : {},가격:{}",adminVO.getName(),adminVO.getPrice());
    }
// 상품저장
    @Test
    @Transactional
    void registerAdminProduct() {
        AdminVO newProduct = new AdminVO();
        newProduct.setName(" 테스트 상품" + System.currentTimeMillis());
        newProduct.setPrice(15000);
        newProduct.setCategoryId(1L);
        newProduct.setImageUrl("/upload/test_image.jpg");
        adminService.registerAdminProduct(newProduct);
        List<AdminVO> list= adminService.getAdminProductList(1L);
        assertThat(list).isNotEmpty();
        log.info("등록성공 현재상품개수:{}",list.size());
    }
//수정
    @Test
    @Transactional
    void updateAdminProduct() {
        AdminVO updateProduct = new AdminVO();
        updateProduct.setProductId(60L);
        updateProduct.setName("업데이트 상품"+ System.currentTimeMillis());
        updateProduct.setPrice(10000);
        updateProduct.setCategoryId(1L);
        adminService.updateAdminProduct(updateProduct);
        List<AdminVO> list = adminService.getAdminProductList(1L);
        assertThat(list).isNotNull();
        log.info("수정성공 현재상품: {}",list.size());
    }

    @Test
    @Transactional
    void deleteAdminProduct() {
        Long targetId=60L;
        adminService.deleteAdminProduct(targetId);
        AdminVO result = adminService.findAdminProductById(targetId);
        assertThat(result).isNull();
        log.info("삭제성공 :{}",targetId);
    }
}