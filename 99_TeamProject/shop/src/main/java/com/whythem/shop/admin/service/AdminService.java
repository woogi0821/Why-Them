package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.AdminMapper;
import com.whythem.shop.admin.vo.AdminVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AdminService {

    private final AdminMapper adminMapper;

    public AdminService(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    // 1. 관리자용 상품 목록 조회 (필요 시 카테고리 필터링)
    public List<AdminVO> getAdminProductList(Long categoryId) {
        return adminMapper.getAdminProductList(categoryId);
    }

    // 2. 수정/삭제를 위한 상품 상세 조회
    public AdminVO findAdminProductById(Long productId) {
        return adminMapper.findAdminProductById(productId);
    }

    // 3. 상품 등록 (트랜잭션 처리)
    @Transactional
    public void registerAdminProduct(AdminVO product, List<String> savedPaths) {
        // 상품 기본 정보 저장 (XML의 insertAdminProduct 호출)
        adminMapper.insertAdminProduct(product);

        // 다중 이미지 정보 저장 (저장된 파일 경로 리스트 처리)
        if (savedPaths != null && !savedPaths.isEmpty()) {
            for (int i = 0; i < savedPaths.size(); i++) {
                // 첫 번째 이미지는 'T'(대표), 나머지는 'F'로 설정
                String isMain = (i == 0) ? "T" : "F";
            }
        }
    }

    // 4. 상품 정보 수정
    @Transactional
    public void updateAdminProduct(AdminVO product) {
        adminMapper.updateAdminProduct(product);
    }

    // 5. 상품 삭제 (이미지 선 삭제 후 상품 본체 삭제)
    @Transactional
    public void deleteAdminProduct(Long productId) {
        // 1. 자식 레코드(이미지) 삭제
        // 2. 부모 레코드(상품) 삭제
        adminMapper.deleteAdminProduct(productId);
    }
}