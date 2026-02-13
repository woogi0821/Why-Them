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
     * 배너가 있고 NEW/BEST 섹션이 있는 메인 화면
     */
    @GetMapping("/")
    public String customerMain(Model model, HttpSession session) {
        // 1. 로그인 여부 확인 (세션에서 꺼내기)
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        // 2. memberId 구하기
        // - 로그인을 안 했으면(null) -> 0L (DB에서 0번 회원은 없으므로 찜 안 한 걸로 처리됨)
        // - 로그인을 했으면 -> 그 사람의 memberId 사용
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        // 3. 서비스 호출 (매개변수 2개로 변경됨!)
        // 첫 번째 null: 카테고리 구분 없이 전체 상품 조회 (메인 페이지용)
        // 두 번째 memberId: 찜 여부 확인용
        List<ProductVO> productList = productService.getProductList(null, memberId);

        model.addAttribute("productList", productList);
        return "index";
    }

    /**
     * 2. 카테고리별 리스트 페이지 (product/category.jsp)
     * 각 카테고리 메뉴를 눌렀을 때 나오는 페이지
     */
    @GetMapping("/product/category")
    public String categoryPage(@RequestParam("categoryId") Long categoryId, Model model, HttpSession session) { // [1] 세션 추가

        // [2] 로그인한 사용자 ID 구하기 (찜 여부 확인용)
        // - 로그인을 안 했으면 0L, 했으면 실제 ID
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        // [3] 서비스 호출 (이제 파라미터 2개를 넘겨야 빨간 줄이 사라집니다!)
        // - 첫 번째: 어떤 카테고리 상품을 보여줄지
        // - 두 번째: 누가 찜했는지 확인할지
        List<ProductVO> productList = productService.getProductList(categoryId, memberId);

        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);

        // 카테고리 이름 매칭
        String categoryName = getCategoryName(categoryId);
        model.addAttribute("categoryName", categoryName);

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