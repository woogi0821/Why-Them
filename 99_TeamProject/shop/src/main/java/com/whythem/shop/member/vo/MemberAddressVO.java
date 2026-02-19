package com.whythem.shop.member.vo;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MemberAddressVO {
    private Long addressId; //PK
    private Long memberId; //FK
    private String addressName;
    private String recipientName;
    private String recipientPhone;
    private String zipCode;
    private String baseAddress;
    private String detailAddress;
    private String isDefault;
}
