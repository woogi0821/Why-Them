package com.whythem.shop.member.mapper;

import com.whythem.shop.member.vo.MemberAddressVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberAddressMapper {
    List<MemberAddressVO> selectAddressList (Long memberId);
    int insertAddress(MemberAddressVO addressVO);
    int updateAddress(MemberAddressVO addressVO);
    int deleteAddress(MemberAddressVO addressVO);
    int resetDefaultAddress(Long memberId);
    int setDefaultAddress (Long addressId);
}
