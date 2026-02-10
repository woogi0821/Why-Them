package com.whythem.shop.promotion.mapper;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.vo.Promotion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PromotionMapper {
    // 프로모션 등록
    int insert(Promotion promotion);

    // 프로모션 목록 조회 (관리자)
    List<Promotion> selectPromotionList(Criteria criteria);

    // 프로모션 단건 조회 (수정 화면용)
    Promotion selectPromotion(Long promotionId);

    // 프로모션 수정
    int update(Promotion promotion);

    // 프로모션 상태 변경 (종료)
    int updatePromotionStatus(
            @Param("promotionId") Long promotionId,
            @Param("status") String status
    );
}
