package com.whythem.shop.member.vo;

import lombok.*;
import java.time.LocalDateTime;


/**
 * * [참고] implements Serializable
 * - 추후 AWS 등 클라우드 환경(다중 서버) 배포 시 세션 클러스터링을 위해 필요함.
 * - Redis에 객체를 저장하거나 서버 간 세션 이동 시 직렬화(Serialization)가 필수.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "loginPw")
@EqualsAndHashCode(of = "memberId")
public class MemberVO /* implements Serializable */ {

    // 직렬화 버전 ID (implements Serializable 활성화 시 주석 해제)
    //private static final long serialVersionUID = 1L;
    private Long memberId;
    private String loginId;
    private String loginPw;
    private String memberName;
    private String email;
    private String phoneNumber;
    private LocalDateTime createdAt;
    private String status;
    private String memberGrade;
}
