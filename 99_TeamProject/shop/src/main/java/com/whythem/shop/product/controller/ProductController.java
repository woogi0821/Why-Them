package com.whythem.shop.product.controller;

import com.whythem.shop.product.service.ProductService;
import com.whythem.shop.product.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class ProductController {
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/") // 이제 주소는 이거 하나면 충분합니다!
    public String customerMain(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {

        // 1. 상품 리스트 가져오기 (categoryId가 null이면 전체, 아니면 필터링)
        List<ProductVO> productList = productService.getProductList(categoryId);
        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);

        // 2. 카테고리 이름 매칭 (기본값 설정)
        String categoryName = "ALL COLLECTIONS";

        // categoryId가 null이 아닐 때만 이름 변경 로직 실행
        if (categoryId != null) {
            if (categoryId == 1) categoryName = "COAT";
            else if (categoryId == 2) categoryName = "SHIRTS";
            else if (categoryId == 3) categoryName = "SWEATER";
            else if (categoryId == 4) categoryName = "PANTS";
            else if (categoryId == 5) categoryName = "SKIRTS";
            else if (categoryId == 6) categoryName = "DRESS";
            else if (categoryId == 7) categoryName = "SUIT";
            else if (categoryId == 8) categoryName = "SHOSES";
            else if (categoryId == 9) categoryName = "SANDALS";
            else if (categoryId == 10) categoryName = "BAG";
            else if (categoryId == 11) categoryName = "HAT";
        }

        // 3. JSP로 전달
        model.addAttribute("categoryName", categoryName);

        return "index";
    }
    @GetMapping("/product/detail")
    public String productDetail(@RequestParam("productId") Long productId, Model model) {

        // 만약 AdminService에 있는 메서드를 그대로 쓰고 싶다면 타입만 맞춰주세요.
        // (AdminVO와 Product 클래스가 호환되거나 같은 것이라면 가능)
        ProductVO product = productService.findById(productId);

        model.addAttribute("product", product);

        // 리턴 경로를 "product/product_detail"로 설정 (WEB-INF/views/product/product_detail.jsp)
        return "product/product_detail";
    }

}