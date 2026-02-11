package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderVO {
    private Long orderId;            // PK
    private Long memberId;           // FK
    private Double totalPrice;
    private String status;
    private LocalDateTime createdAt;

//  주문 상세 리스트
//    private List<OrderItemVO> orderItemsVOS;
}
