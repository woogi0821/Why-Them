package com.whythem.shop.common;

import com.whythem.shop.cart.service.CartService;
import com.whythem.shop.member.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class CartInterceptor implements HandlerInterceptor {
    @Autowired
    private CartService cartService;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler){
        HttpSession session = request.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        if (loginMember != null){
            int cartCount = cartService.getMyCartList(loginMember.getMemberId()).size();
            session.setAttribute("cartCount",cartCount);
        } else {
            session.setAttribute("cartCount",0);
        }
        return true;
    }
}
