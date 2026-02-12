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
        log.info("==========================");

        assertThat(resultFail).isNull();
        assertThat(resultSuccess).isNotNull();
    }

    @Test
    @Transactional
    void resetPassword() {
        log.info("테스트 회원가입 시작");
        MemberVO newMember = new MemberVO();
        newMember.setLoginId("testreset12");
        newMember.setLoginPw("test1234");
        newMember.setMemberName("홍길동");
        newMember.setPhoneNumber("010-7777-7777");
        newMember.setEmail("test@tset.com");

        memberService.joinMember(newMember);
        log.info("회원가입 완료");

        log.info("비밀번호 변경 실행");
        String newPw = "test5678";

        MemberVO checkMember = memberService.getMemberById("testreset12");
        log.info("=============================================");
        log.info(">>> 내가 입력한 새 비밀번호 : {}", newPw);
        log.info(">>> DB에 저장된 암호화 값 : {}", checkMember.getLoginPw());
        log.info("=============================================");

        memberService.resetPassword("testreset12","홍길동","010-7777-7777","test5678");
        log.info("비밀번호 변경 로직 실행완료");

        log.info("변경된 비밀번호 로그인 테스트");
        MemberVO loginAttempt = new MemberVO();
        loginAttempt.setLoginId("testreset12");
        loginAttempt.setLoginPw(newPw);
        MemberVO loginResult = memberService.loginMember(loginAttempt);
        assertThat(loginResult).isNotNull();
        log.info("변경된 비밀번호 로그인 성공");

        log.info("변경전 비밀번호 로그인 실패 테스트");
        MemberVO oldLoginAttempt = new MemberVO();
        oldLoginAttempt.setLoginId("testreset12");
        oldLoginAttempt.setLoginPw("test1234");

        try {
            memberService.loginMember(oldLoginAttempt);
        } catch (Exception e) {
            log.info("변경전 비밀번호 로그인 실패 테스트 성공",e.getMessage());
        }
    }
}