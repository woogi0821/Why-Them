package com.whythem.shop.promotion.controller;

import com.whythem.shop.promotion.service.PromotionService;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class PromotionController {
    private final PromotionService promotionService;


    // 관리자용 프로모션 상세 조회
    @GetMapping("/admin/promotion/{promotionId}")
    public String promotionDetail(
            @PathVariable Long promotionId,
            Model model
    ) {
        Promotion promotion = promotionService.getPromotion(promotionId);

        model.addAttribute("promotion", promotion);
        return "admin/promotion/detail";
    }

    // 프로모션 종료 처리
    @PostMapping("/end")
    public String endPromotion(@RequestParam("promotionId") Long promotionId) {
        promotionService.endPromotion(promotionId);
        return "redirect:/admin/promotion" + promotionId;  // 종료 후 목록으로 이동
    }
}
