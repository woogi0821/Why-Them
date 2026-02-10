package com.whythem.shop.member.controller;

import com.whythem.shop.member.service.MemberAddressService;
import com.whythem.shop.member.service.MemberService;
import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.member.vo.MemberVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@Log4j2
public class MemberController {

    private final MemberService memberService;
    private final MemberAddressService memberAddressService;

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
    public String loginProcess(MemberVO memberVO, HttpSession session, RedirectAttributes rttr){

        MemberVO loginResult = memberService.loginMember(memberVO);

        if (loginResult != null){
            session.setAttribute("loginMember", loginResult);
            session.setMaxInactiveInterval(60 * 30);
            return "redirect:/";
        } else {
            log.info(">>> 로그인 실패");
            rttr.addFlashAttribute("msg", "아이디 또는 비밀번호를 확인해주세요.");
            return "redirect:/member/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/idCheck")
    @ResponseBody
    public int idCheck(@RequestParam("loginId") String loginId){
        return memberService.checkId(loginId);
    }
    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login?msg=session_expired";
        }
        MemberVO myInfo = memberService.getMemberById(loginMember.getLoginId());
        model.addAttribute("myInfo",myInfo);
        List<MemberAddressVO> addressList = memberAddressService.getAddressList(loginMember.getMemberId());
        model.addAttribute("addressList",addressList);
        return "member/mypage";
    }
    @PostMapping("/update")
    public String updateMember(MemberVO member,HttpSession session){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }
            member.setLoginId(loginMember.getLoginId());
            memberService.updateMember(member);
            loginMember.setMemberName(member.getMemberName());
            loginMember.setPhoneNumber(member.getPhoneNumber());
            loginMember.setEmail(member.getEmail());
            session.setAttribute("loginMember",loginMember);
            return "redirect:/member/mypage";
        }
}
