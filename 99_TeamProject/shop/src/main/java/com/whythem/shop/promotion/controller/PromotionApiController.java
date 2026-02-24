package com.whythem.shop.promotion.controller;

import com.whythem.shop.promotion.service.PromotionService;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
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

    @GetMapping("/active")
    public List<Promotion> getActivePromotions() {
        return promotionService.getActivePromotionList();
    }

    @GetMapping("/calculate")
    public Map<String, Object> calculate(@RequestParam int price, @RequestParam Long id) {
        // 1. 서비스에서 해당 ID의 프로모션 1건만 가져옴
        Promotion target = promotionService.getPromotion(id);

        // 2. 계산 로직 호출
        int finalPrice = promotionService.calculateDiscountedPrice(price, target);

        // 3. 결과 반환
        Map<String, Object> result = new HashMap<>();
        result.put("originalPrice", price);
        result.put("finalPrice", finalPrice);
        result.put("appliedPromotion", target != null ? target.getPromotionTitle() : "없음");

        return result;
    }
}