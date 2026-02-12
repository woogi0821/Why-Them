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
    //CommonException이 있는데 trt/catch를 쓴 이유
    //비밀번호 변경시 비즈니스 로직때문인데 변경중 이름이나 전화번호를 틀렸을때
    //Exception으로 에러를 잡을경우 정보 입력이 초기화가 되므로(페이지 이동이 일어남)
    // 비밀번호,주소변경은 try/catch를 사용 -> UX디테일을 챙김
    @PostMapping("/resetPw")
    public String resetPassword(
            String loginId,
            String memberName,
            String phoneNumber,
            String newPw,
            String from,
            RedirectAttributes rttr){
        try {
            memberService.resetPassword(loginId,memberName,phoneNumber,newPw);
            rttr.addFlashAttribute("msg","비밀번호가 성공적으로 변경되었습니다.");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg","변경 실패" + e.getMessage());
            if ("mypage".equals(from)) return "redirect:/member/mypage#password-section";
            else return "redirect:/";
        }
        if ("mypage".equals(from)) return "redirect:/member/mypage";
        else return "redirect:/";
    }
    @PostMapping("/address/save")
    public String saveAddress(MemberAddressVO addressVO,
           @RequestParam(value = "from",required = false,defaultValue = "mypage")
           String from,HttpSession session,RedirectAttributes rttr){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null){
            return "redirect:/member/login";
        }
        addressVO.setMemberId(loginMember.getMemberId());
        try {
            memberAddressService.addAddress(addressVO);
            rttr.addFlashAttribute("msg","배송지가 성공적으로 저장되었습니다.");
        } catch (Exception e){
            log.error("배송지 저장 중 오류 발생",e);
            rttr.addFlashAttribute("msg","배송지 저장 중 오류가 발생했습니다.");
            if ("order".equals(from)) return "redirect:/oredr/checkout";
            else return "redirect:/member/mypage";
        }
        if ("order".equals(from)){
            rttr.addFlashAttribute("newAddId", addressVO.getAddressId());
            return "redirect:/order/checkout";
        }else {
            return "redirect:/member/mypage#address-section";
        }
    }
123


}

