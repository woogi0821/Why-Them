package com.whythem.shop.cart.controller;

import com.whythem.shop.cart.service.CartService;
import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.member.vo.MemberVO; // MemberVO 임포트 필요
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

    // 1. 장바구니 담기
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

        long totalPrice = 0;
        for (CartItemVO item : list) {
            totalPrice += (item.getPrice() * item.getQuantity());
        }

        model.addAttribute("cartList", list);
        model.addAttribute("totalPrice", totalPrice);

        return "cart/cart_list";
    }

    // 3. 수량 변경
    @PostMapping("/update")
    public String update(@RequestParam("cartItemId") Long cartItemId,
                         @RequestParam("quantity") int quantity,HttpSession session) {

        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }

        cartService.updateQuantity(cartItemId, quantity);
        return "redirect:/cart/list";
    }

    //4.삭제
    @PostMapping("/remove")
    public String remove(@RequestParam("cartItemId") Long cartItemId,
                         HttpSession session) {

        if (session.getAttribute("loginMember") == null) {
            return "redirect:/member/login";
        }

        cartService.removeCartItem(cartItemId);
        return "redirect:/cart/list";
    }

    @PostMapping("/addAjax")
    @ResponseBody
    public Map<String, Object> addCartAjax(@RequestParam Long productId,
                                           @RequestParam(defaultValue = "1") int quantity,
                                           HttpSession session){
        Map<String, Object> resultMap = new HashMap<>();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) {
            resultMap.put("status","login");
            return resultMap;
        }
        CartItemVO cartItemVO = new CartItemVO();
        cartItemVO.setProductId(productId);
        cartItemVO.setQuantity(quantity);

        cartService.addCart(loginMember.getMemberId(),cartItemVO);
        int currentCartCount = cartService.getMyCartList(loginMember.getMemberId()).size();
        session.setAttribute("cartCount",currentCartCount);
        resultMap.put("status","success");
        resultMap.put("cartCount",currentCartCount);
        return resultMap;
    }
}