package com.whythem.shop.common;

import com.whythem.shop.member.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class DevLoginInterceptor implements HandlerInterceptor {
    @Value("${shop.dev-login}")
    private boolean isDevMode;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        if (!isDevMode){
            return true;
        }
        HttpSession session = request.getSession();

        if (session.getAttribute("loginMember") == null){
            MemberVO dummy = new MemberVO();
            dummy.setLoginId("devUser");
            dummy.setMemberName("개발자");
            dummy.setMemberGrade("Y");

            session.setAttribute("loginMember", dummy);
            System.out.println("개발모드 사용중 자동로그인 완료");
        }
        return true;
    }
}
