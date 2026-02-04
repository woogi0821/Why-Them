package com.whythem.shop.member.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
    private Long memberId; //PK
    private String loginId;
    private String loginPw;
    private String memberName;
    private String email;
    private String phoneNumber;
    private LocalDateTime createdAt;
    private String status;
    private String memberGrade;

}
