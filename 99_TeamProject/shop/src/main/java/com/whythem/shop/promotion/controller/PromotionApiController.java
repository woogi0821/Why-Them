package com.whythem.shop.promotion.controller;

import com.whythem.shop.promotion.service.PromotionService;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/promotions")
@RequiredArgsConstructor
public class PromotionApiController {

    private final PromotionService promotionService;

    // 경로를 확실히 하나로 고정합니다.
    @GetMapping("/dashboard-stats")
    public ResponseEntity<Map<String, Object>> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();

        // 데이터들을 하나씩 확실하게 담습니다.
        stats.put("activePromotionCount", promotionService.countActivePromotions());
        stats.put("discountedProductCount", promotionService.getActivePromotionProductCount());

        Long sales = promotionService.sumTodayPromotionSales();
        stats.put("todaySales", (sales != null) ? sales : 0L);

        // 콘솔창에서 데이터가 실제로 넘어가는지 확인용
        System.out.println("대시보드 통계 전송: " + stats);

        return ResponseEntity.ok(stats);
    }

    @GetMapping("/active")
    public List<Promotion> getActivePromotions() {
        return promotionService.getActivePromotionList();
    }

    @GetMapping("/calculate")
    public Map<String, Object> calculate(@RequestParam int price, @RequestParam Long id) {
        Promotion target = promotionService.getPromotion(id);
        int finalPrice = promotionService.calculateDiscountedPrice(price, target);

        Map<String, Object> result = new HashMap<>();
        result.put("originalPrice", price);
        result.put("finalPrice", finalPrice);
        result.put("appliedPromotion", target != null ? target.getPromotionTitle() : "없음");

        return result;
    }
}