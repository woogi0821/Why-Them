package com.whythem.shop.product.vo;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;

@Data
public class ProductVO {
    // 1. DB 매칭 필드
    private Long productId;
    private Long categoryId;
    private String name;           // DB: PRODUCT_NAME
    private String brandName;      // ★ [복구 완료] DB: BRAND_NAME
    private int price;
    private int stockQuantity;
    private String description;
    private String status;
    private int viewCount;
    private String imageUrl;       // DB: IMAGE_URL

    private Date createdAt;
    private Date updatedAt;

    // 2. 파일 업로드용
    private MultipartFile productImage;
}
