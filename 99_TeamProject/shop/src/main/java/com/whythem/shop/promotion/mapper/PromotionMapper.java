package com.whythem.shop.promotion.mapper;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.vo.Promotion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface PromotionMapper {

    /**
     * 프로모션 목록 조회 (관리자)
     * @param criteria 페이징(offset, size) 및 검색 조건 포함
     */
    List<Promotion> selectPromotionList(Criteria criteria);

    /**
     * 프로모션 전체 개수 조회
     * @param criteria 검색 조건(searchKeyword 등)을 반영한 전체 카운트
     */
    int selectPromotionTotalCount(Criteria criteria);

    /**
     * 프로모션 신규 등록
     * @param promotion 프로모션 정보 객체
     */
    int insert(Promotion promotion);

    /**
     * 프로모션 상세 정보 조회
     * @param promotionId 조회할 프로모션 고유 ID
     */
    Promotion selectPromotion(@Param("promotionId") Long promotionId);

    /**
     * 프로모션 정보 수정 (제목, 기간, 할인값 등)
     */
    int updatePromotion(Promotion promotion);

    /**
     * 프로모션 상태 변경 (강제 종료)
     * IS_ACTIVE 컬럼을 'N'으로 업데이트합니다.
     */
    int updatePromotionStatus(@Param("promotionId") Long promotionId);

    /**
     * 프로모션 논리 삭제 (IS_ACTIVE = 'D')
     */
    int deletePromotion(Long promotionId);

    // 진행 중인 이벤트 개수 조회 (통계용)
    int countActivePromotions();

    // 프로모션이 적용된(할인율 > 0) 상품 수 조회
    int countDiscountedProducts();

    // 오늘 판매된 프로모션 상품의 매출 합계 조회
    Long sumTodayPromotionSales();

    // 활성 프로모션 목록 조회 (배너용) - 서비스 호출명과 통일
    List<Promotion> getActivePromotionList();

    // 특정 ID로 프로모션 1건 조회 (계산용) - 서비스 호출명과 통일
    Promotion getPromotionById(@Param("promotionId") Long promotionId);
    // 현재 진행중인 이벤트 수
    int getActivePromotionProductCount();
}