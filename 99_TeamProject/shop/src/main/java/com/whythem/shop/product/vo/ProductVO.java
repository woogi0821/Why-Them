package com.whythem.shop.product.vo;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Data
public class ProductVO {
    private Long productId;
    private Long categoryId;
    private String name;
    private int price;
    private int stockQuantity;
    private String description;
    private String brandName;
    private String imageUrl; // 대표 이미지 경로

    // [추정] 다중 파일 업로드를 위한 필드
    private List<MultipartFile> productImages;
    // [기존] 수정 시 단일 파일을 위해 사용하던 필드 (유지)
    private MultipartFile productImage;
}
