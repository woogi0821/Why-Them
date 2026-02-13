package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentVO {
    private Long paymentId;       // PK
    private Long orderId;         // FK
    private String paymentMethod; // PK     // 결제방법
    private Double amount;                  // 최종결제금액
    private String status;                  // 결제상태
    private LocalDateTime paidAt;           // 결제완료일
    private LocalDateTime createdAt;
}
