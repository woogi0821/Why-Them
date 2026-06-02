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
        // ACTIVE 또는 ongoing 둘 다 허용하도록 방어적으로 수정
        if (promotion == null || promotion.getStatus() == null ||
                (!promotion.getStatus().trim().equalsIgnoreCase("ACTIVE") &&
                        !promotion.getStatus().trim().equalsIgnoreCase("ongoing"))) {
            return originalPrice;
        }

        int discountValue = promotion.getDiscountValue();
        String type = promotion.getDiscountType().trim().toUpperCase();
        double resultPrice = originalPrice;

        if ("PERCENT".equals(type) || "RATE".equals(type)) {
            resultPrice = originalPrice * (1 - (discountValue / 100.0));
        } else if ("AMOUNT".equals(type)) {
            resultPrice = originalPrice - discountValue;
        }

        return (int) resultPrice;
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
    // PromotionService.java 파일에 추가
    public int getActivePromotionProductCount() {
        // 매퍼의 getActivePromotionProductCount 쿼리를 호출합니다.
        return promotionMapper.getActivePromotionProductCount();
    }
    // PromotionService.java

    public int countActivePromotions() {
        // XML의 id="countActivePromotions"를 호출
        return promotionMapper.countActivePromotions();
    }

    public Long sumTodayPromotionSales() {
        // XML의 id="sumTodayPromotionSales"를 호출
        return promotionMapper.sumTodayPromotionSales();
    }
}