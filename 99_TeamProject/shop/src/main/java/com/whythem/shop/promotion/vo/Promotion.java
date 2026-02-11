package com.whythem.shop.promotion.vo;

import lombok.*;

import java.time.LocalDate;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
@Getter
@Setter

public class Promotion {

    private Long promotionId;      // 프로모션 ID (PK)
    private String promotionTitle;   // 프로모션명

    private String discountType;    // 할인 타입 (RATE, PRICE)
    private int discountValue;      // 할인 값

    private LocalDate startDate;    // 시작일
    private LocalDate endDate;      // 종료일

    private String isActive;
    private String status;          // READY, ACTIVE, END
}
