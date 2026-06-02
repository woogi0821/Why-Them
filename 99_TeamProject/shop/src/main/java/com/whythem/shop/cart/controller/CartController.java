package com.whythem.shop.cart.controller;

import com.whythem.shop.cart.service.CartService;
import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.member.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    // 1. 장바구니 담기 (폼 방식)
    @PostMapping("/add")
    public String addCart(CartItemVO cartItemVO, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
        cartService.addCart(loginMember.getMemberId(), cartItemVO);
        return "redirect:/cart/list";
    }

    // 2. 내 장바구니 목록 보기
    @GetMapping("/list")
    public String cartList(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        List<CartItemVO> list = cartService.getMyCartList(loginMember.getMemberId());
        long totalPrice = cartService.calculateTotalPrice(list);

        model.addAttribute("cartList", list);
        model.addAttribute("totalPrice", totalPrice);

        return "cart/cart_list";
    }

    // 3. 수량 변경 (폼 방식 - 기존 유지)
    @PostMapping("/update")
    public String update(@RequestParam("cartItemId") Long cartItemId,
                         @RequestParam("quantity") int quantity, HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        cartService.updateQuantity(cartItemId, quantity);
        return "redirect:/cart/list";
    }

    // 4. 수량 변경 (AJAX 방식) ← 신규 추가
    @PostMapping("/updateAjax")
    @ResponseBody
    public Map<String, Object> updateAjax(@RequestParam("cartItemId") Long cartItemId,
                                          @RequestParam("quantity") int quantity,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        if (session.getAttribute("loginMember") == null) {
            result.put("status", "login");
            return result;
        }

        // 수량 유효성 검사 (1~99)
        if (quantity < 1 || quantity > 99) {
            result.put("status", "invalid");
            return result;
        }

        cartService.updateQuantity(cartItemId, quantity);
        result.put("status", "success");
        return result;
    }

    // 5. 삭제
    @PostMapping("/remove")
    public String remove(@RequestParam("cartItemId") Long cartItemId,
                         HttpSession session) {
        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }
        cartService.removeCartItem(cartItemId);
        return "redirect:/cart/list";
    }

    // 6. 장바구니 담기 (AJAX 방식) - 중복 상품 수량 합산 처리 포함
    @PostMapping("/addAjax")
    @ResponseBody
    public Map<String, Object> addCartAjax(@RequestParam Long productId,
                                           @RequestParam(defaultValue = "1") int quantity,
                                           HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) {
            resultMap.put("status", "login");
            return resultMap;
        }

        CartItemVO cartItemVO = new CartItemVO();
        cartItemVO.setProductId(productId);
        cartItemVO.setQuantity(quantity);

        cartService.addCart(loginMember.getMemberId(), cartItemVO);

        // 헤더 표시용 카트 개수 갱신
        int currentCartCount = cartService.getMyCartList(loginMember.getMemberId()).size();
        session.setAttribute("cartCount", currentCartCount);

        resultMap.put("status", "success");
        resultMap.put("cartCount", currentCartCount);
        return resultMap;
    }
}
