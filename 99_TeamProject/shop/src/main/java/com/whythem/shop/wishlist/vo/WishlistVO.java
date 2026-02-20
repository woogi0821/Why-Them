package com.whythem.shop.wishlist.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode(of = "wishId")
public class WishlistVO {

    private Long wishId;
    private Long memberId;
    private Long productId;
    private Date createdAt;
    private String productName;
    private Long price;
    private String imageUrl;
}
