package com.whythem.shop.admin.mapper;

import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.admin.vo.TestVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface TestMapper {
    List<TestVO> getTestProductList(@Param("categoryId") Long categoryId);
    TestVO findTestProductById(Long productId);
    void insertTestProduct(TestVO product);
    void updateTestProduct(TestVO product);
    void deleteTestProduct(Long productId);

}
