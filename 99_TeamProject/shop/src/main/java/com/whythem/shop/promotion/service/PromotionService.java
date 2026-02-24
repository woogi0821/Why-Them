package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PromotionService {
    private final PromotionMapper promotionMapper;

    /**
     * 프로모션 상세 조회 (DB에서 직접 1건 조회)
     */
    public Promotion getPromotion(Long id) {
        return promotionMapper.getPromotionById(id);
    }

    /**
     * 활성 프로모션 목록 조회 (배너용)
     */
    public List<Promotion> getActivePromotionList() {
        return promotionMapper.getActivePromotionList();
    }

    /**
     * 가격 계산 로직 (유효성 검사 및 할인 적용)
     * @param originalPrice 상품 원가
     * @param promotion 적용할 프로모션 객체
     * @return 할인 적용된 최종 가격
     */
    public int calculateDiscountedPrice(int originalPrice, Promotion promotion) {
        // 1. 프로모션이 없거나 ACTIVE 상태가 아니면 원가 그대로 반환
        if (promotion == null || !"ACTIVE".equals(promotion.getStatus())) {
            return originalPrice;
        }

        // 2. 최소 주문 금액 체크 (DB의 min_order_amount 사용)
        int minOrderAmount = promotion.getMinOrderAmount();
        if (originalPrice < minOrderAmount) {
            return originalPrice;
        }

        int discountValue = promotion.getDiscountValue();
        int finalPrice = originalPrice;

        // 3. 타입에 따른 계산 (AMOUNT: 정액, RATE: 정률)
        if ("AMOUNT".equals(promotion.getDiscountType())) {
            finalPrice = originalPrice - discountValue;
        } else if ("RATE".equals(promotion.getDiscountType())) {
            // 소수점 처리는 Math.round로 처리
            finalPrice = (int) Math.round(originalPrice * (1 - discountValue / 100.0));
        }

        // 4. 1단위 버리고 10원으로 끝나도록 조정 (예: 17,856원 -> 17,850원)
        int truncatedPrice = (finalPrice / 10) * 10;

        // 최종 가격이 음수가 되지 않도록 방어
        return Math.max(0, truncatedPrice);
    }

    /**
     * 프로모션 목록 조회 (페이징 포함 - 관리자용)
     */
    public List<Promotion> getPromotionList(Criteria criteria) {
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
     */
    public int insertPromotion(Promotion promotion) {
        return promotionMapper.insert(promotion);
    }

    /**
     * 프로모션 정보 수정
     */
    public int updatePromotion(Promotion promotion) {
        return promotionMapper.updatePromotion(promotion);
    }

    /**
     * 프로모션 논리 삭제 (IS_ACTIVE = 'D')
     */
    public int removePromotion(Long promotionId) {
        return promotionMapper.deletePromotion(promotionId);
    }

    /**
     * 대시보드용 통계 데이터 조회
     */
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        // HashMap은 이름(Key)과 값(Value)을 짝지음
        stats.put("activePromotions", promotionMapper.countActivePromotions());
        stats.put("discountedProducts", promotionMapper.countDiscountedProducts());

        // 매출 데이터가 없을 경우(null)를 대비해 처리
        Long todaySales = promotionMapper.sumTodayPromotionSales();
        stats.put("todaySales", (todaySales != null) ? todaySales : 0L);

        return stats;
    }

    /**
     * 프로모션 강제 종료 (상태 N으로 변경)
     */
    public void endPromotion(Long promotionId) {
        promotionMapper.updatePromotionStatus(promotionId);
    }
}