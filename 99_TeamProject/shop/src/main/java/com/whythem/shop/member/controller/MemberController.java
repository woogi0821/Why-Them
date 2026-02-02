package com.whythem.shop.member.controller;

import com.whythem.shop.member.service.MemberService;
import com.whythem.shop.member.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Log4j2
public class MemberController {

    private final MemberService memberService;

    @GetMapping("/join")
    public String joinpage(){
        return "member/join";
    }

    @PostMapping("/join")
    public String joinProcess(MemberVO memberVO){
        int result = memberService.joinMember(memberVO);
        if (result > 0){
            return "redirect:/member/login";
        } else {
            return "redirect:/member/join?error=true";
        }
    }

    @GetMapping("/login")
    public String loginpage(){
        return "member/login";
    }

    @PostMapping("/login")
    public String loginProcess(MemberVO memberVO, HttpSession session){
        MemberVO loginResult = memberService.loginMember(memberVO);
        if (loginResult !=null){
            session.setAttribute("loginMember",loginResult);
            session.setMaxInactiveInterval(60 * 30);
            return "redirect:/";
        } else {
            return "redirect:/member/login";
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

}
