package com.whythem.shop.admin.mapper;

import com.whythem.shop.admin.vo.AdminVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface AdminMapper {

    // 1. 관리자용 상품 목록 조회
    List<AdminVO> getAdminProductList(@Param("categoryId") Long categoryId);

    // 2. 상품 수정을 위한 상세 데이터 조회
    AdminVO findAdminProductById(Long productId);

    // 3. 신규 상품 정보 등록 (이미지 경로는 AdminVO의 imageUrl 필드로 통합)
    void insertAdminProduct(AdminVO product);

    // [삭제] 4. insertAdminProductImage 메서드 삭제함

    // 5. 상품 정보 수정
    void updateAdminProduct(AdminVO product);

    // 6. 상품 데이터 삭제
    void deleteAdminProduct(Long productId);

    // [삭제] 7. deleteAdminProductImages 메서드 삭제함
}