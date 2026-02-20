package com.whythem.shop.promotion.controller; // 본인의 패키지 경로에 맞게 수정

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
        // 실제 서비스에서 계산 로직 호출
        List<Promotion> list = promotionService.getActivePromotionList();
        Promotion target = list.stream()
                .filter(p -> p.getPromotionId().equals(id))
                .findFirst()
                .orElse(null);

        int finalPrice = promotionService.calculateDiscountedPrice(price, target);

        Map<String, Object> result = new HashMap<>();
        result.put("originalPrice", price);
        result.put("finalPrice", finalPrice);
        result.put("appliedPromotion", target != null ? target.getPromotionTitle() : "없음");
        return result;
    }
}