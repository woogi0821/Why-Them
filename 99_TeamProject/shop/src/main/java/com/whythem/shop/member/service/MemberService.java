package com.whythem.shop.member.service;

import com.whythem.shop.member.mapper.MemberMapper;
import com.whythem.shop.member.vo.MemberVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MemberService {
    private final MemberMapper memberMapper;

    public int joinMember(MemberVO memberVO){
        return memberMapper.joinMember(memberVO);
    }

    public MemberVO loginMember(MemberVO memberVO){
        return memberMapper.loginMember(memberVO);
    }

    public int checkId(String loginId){
        return memberMapper.checkId(loginId);
    }
}
