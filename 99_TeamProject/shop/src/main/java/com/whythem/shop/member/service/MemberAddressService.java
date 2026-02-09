package com.whythem.shop.member.service;

import com.whythem.shop.member.mapper.MemberAddressMapper;
import com.whythem.shop.member.vo.MemberAddressVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MemberAddressService {
    private final MemberAddressMapper addressMapper;
    public List<MemberAddressVO> getAddressList(Long memberId){
        return addressMapper.selectAddressList(memberId);
    }
    @Transactional
    public void addAddress(MemberAddressVO addressVO){
        if ("Y".equals(addressVO.getIsDefault())){
            addressMapper.resetDefaultAddress(addressVO.getMemberId());
        }
        addressMapper.insertAddress(addressVO);
    }
    @Transactional
    public void updateAddress(MemberAddressVO addressVO){
        if ("Y".equals(addressVO.getIsDefault())){
            addressMapper.resetDefaultAddress(addressVO.getMemberId());
        }
        addressMapper.updateAddress(addressVO);
    }
}
