package com.whythem.shop.member.mapper;

import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.member.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberAddressMapper {
    List<MemberAddressVO> selectAddressList(Long memberId); //배송지 목록을 전부 조회함 ->배송지 목록이 얼마든지 늘어날수있기때문에 List사용
    int insertAddress(MemberAddressVO memberAddressVO); //주소가 잘 입력됐는지 보고만 받음 = int 결과값이 0아니면 1임
    int updateAddress(MemberAddressVO memberAddressVO);
    int deleteAddress(MemberAddressVO memberAddressVO);
    int resetDefaultAddress(Long memberId);
    int setDefaultAddress(Long addressId);
    MemberAddressVO selectAddressOne(Long addressId); //받을 값이 객체이기때문에 선언도 객체부터

}
