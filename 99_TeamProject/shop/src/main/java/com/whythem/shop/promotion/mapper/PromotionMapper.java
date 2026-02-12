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
     * @return 검색 조건에 맞는 프로모션 리스트
     */
    List<Promotion> selectPromotionList(Criteria criteria);

    /**
     * 프로모션 전체 개수 조회
     * @param criteria 검색 조건(searchKeyword 등)을 반영한 전체 카운트
     * @return 전체 레코드 수 (페이징 계산의 바탕)
     */
    int selectPromotionTotalCount(Criteria criteria);

    /**
     * 프로모션 신규 등록
     * @param promotion 프로모션 정보 객체
     * @return 성공 시 1 반환
     */
    int insert(Promotion promotion);

    /**
     * 프로모션 상세 정보 조회
     * @param promotionId 조회할 프로모션 고유 ID
     * @return 프로모션 VO 객체
     */
    Promotion selectPromotion(@Param("promotionId") Long promotionId);

    /**
     * 프로모션 정보 수정 (제목, 기간, 할인값 등)
     * @param promotion 수정할 정보가 담긴 객체
     * @return 성공 시 1 반환
     */
    int update(Promotion promotion);

    /**
     * 프로모션 상태 변경 (강제 종료)
     * IS_ACTIVE 컬럼을 'N'으로 업데이트합니다.
     * @param promotionId 종료 시킬 프로모션 ID
     * @return 성공 시 1 반환
     */
    int updatePromotionStatus(@Param("promotionId") Long promotionId);
    // 등록 성공 시 1, 실패 시 0을 반환합니다.

}