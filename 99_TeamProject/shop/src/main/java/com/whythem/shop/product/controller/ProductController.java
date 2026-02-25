package com.whythem.shop.product.controller;

import com.whythem.shop.member.vo.MemberVO;
import com.whythem.shop.product.service.ProductService;
import com.whythem.shop.product.vo.ProductVO;
import com.whythem.shop.wishlist.service.WishlistService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequiredArgsConstructor // 생성자 자동 생성 (의존성 주입 해결)
public class ProductController {

    private final ProductService productService;
    private final WishlistService wishlistService; // 위시리스트 서비스 정상 연결

    /**
     * 1. 메인 페이지 (index.jsp)
     */
    @GetMapping("/")
    public String customerMain(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        // 1. 신상품 / 베스트 상품 각각 4개씩 가져오기
        List<ProductVO> newList = productService.getNewArrivals(4, memberId);
        List<ProductVO> bestList = productService.getWeeklyBest(4, memberId);

        // 2. 로그인한 회원이라면 찜 여부(wished) 확인해서 하트 불 켜주기
        if (memberId != 0L) {
            List<Long> myWishedProductIds = wishlistService.getWishlistProductIds(memberId);

            if (myWishedProductIds != null && !myWishedProductIds.isEmpty()) {
                // 신상품 찜 체크
                for (ProductVO p : newList) {
                    if (myWishedProductIds.contains(p.getProductId())) {
                        p.setWished(true);
                    }
                }
                // 베스트 상품 찜 체크
                for (ProductVO p : bestList) {
                    if (myWishedProductIds.contains(p.getProductId())) {
                        p.setWished(true);
                    }
                }
            }
        }

        // ★ 3. JSP가 기다리는 데이터 최종 전송! (팀장님이 찾으시던 그 부분!)
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
    public String productDetail(@RequestParam("productId") Long productId, Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        Long memberId = (loginMember == null) ? 0L : loginMember.getMemberId();

        // 서비스에 memberId도 같이 던져서 'isWished' 상태까지 한 번에 가져오게 수정합니다.
        ProductVO product = productService.findById(productId, memberId);

        model.addAttribute("product", product);
        // 이제 별도의 isWished 변수 없이 ${product.wished}로 JSP에서 바로 쓸 수 있습니다.

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