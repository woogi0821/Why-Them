package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.ProductMapper;
import com.whythem.shop.product.vo.ProductVO;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ProductService {
    private final ProductMapper productMapper;

    public ProductService(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }
//상품 목록 가져오기
    public List<ProductVO> getProductList(Long categoryId) {
        return productMapper.getProductList(categoryId);
    }
// 상세조회
    public ProductVO findById(Long productId) {
        return productMapper.findById(productId);
    }

}