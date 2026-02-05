package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.ProductMapper;
import com.whythem.shop.product.vo.ProductVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductService {
    private final ProductMapper productMapper;

    public ProductService(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }

    public List<ProductVO> getProductList(Long categoryId) {
        return productMapper.getProductList(categoryId);
    }

    public ProductVO findById(Long productId) {
        return productMapper.findById(productId);
    }

    @Transactional
    public void registerProduct(ProductVO product, List<String> savedPaths) {
        // 1. 상품 기본 정보 저장 (CBI_PRODUCT)
        productMapper.insertProduct(product);

        // 2. 다중 이미지 정보 저장 (CBI_PRODUCT_IMAGE)
        // savedPaths가 null이면 이 블록은 실행되지 않음
        if (savedPaths != null && !savedPaths.isEmpty()) {
            for (int i = 0; i < savedPaths.size(); i++) {
                String isMain = (i == 0) ? "T" : "F";
                productMapper.insertProductImage(product.getProductId(), savedPaths.get(i), isMain);
            }
        }
    }

    @Transactional
    public void updateProduct(ProductVO product) {
        productMapper.updateProduct(product);
    }

    @Transactional
    public void deleteProduct(Long productId) {
        productMapper.deleteProductImages(productId);
        productMapper.deleteProduct(productId);
    }
}