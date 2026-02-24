package com.whythem.shop.admin.mapper;

import com.whythem.shop.admin.vo.AdminVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface AdminMapper {

    /**
     * 판매 중인 상품 목록 조회 (STATUS = 'SALE')
     * @param categoryId 카테고리별 필터링을 위한 ID (null일 경우 전체 조회)
     * @return 판매 중인 상품 리스트
     */
    List<AdminVO> getAdminProductList(@Param("categoryId") Long categoryId);

    /**
     * 판매 중지된 상품 목록 조회 (STATUS = 'STOP')
     * @return 판매 중지 상태인 상품 리스트
     */
    List<AdminVO> getStoppedProductList();

    /**
     * 특정 상품 상세 정보 조회
     * @param productId 조회할 상품 번호
     * @return 상품 상세 정보 VO
     */
    AdminVO findAdminProductById(Long productId);

    /**
     * 신규 상품 등록 (최초 등록 시 STATUS는 기본값 'SALE')
     * @param product 등록할 상품 정보가 담긴 VO
     */
    void insertAdminProduct(AdminVO product);

    /**
     * 기존 상품 정보 수정
     * @param product 수정할 정보가 담긴 VO
     */
    void updateAdminProduct(AdminVO product);

    /**
     * 상품 판매 중지 (소프트 삭제)
     * DB에서 데이터를 삭제하지 않고 STATUS를 'STOP'으로 변경합니다.
     * @param productId 판매 중지할 상품 번호
     */
    void deleteAdminProduct(Long productId);

    /**
     * 상품 판매 재개 (복구)
     * STATUS를 'STOP'에서 다시 'SALE'로 변경합니다.
     * @param productId 판매 재개할 상품 번호
     */
    void restoreAdminProduct(Long productId);

    /** 판매 중지 상품 총 개수 */
    int getStoppedProductCount();

    /** 최근 등록 상품 조회 (limit 개수만큼) */
    List<AdminVO> getRecentProducts(@Param("limit") int limit);

    /** 재고 부족 상품 조회 (5개 미만) */
    List<AdminVO> getLowStockProducts(@Param("limit") int limit);
}