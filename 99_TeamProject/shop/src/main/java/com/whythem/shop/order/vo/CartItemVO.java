package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartItemVO {
    private Long cartItemId;
    private Long cartId;
    private Long productId;
    private Integer quantity;
    private String sizeVal;
    private Date createdAt;

    private Double price;
}
