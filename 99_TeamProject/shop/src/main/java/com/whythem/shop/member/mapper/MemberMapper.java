package com.whythem.shop.member.mapper;

import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;


import java.util.List;

@Mapper
public interface MemberMapper {
    int joinMember(MemberVO memberVO);
    MemberVO getMemberById(Long memberId);
    List<MemberAddressVO> getMemberAddresses(Long memberId);
//    MemberAddressVO getDefaultAddress(Long memberId);
    MemberVO loginMember (MemberVO memberVO);
    int checkId (String loginId);
}
