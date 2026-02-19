package com.whythem.shop.product.vo;

import lombok.*;

import java.util.Date;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@RequiredArgsConstructor
public class testvo {
    private Long productId;
    private Long categoryId;
    private String product_name;
    private int price;
    private int stock_quantity;
    private String description;
    private String status;
    private int view_count;
    private String imageUrl;
    private Date createdAt;
    private Date updatedAt;
    private String brandName;

}
