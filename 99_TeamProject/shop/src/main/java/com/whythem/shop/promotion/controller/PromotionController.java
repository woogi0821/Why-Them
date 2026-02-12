package com.whythem.shop.promotion.controller;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.service.PromotionService;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class PromotionController {
    private final PromotionService promotionService;

    /**
     * 관리자용 프로모션 상세 조회
     */
    @GetMapping("/admin/promotion/{promotionId}")
    public String promotionDetail(@PathVariable Long promotionId, Model model) {
        Promotion promotion = promotionService.getPromotion(promotionId);
        model.addAttribute("promotion", promotion);
        return "admin/promotion/detail";
    }

    /**
     * 프로모션 강제 종료 처리
     */
    @PostMapping("/admin/promotion/end")
    public String endPromotion(@RequestParam Long promotionId) {
        promotionService.endPromotion(promotionId);
        return "redirect:/admin/promotion/list";
    }

    /**
     * 프로모션 목록 조회 (통합 Criteria 적용)
     */
    @GetMapping("/admin/promotion/list")
    public String promotionList(Criteria criteria, Model model) {

//         전체 데이터 개수를 먼저 가져옵니다.
        int totalCount = promotionService.getPromotionTotalCount(criteria);


        // 이 메서드가 호출되면서 offset, startPage, endPage 등이 모두 계산됩니다.
        criteria.calculatePaging(totalCount);

        //  계산된 offset이 담긴 criteria를 넘겨서 목록을 조회합니다.
        List<Promotion> list = promotionService.getPromotionList(criteria);

        // 뷰로 전달 (이제 PageVO를 따로 생성하지 않고 criteria를 넘깁니다)
        model.addAttribute("list", list);
        model.addAttribute("criteria", criteria); // JSP에서 criteria.startPage 등으로 사용

        return "admin/promotion/list";
    }
    /**
     * 프로모션 등록 페이지(입력 폼)로 이동
     * 경로: /admin/promotion/register
     */
    @GetMapping("/admin/promotion/register")
    public String createPromotionView() {
        // admin/promotion(폴더명), register(jsp명)
        return "admin/promotion/register";
    }
    /**
     * 프로모션 실제 저장 처리
     * @ModelAttribute: JSP 폼의 name값들을 Promotion 객체에 자동으로 담아줍니다.
     */
    @PostMapping("/admin/promotion/add")
    public String insert(@ModelAttribute Promotion promotion, RedirectAttributes rttr) {
        promotionService.insertPromotion(promotion);

        // 리다이렉트 후 JSP에서 사용할 수 있는 일회성 데이터를 전달합니다.
        rttr.addFlashAttribute("msg", "INSERT_SUCCESS");

        // 목록 페이지로 돌아가기 (이때 최신 글이 제일 위에 보이도록 ORDER BY promotion_id DESC 필수)
        return "redirect:/admin/promotion/list";
    }
}
