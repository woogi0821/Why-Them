package com.whythem.shop.order.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartVO {
    private Long cartId;
    private Long memberId;
    private Date createdAt;
    private Date updatedAt;

    private List<CartItemVO> cartItems;
}
