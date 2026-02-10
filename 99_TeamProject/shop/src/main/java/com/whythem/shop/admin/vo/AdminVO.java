package com.whythem.shop.admin.vo;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;
import java.util.Date;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@RequiredArgsConstructor
public class AdminVO {
    // 1. DB 매칭 필드 (상품 등록, 수정, 관리자용 상세 페이지 출력용)
    private Long productId;
    private Long categoryId;
    private String name;           // DB: PRODUCT_NAME
    private String brandName;      // DB: BRAND_NAME
    private int price;
    private int stockQuantity;
    private String description;
    private String status;
    private int viewCount;
    private String imageUrl;       // DB: IMAGE_URL (저장된 파일 경로)

    // 2. 관리 데이터 (등록일, 수정일)
    private Date createdAt;
    private Date updatedAt;

    // 3. 파일 업로드 전용 필드 (관리자 등록/수정 페이지에서 파일 받을 때 필수)
    private MultipartFile productImage;
}