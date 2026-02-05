package com.whythem.shop.product.mapper;

import com.whythem.shop.product.vo.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ProductMapper {
    // 1. 기존 메서드 (유지)
    List<ProductVO> getProductList();
    void insertProduct(ProductVO product);

    // 2. 상세보기 및 수정/삭제를 위해 새로 추가하는 메서드들
    ProductVO findById(Long productId);

    void updateProduct(ProductVO product);

    void deleteProduct(Long productId);

    void deleteProductImages(Long productId);

    // 3. 여러 장의 이미지를 저장하기 위해 추가한 메서드
    void insertProductImage(@Param("productId") Long productId,
                            @Param("imageUrl") String imageUrl,
                            @Param("isMain") String isMain);
    List<ProductVO> getProductList(@Param("categoryId") Long categoryId);

}