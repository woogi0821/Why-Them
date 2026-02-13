package com.whythem.shop.product.controller;

import com.whythem.shop.product.service.ProductService;
import com.whythem.shop.product.vo.ProductVO;
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
     * - 메인 섹션용 베스트 4개와 일반 목록을 함께 조회합니다.
     */
    @GetMapping("/")
    public String customerMain(Model model) {
        // 메인페이지에서의 weekly best 상품수
        List<ProductVO> bestList = productService.getWeeklyBest(4);
        model.addAttribute("bestList", bestList);
        // 메인페이지에서의 new arrivals 상품수
        List<ProductVO> newList = productService.getNewArrivals(4);
        model.addAttribute("newList", newList);
        // [메인용] 일반 상품 전체 목록
        List<ProductVO> productList = productService.getProductList(null);
        model.addAttribute("productList", productList);

        return "index";
    }

    /**
     * 2. Weekly Best 전체보기 페이지 (product/weekly_best.jsp)
     * - [수정사항] 'View All' 클릭 시 전용 베스트 페이지로 이동합니다.
     */
    @GetMapping("/product/best/all")
    public String viewAllBest(Model model) {
        // 조회수가 높은 순서대로 전체 상품 리스트 조회
        List<ProductVO> bestAllList = productService.getWeeklyBest(8);

        // JSP에서 사용할 수 있도록 데이터를 모델에 담기
        model.addAttribute("bestAllList", bestAllList);
        model.addAttribute("pageTitle", "WEEKLY BEST ALL");

        // [수정된 경로] product 폴더 안의 weekly_best.jsp 호출
        return "product/weekly_best";
    }

    /**
     * 3. 카테고리별 리스트 페이지 (product/product_category.jsp)
     */
    @GetMapping("/product/category")
    public String categoryPage(
            @RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {
        List<ProductVO> productList = productService.getProductList(categoryId);
        model.addAttribute("productList", productList);
        model.addAttribute("categoryName", getCategoryName(categoryId));

        return "product/product_category";
    }
    @GetMapping("/product/new/all")
    public String viewAllNew(Model model) {
        // New Arrivals 전체보기용 8개 추출
        List<ProductVO> newList = productService.getNewArrivals(8);

        model.addAttribute("bestAllList", newList);
        model.addAttribute("categoryName", "NEW ARRIVALS");

        return "product/new_arrivals";
    }

    /**
     * 4. 상품 상세 페이지 (product/product_detail.jsp)
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

        // intValue()로 변환하여 switch문 처리
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