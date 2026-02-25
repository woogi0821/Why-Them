package com.whythem.shop.cart.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CartVO {
    private Long cartId; //PK
    private Long memberId; //FK
    private Date createdAt;
    private Date updatedAt;

}
