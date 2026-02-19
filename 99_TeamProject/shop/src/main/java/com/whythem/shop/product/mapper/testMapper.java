package com.whythem.shop.product.mapper;

import com.whythem.shop.product.vo.testvo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface testMapper {
    List<testvo> getTestList(@Param("categoryId")Long categoryId);// 상품 목록조회(카테고리별 필터링)
    testvo findById(Long productId);// 상품 상세 조회
}
