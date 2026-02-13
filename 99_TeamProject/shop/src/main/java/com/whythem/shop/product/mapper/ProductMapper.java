package com.whythem.shop.product.mapper;

import com.whythem.shop.product.vo.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ProductMapper {

    // 1. 상품 상세 조회 (상세 페이지용)
    ProductVO findById(Long productId);

    // 2. 상품 목록 조회 (카테고리별 필터링 포함)
    List<ProductVO> getProductList(@Param("categoryId") Long categoryId);
    // weekly best 메인페이지, weekly best페이지 상품수 정하기
    List<ProductVO> getWeeklyBest(int limit);
    // new arrivals 메인페이지, new arrivals페이지 상품수 정하기
    List<ProductVO> getNewArrivals(@Param("limit") int limit);

    // 5. 조회수 증가 (상세 페이지 호출 시 사용하여 조회수 올림)
    void updateViewCount(Long productId);
}