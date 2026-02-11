package com.whythem.shop.member.service;

import com.whythem.shop.member.vo.MemberVO;
import lombok.extern.log4j.Log4j2;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.in;

@Log4j2
@SpringBootTest
@Transactional
class MemberServiceTest {
    @Autowired
    private MemberService memberService;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Test
    void joinMember() {
        MemberVO newMember = new MemberVO();
        newMember.setLoginId("logTestUser");
        newMember.setLoginPw("test1234");
        newMember.setMemberName("테스터");
        newMember.setPhoneNumber("010-7777-7777");
        newMember.setEmail("test@test.com");

        memberService.joinMember(newMember);
        MemberVO dbMember = memberService.getMemberById("logTestUser");

        log.info("===============================");
        log.info("입력한 평문 비번 : {}","test1234");
        log.info("DB암호화 비번 : {}", dbMember.getLoginPw());
        log.info("===============================");

        assertThat(dbMember.getLoginPw()).isNotEqualTo("test1234");
        assertThat(dbMember.getLoginPw()).startsWith("$2a$");
    }

    @Test
    void loginMember() {
        MemberVO newMember = new MemberVO();
        newMember.setLoginId("logTestUser");
        newMember.setLoginPw("test1234");
        newMember.setMemberName("테스터");
        newMember.setEmail("test@test.com");
        newMember.setPhoneNumber("010-0000-0000");
        memberService.joinMember(newMember);

        MemberVO inputWrong = new MemberVO();
        inputWrong.setLoginId("logTestUser");
        inputWrong.setLoginPw("wrongPw");
        MemberVO resultFail = memberService.loginMember(inputWrong);

        MemberVO inputCorrect = new MemberVO();
        inputCorrect.setLoginId("logTestUser");
        inputCorrect.setLoginPw("test1234");

        MemberVO resultSuccess = memberService.loginMember(inputCorrect);

        log.info("==========================");
        log.info("로그인 실패 결과 : {}",resultFail);
        log.info("로그인 성공 결과 : {}",resultSuccess);

        assertThat(resultFail).isNull();
        assertThat(resultSuccess).isNotNull();
    }
}