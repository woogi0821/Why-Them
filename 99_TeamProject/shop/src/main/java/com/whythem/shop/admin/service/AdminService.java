package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.AdminMapper;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.common.CommonUtil; // 패키지 경로 확인!
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminMapper adminMapper;
    private final CommonUtil commonUtil; // CommonUtil 추가

    public List<AdminVO> getAdminProductList(Long categoryId) {
        return adminMapper.getAdminProductList(categoryId);
    }

    public AdminVO findAdminProductById(Long productId) {
        return adminMapper.findAdminProductById(productId);
    }

    @Transactional
    public void registerAdminProduct(AdminVO product) {
        adminMapper.insertAdminProduct(product);
    }

    @Transactional
    public void updateAdminProduct(AdminVO product) {
        adminMapper.updateAdminProduct(product);
    }

    @Transactional
    public void deleteAdminProduct(Long productId) {
        AdminVO product = adminMapper.findAdminProductById(productId);

        if (product != null && product.getImageUrl() != null) {
            // "/upload/파일명"에서 파일명만 추출
            String fileName = product.getImageUrl().replace("/upload/", "");

            // CommonUtil을 사용하여 실제 파일 삭제
            commonUtil.deleteFile(fileName);
        }
        adminMapper.deleteAdminProduct(productId);
    }
}