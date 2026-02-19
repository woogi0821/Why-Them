package com.whythem.shop.product.controller;

import com.whythem.shop.member.vo.MemberVO;
import com.whythem.shop.product.service.ProductService;
import com.whythem.shop.product.vo.ProductVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    /**
     * 1. 메인 페이지 (index.jsp)
     */
    @GetMapping("/")
    public String customerMain(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        // [수정된 부분]
        // 기존의 getProductList(null, memberId) 대신,
        // 상품팀이 만든 전용 메서드를 사용해서 각각 4개씩 가져옵니다.
        List<ProductVO> newList = productService.getNewArrivals(4, memberId);
        List<ProductVO> bestList = productService.getWeeklyBest(4, memberId);

        // JSP가 애타게 찾던 그 이름표(newList, bestList)를 달아서 보냅니다.
        model.addAttribute("newList", newList);
        model.addAttribute("bestList", bestList);

        return "index";
    }

    /**
     * 2. Weekly Best 전체보기 페이지 (product/weekly_best.jsp)
     * [수정 완료] 주석에 맞게 /product/best/all 경로로 복구하고 memberId 추가!
     */
    @GetMapping("/product/best/all")
    public String viewAllBest(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        List<ProductVO> bestList = productService.getWeeklyBest(8, memberId);

        model.addAttribute("bestAllList", bestList);
        model.addAttribute("categoryName", "WEEKLY BEST");

        return "product/weekly_best";
    }

    /**
     * 3. 카테고리별 리스트 페이지 (product/product_category.jsp)
     * [수정 완료] 중복된 2개의 메서드를 하나로 깔끔하게 합쳤습니다!
     */
    @GetMapping("/product/category")
    public String categoryPage(
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            Model model, HttpSession session) {

        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        List<ProductVO> productList = productService.getProductList(categoryId, memberId);

        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);
        model.addAttribute("categoryName", getCategoryName(categoryId));

        return "product/product_category";
    }

    /**
     * 4. New Arrivals 전체보기 페이지 (product/new_arrivals.jsp)
     * [수정 완료] memberId 파라미터 추가!
     */
    @GetMapping("/product/new/all")
    public String viewAllNew(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        List<ProductVO> newList = productService.getNewArrivals(8, memberId);

        model.addAttribute("bestAllList", newList);
        model.addAttribute("categoryName", "NEW ARRIVALS");

        return "product/new_arrivals";
    }

    /**
     * 5. 상품 상세 페이지 (product/product_detail.jsp)
     */
    @GetMapping("/product/detail")
    public String productDetail(@RequestParam("productId") Long productId, Model model) {
        // 서비스 내부에서 조회수 증가(updateViewCount) 후 데이터를 가져옴
        ProductVO product = productService.findById(productId);
        model.addAttribute("product", product);

        return "product/product_detail";
    }

    /**
     * [도우미 메서드] 카테고리 ID를 영어 이름으로 변환
     */
    private String getCategoryName(Long categoryId) {
        if (categoryId == null) return "ALL COLLECTIONS";

        switch (categoryId.intValue()) {
            case 1:  return "COAT";
            case 2:  return "SHIRTS";
            case 3:  return "SWEATER";
            case 4:  return "PANTS";
            case 5:  return "SKIRTS";
            case 6:  return "DRESS";
            case 7:  return "SUIT";
            case 8:  return "SHOES";
            case 9:  return "SANDALS";
            case 10: return "BAG";
            case 11: return "HAT";
            default: return "COLLECTION";
        }
    }
}