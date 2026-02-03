package com.whythem.shop.vo.member;

import com.whythem.shop.member.mapper.MemberAddressMapper;
import com.whythem.shop.member.mapper.MemberMapper;
import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.member.vo.MemberVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;


@SpringBootTest
@Transactional
@Log4j2
class MemberVOTest {

    @Autowired
    private MemberMapper memberMapper;
    @Autowired
    private MemberAddressMapper memberAddressMapper;

    @Test
    @DisplayName("회원가입 및 로그인 테스트")
    void joinAndAddAddressTest() {
        MemberVO member = new MemberVO();
        member.setLoginId("test01");
        member.setLoginPw("test01");
        member.setEmail("test@test.com");
        member.setPhoneNumber("010-0000-0000");
        member.setStatus("Y");
        member.setCreatedAt(LocalDateTime.now());
        member.setMemberGrade("N");

        memberMapper.joinMember(member);
        Long memberId = member.getMemberId();

        log.info("\nID: {} \nUser: {}\nPw: {}\nEmail: {}\nPhone: {}\nCreatedAt: {}\nStatus: {}\nMemberGrade:{}\n",
                member.getMemberId(),
                member.getLoginId(),
                member.getLoginPw(),
                member.getEmail(),
                member.getPhoneNumber(),
                member.getCreatedAt(),
                member.getStatus(),
                member.getMemberGrade()
        );

        MemberAddressVO address = new MemberAddressVO();
        address.setMemberId(memberId);
        address.setAddressName("집");
        address.setRecipientName("신재욱");
        address.setRecipientPhone("010-0000-0000");
        address.setZipCode("123456");
        address.setBaseAddress("부산시 어딘가");
        address.setDetailAddress("101동 101호");

        memberAddressMapper.insertAddress(address);

        log.info("\n[Address Info Added]\nMemberID: {}\nAddrName: {}\nRecipient: {}\nPhone: {}\nZip: {}\nBaseAddr: {}\nDetail: {}\n",
                address.getMemberId(),
                address.getAddressName(),
                address.getRecipientName(),
                address.getRecipientPhone(),
                address.getZipCode(),
                address.getBaseAddress(),
                address.getDetailAddress()
        );

        MemberVO login = new MemberVO();
            login.setLoginId("test01");
            login.setLoginPw("test02");
        MemberVO loginResult = memberMapper.loginMember(login);
        if(loginResult !=null){
            log.info("로그인성공: {}",loginResult.getLoginId());
        }else {
            log.info("로그인실패");
        }
    }
}