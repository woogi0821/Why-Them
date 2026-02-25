package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.ProductMapper;
import com.whythem.shop.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductMapper productMapper;

    /**
     * 상품 목록 가져오기
     */
    public List<ProductVO> getProductList(Long categoryId, Long memberId) {
        return productMapper.getProductList(categoryId, memberId);
    }

    /**
     * 상품 상세 조회 (조회수 증가 + 위시리스트 체크 + 프로모션 계산)
     */
    @Transactional
    public ProductVO findById(Long productId, Long memberId) {
        // 1. 조회수 증가 처리
        productMapper.updateViewCount(productId);

        // 2. 상품 상세 정보 조회
        ProductVO product = productMapper.findById(productId);

        if (product != null) {
            // 3. 위시리스트 여부 세팅
            product.setWished(checkWishStatus(productId, memberId));

            // 4. 프로모션 할인가 계산
            if (product != null && product.getPromotion() != null) {
                int salePrice = promotionService.calculateDiscountedPrice(product.getPrice(), product.getPromotion());
                product.setSalePrice(salePrice);
            }
        }
        return product;
    }

    /**
     * 위시리스트 여부 확인 헬퍼 메서드
     */
    private boolean checkWishStatus(Long productId, Long memberId) {
        if (memberId == null || memberId == 0) return false;

        // 목록 조회 기능을 활용해 현재 상품의 wished 상태를 확인
        List<ProductVO> list = productMapper.getProductList(null, memberId);
        return list.stream()
                .anyMatch(p -> p.getProductId().equals(productId) && p.isWished());
    }

    /**
     * Weekly Best 조회
     */
    public List<ProductVO> getWeeklyBest(int limit, Long memberId) {
        return productMapper.getWeeklyBest(limit, memberId);
    }

    /**
     * New Arrivals 조회
     */
    public List<ProductVO> getNewArrivals(int limit, Long memberId) {
        return productMapper.getNewArrivals(limit, memberId);
    }

}