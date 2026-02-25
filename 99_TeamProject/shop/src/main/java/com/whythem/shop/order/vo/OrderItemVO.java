package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderItemVO {
    private Long orderItemId;   // PK
    private Long orderId;       // FK
    private Long productId;     // FK
    private int quantity;
    private Double price;
}
