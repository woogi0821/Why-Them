package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.AdminMapper;
import com.whythem.shop.admin.vo.AdminVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
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

    @Transactional
    public void deleteAdminProduct(Long productId) {
        // 1. DB에서 삭제하기 전에 상품 정보를 미리 가져옵니다.
        AdminVO product = adminMapper.findAdminProductById(productId);

        if (product != null && product.getImageUrl() != null) {
            // 2. 이미지가 저장된 실제 PC 폴더 경로
            String uploadPath = "C:/Users/khuser/Desktop/images/";

            // 3. DB에 저장된 "/upload/파일명.jpg"에서 "/upload/"만 지워서 순수 파일명을 만듭니다.
            String fileName = product.getImageUrl().replace("/upload/", "");

            // 4. 경로와 파일명을 합쳐서 파일 객체를 만들고 삭제합니다.
            File file = new File(uploadPath + fileName);
            if (file.exists()) {
                file.delete(); // 여기서 실제 PC 파일이 삭제됩니다!
            }
        }

        // 5. 파일 삭제가 끝나면 DB에서 데이터를 지웁니다.
        adminMapper.deleteAdminProduct(productId);
    }
}