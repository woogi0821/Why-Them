package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.AdminMapper;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.common.CommonUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

/**
 * 관리자 상품 관리 서비스
 * 상품의 등록, 수정, 삭제 및 조회 로직을 담당합니다.
 */
@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminMapper adminMapper;
    private final CommonUtil commonUtil;

    /**
     * [조회] 카테고리별 상품 목록 가져오기
     * @param categoryId 카테고리 번호 (null일 경우 전체 조회)
     * @return 상품 리스트
     */
    public List<AdminVO> getAdminProductList(Long categoryId) {
        return adminMapper.getAdminProductList(categoryId);
    }

    /**
     * [조회] 특정 상품 상세 정보 가져오기
     * @param productId 상품 고유 번호
     * @return 해당 상품의 상세 데이터(AdminVO)
     */
    public AdminVO findAdminProductById(Long productId) {
        return adminMapper.findAdminProductById(productId);
    }

    /**
     * [등록] 새로운 상품 저장
     * @param product 등록할 상품 정보가 담긴 객체
     */
    @Transactional // DB 작업 도중 오류 발생 시 자동 롤백
    public void registerAdminProduct(AdminVO product) {
        adminMapper.insertAdminProduct(product);
    }

    /**
     * [수정] 기존 상품 정보 업데이트
     * @param product 수정된 상품 정보 객체
     */
    @Transactional
    public void updateAdminProduct(AdminVO product) {
        // 1. 기존 데이터 미리 가져오기
        AdminVO oldData = adminMapper.findAdminProductById(product.getProductId());
        MultipartFile newFile = product.getProductImage();

        // 2. 새 파일이 있는 경우만 파일 교체 작업 수행
        if (newFile != null && !newFile.isEmpty()) {

            // [삭제] 기존 파일이 있다면 한 줄로 정리
            if (oldData != null && oldData.getImageUrl() != null) {
                commonUtil.deleteFile(oldData.getImageUrl().substring(oldData.getImageUrl().lastIndexOf("/") + 1));
            }

            // [이름 생성] 확장자 추출과 UUID 결합을 한 번에
            String originalName = newFile.getOriginalFilename();
            String extension = originalName.contains(".") ? originalName.substring(originalName.lastIndexOf(".")) : "";
            String newFileName = UUID.randomUUID() + extension;

            // [저장] 예외 처리는 필요하지만 코드는 간결하게
            try {
                commonUtil.saveFile(newFile, newFileName);
                product.setImageUrl("/upload/" + newFileName);
            } catch (Exception e) {
                throw new RuntimeException("파일 교체 실패", e);
            }
        } else {
            // 새 파일 없으면 기존 경로 그대로 사용
            product.setImageUrl(oldData.getImageUrl());
        }

        // 3. DB 업데이트 (공통)
        adminMapper.updateAdminProduct(product);
    }

    /**
     * [삭제] 상품 정보 및 관련 물리 파일 삭제
     * DB에서 정보를 삭제하기 전, 서버에 저장된 실제 이미지 파일을 먼저 제거합니다.
     * @param productId 삭제할 상품 번호
     */
    @Transactional
    public void deleteAdminProduct(Long productId) {
        // 1. 삭제 전 해당 상품의 이미지 경로를 확인하기 위해 데이터 조회
        AdminVO product = adminMapper.findAdminProductById(productId);

        // 2. 상품이 존재하고 이미지가 등록되어 있는 경우 물리 파일 삭제 진행
        if (product != null && product.getImageUrl() != null) {
            // DB에 저장된 "/upload/test.jpg" 형태에서 실제 파일명 "test.jpg"만 추출
            String fileName = product.getImageUrl().replace("/upload/", "");

            // CommonUtil(파일 유틸리티)을 호출하여 실제 서버 저장소에서 파일 삭제
            commonUtil.deleteFile(fileName);
        }

        // 3. 파일 삭제 후 DB에서 상품 레코드 최종 삭제
        adminMapper.deleteAdminProduct(productId);
    }
}