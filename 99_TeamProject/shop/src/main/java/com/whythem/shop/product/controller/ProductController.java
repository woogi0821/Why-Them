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
     * 배너가 있고 NEW/BEST 섹션이 있는 메인 화면
     */
    @GetMapping("/")
    public String customerMain(Model model) {
        // 메인에는 모든 상품을 가져와서 index.jsp에 뿌려줍니다.
        List<ProductVO> productList = productService.getProductList(null);
        model.addAttribute("productList", productList);
        return "index";
    }

    /**
     * 2. 카테고리별 리스트 페이지 (product/category.jsp)
     * 각 카테고리 메뉴를 눌렀을 때 나오는 페이지
     */
    @GetMapping("/product/category")
    public String categoryPage(@RequestParam("categoryId") Long categoryId, Model model) {

        // 해당 카테고리 상품만 조회
        List<ProductVO> productList = productService.getProductList(categoryId);
        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);

        // 카테고리 이름 매칭 (아래에 정의된 getCategoryName 메서드 사용)
        String categoryName = getCategoryName(categoryId);
        model.addAttribute("categoryName", categoryName);

        // 수정된 경로: product 폴더 안의 category.jsp
        return "product/product_category";
    }

    /**
     * 3. 상품 상세 페이지 (product/product_detail.jsp)
     */
    @GetMapping("/product/detail")
    public String productDetail(@RequestParam("productId") Long productId, Model model) {
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