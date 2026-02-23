package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.AdminMapper;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.common.CommonUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.UUID;

/**
 * 관리자 상품 관리 서비스
 * 상품의 등록, 수정, 삭제 및 조회 로직을 담당합니다.
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class AdminService {

    private final AdminMapper adminMapper;
    private final CommonUtil commonUtil;

    /**
     * [조회] 판매 중인 상품 목록 (STATUS = 'SALE')
     */
    public List<AdminVO> getAdminProductList(Long categoryId) {
        return adminMapper.getAdminProductList(categoryId);
    }

    /**
     * [조회] 🚩 판매 중지된 상품 목록 (STATUS = 'STOP')
     */
    public List<AdminVO> getStoppedProductList() {
        return adminMapper.getStoppedProductList();
    }

    /**
     * [조회] 특정 상품 상세 정보
     */
    public AdminVO findAdminProductById(Long productId) {
        return adminMapper.findAdminProductById(productId);
    }

    /**
     * [등록] 새로운 상품 저장 (최초 상태 SALE)
     */
    @Transactional
    public void registerAdminProduct(AdminVO product) throws Exception {
        MultipartFile file = product.getProductImage();

        if (file != null && !file.isEmpty()) {
            String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            File saveFile = new File("C:/shop/upload", uuid);
            file.transferTo(saveFile);
            product.setImageUrl("/upload/" + uuid);
        }

        adminMapper.insertAdminProduct(product);
    }

    /**
     * [수정] 상품 정보 업데이트
     */
    @Transactional
    public void updateAdminProduct(AdminVO product) throws Exception {
        AdminVO oldData = adminMapper.findAdminProductById(product.getProductId());
        MultipartFile newFile = product.getProductImage();

        if (newFile != null && !newFile.isEmpty()) {
            // 기존 파일 삭제
            if (oldData != null && oldData.getImageUrl() != null) {
                String oldFileName = oldData.getImageUrl().substring(8);
                File file = new File("C:/shop/upload", oldFileName);
                if(file.exists()) file.delete();
            }

            // 새 파일 저장
            String newFileName = UUID.randomUUID().toString() + "_" + newFile.getOriginalFilename();
            File saveFile = new File("C:/shop/upload", newFileName);
            newFile.transferTo(saveFile);
            product.setImageUrl("/upload/" + newFileName);
        } else {
            if (oldData != null) {
                product.setImageUrl(oldData.getImageUrl());
            }
        }

        adminMapper.updateAdminProduct(product);
    }

    /**
     * [중지] 상품 판매 중지 (소프트 삭제)
     * 실제 이미지는 지우지 않고 상태만 'STOP'으로 바꿉니다.
     */
    @Transactional
    public void deleteAdminProduct(Long productId) {
        adminMapper.deleteAdminProduct(productId);
        log.info("상품 판매 중지 완료: ID {}", productId);
    }

    /**
     * [복구] 🚩 상품 판매 재개
     * 'STOP' 상태를 다시 'SALE'로 변경합니다.
     */
    @Transactional
    public void restoreAdminProduct(Long productId) {
        adminMapper.restoreAdminProduct(productId);
        log.info("상품 판매 재개 완료: ID {}", productId);
    }
    public int getStoppedProductCount() {
        return adminMapper.getStoppedProductCount();
    }

    public List<AdminVO> getRecentProducts(int limit) {
        return adminMapper.getRecentProducts(limit);
    }

    public List<AdminVO> getLowStockProducts(int limit) {
        return adminMapper.getLowStockProducts(limit);
    }
}