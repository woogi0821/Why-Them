package com.whythem.shop.product.mapper;

import com.whythem.shop.product.vo.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ProductMapper {
    ProductVO findById(Long productId);// 상품 상세 조회
    List<ProductVO> getProductList(@Param("categoryId") Long categoryId,
                                   @Param("memberId")Long memberId);//상품 목록조회(카테고리별 필터링)
}