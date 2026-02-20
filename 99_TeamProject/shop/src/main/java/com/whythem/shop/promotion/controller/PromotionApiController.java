//package com.whythem.shop.promotion.controller; // 본인의 패키지 경로에 맞게 수정
//
//import com.whythem.shop.promotion.service.PromotionService;
//import com.whythem.shop.promotion.vo.Promotion;
//import lombok.RequiredArgsConstructor;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/promotions")
//@RequiredArgsConstructor
//public class PromotionApiController {
//
//    private final PromotionService promotionService;
//
//    @GetMapping("/active")
//    public List<Promotion> getActivePromotions() {
//        return promotionService.getActivePromotionList();
//    }
//}