package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PromotionService {
    private final PromotionMapper promotionMapper;

    /**
     * 프로모션 상세 조회
     */
    public Promotion getPromotion(Long promotionId) {
        return promotionMapper.selectPromotion(promotionId);
    }

    /**
     * 프로모션 강제 종료
     */
    public void endPromotion(Long promotionId) {
        promotionMapper.updatePromotionStatus(promotionId);
    }

    /**
     * 프로모션 목록 조회 (페이징 포함)
     */
    public List<Promotion> getPromotionList(Criteria criteria) {
        // 별도의 상태 계산 로직 없이 DB 목록만 반환
        return promotionMapper.selectPromotionList(criteria);
    }

    /**
     * 전체 프로모션 개수 조회
     */
    public int getPromotionTotalCount(Criteria criteria) {
        return promotionMapper.selectPromotionTotalCount(criteria);
    }

    /**
     * 신규 프로모션 등록 업무
     * @param promotion 사용자가 입력한 데이터 객체
     */
    public void insertPromotion(Promotion promotion) {
        // 필요한 경우 여기서 사전 유효성 검사 로직을 넣을 수 있습니다.
        promotionMapper.insert(promotion);
    }

    public int updatePromotion(Promotion promotion) {
        return promotionMapper.updatePromotion(promotion);
    }

    /**
     * 프로모션 논리 삭제 (IS_ACTIVE = 'D')
     * @return 삭제(수정)된 행의 개수
     */
    public int removePromotion(Long promotionId) {
        return promotionMapper.deletePromotion(promotionId);
    }
}
