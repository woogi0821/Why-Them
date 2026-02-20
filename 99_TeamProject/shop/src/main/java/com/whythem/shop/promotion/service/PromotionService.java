package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     *
     * @param promotion 사용자가 입력한 데이터 객체
     */
    public int insertPromotion(Promotion promotion) {
        // 필요한 경우 여기서 사전 유효성 검사 로직을 넣을 수 있습니다.
        return promotionMapper.insert(promotion);
    }

    public int updatePromotion(Promotion promotion) {
        return promotionMapper.updatePromotion(promotion);
    }

    /**
     * 프로모션 논리 삭제 (IS_ACTIVE = 'D')
     *
     * @return 삭제(수정)된 행의 개수
     */
    public int removePromotion(Long promotionId) {
        return promotionMapper.deletePromotion(promotionId);
    }

    /**
     * 대시보드용 통계 데이터 조회
     */
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        // HashMap은 **이름(Key)**과 **값(Value)**을 짝지음
        // 이름(Key): "activePromotions"
        //값(Value): 5 (진행 중인 이벤트 개수)

        // Mapper에서 각각의 데이터를 가져와 Map에 담습니다.
        stats.put("activePromotions", promotionMapper.countActivePromotions());
        stats.put("discountedProducts", promotionMapper.countDiscountedProducts());

        // 매출 데이터가 없을 경우(null)를 대비해 처리
        Long todaySales = promotionMapper.sumTodayPromotionSales();
        stats.put("todaySales", (todaySales != null) ? todaySales : 0L);

        return stats;
    }
    public List<Promotion> getActivePromotionList() {
        return promotionMapper.getActivePromotions();
    }
//    @param originalPrice 상품 원가
//    @param promotion 적용할 프로모션 객체
//    @return 할인 적용된 최종 가격
//
    public int calculateDiscountedPrice(int originalPrice, Promotion promotion) {
        if (promotion == null) return originalPrice;

        int discountValue = promotion.getDiscountValue();
        String type = promotion.getDiscountType(); // "AMOUNT" 또는 "RATE"

        if ("AMOUNT".equals(type)) {
            // 정액 할인 (원가 - 할인액)
            return Math.max(0, originalPrice - discountValue);
        } else if ("RATE".equals(type)) {
            // 정률 할인 (원가 - (원가 * 할인율 / 100))
            double discountAmount = originalPrice * (discountValue / 100.0);
            return (int) (originalPrice - discountAmount);
        }

        return originalPrice;
    }
}
