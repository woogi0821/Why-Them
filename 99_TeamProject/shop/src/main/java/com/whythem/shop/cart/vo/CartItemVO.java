package com.whythem.shop.cart.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CartItemVO {
    private Long cartItemId; //PK
    private Long cartId;  //FK
    private Long productId;
    private Integer quantity;
    private Date createdAt;

    private String productName;
    private Long price;
    private String imageUrl;
    private String brandName;
}
