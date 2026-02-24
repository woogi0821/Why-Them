package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PaymentVO {
    private Long paymentId;             // PK
    private Long orderId;               // FK
    private String paymentMethod;       // PK
    private Double amount;
    private String status;
    private LocalDateTime paidAt;
    private LocalDateTime createdAt;

    // 필드 추가
    private List<Long> cartItemIds;
    private String cartItemIdsStr;
}
