package com.whythem.shop.member.service;

import com.whythem.shop.member.mapper.MemberMapper;
import com.whythem.shop.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberMapper memberMapper;
    private final PasswordEncoder passwordEncoder;

    public int joinMember(MemberVO memberVO){
        String rawPassword = memberVO.getLoginPw();
        String encodedPassword = passwordEncoder.encode(rawPassword);
        memberVO.setLoginPw(encodedPassword);
        return memberMapper.joinMember(memberVO);
    }

    public MemberVO loginMember(MemberVO memberVO){
        MemberVO dbMember = memberMapper.selectMemberById(memberVO.getLoginId());
        if (dbMember == null) {
            throw new RuntimeException("존재하지 않는 아이디입니다.");
        }
        if (!passwordEncoder.matches(memberVO.getLoginPw(),dbMember.getLoginPw())){
            throw new RuntimeException("비밀번호가 일치하지 않습니다.");
        }
        return dbMember;
    }

    public int checkId(String loginId){
        return memberMapper.checkId(loginId);
    }
    public MemberVO getMemberById(String loginId){
        return memberMapper.selectMemberById(loginId);
    }
    public void updateMember(MemberVO member){
        memberMapper.updateMember(member);
    }
}
