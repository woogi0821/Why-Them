package com.whythem.shop.member.mapper;

import com.whythem.shop.member.vo.MemberAddressVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberAddressMapper {
    int insertAddress(MemberAddressVO addressVO);
}
