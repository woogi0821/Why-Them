package com.whythem.shop.wishlist.controller;

import com.whythem.shop.member.vo.MemberVO;
import com.whythem.shop.wishlist.service.WishlistService;
import com.whythem.shop.wishlist.vo.WishlistVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/wishlist")
@RequiredArgsConstructor
public class WishlistController {
    private final WishlistService wishlistService;

    @GetMapping("/list")
    public String wishlistPage(HttpSession session, Model model){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }
        Long memberId = loginMember.getMemberId();

        List<WishlistVO> list = wishlistService.getMyWishlist(memberId);
        long totalPrice = wishlistService.getTotalPrice(memberId);
        model.addAttribute("wishlist",list);
        model.addAttribute("totalPrice",totalPrice);
        return "wishlist/list";
    }
    @PostMapping("/toggle")
    @ResponseBody
    public String toggleWishlist(WishlistVO wishlistVO,HttpSession session){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "login";
        }
        wishlistVO.setMemberId(loginMember.getMemberId());
        String result = wishlistService.toggleWishlist(wishlistVO);

        return result;
    }
    @PostMapping("/remove")
    @ResponseBody
    public String removeWishlist(@RequestParam Long wishId){
        int result = wishlistService.removeWishlist(wishId);
        return result > 0 ? "ok" : "fail";
    }
    @PostMapping("/removeAll")
    @ResponseBody
    public String removeAllWishlist(HttpSession session){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "fail";
        }
        int result = wishlistService.removeAllWishlist(loginMember.getMemberId());
        return result > 0 ? "ok" : "fail";
    }
}
