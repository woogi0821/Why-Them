package com.whythem.shop.member.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(exclude = "loginPw")
public class MemberVO {
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
