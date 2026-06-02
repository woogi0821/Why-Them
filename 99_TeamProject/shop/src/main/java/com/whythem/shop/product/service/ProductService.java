package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.ProductMapper;
import com.whythem.shop.product.vo.ProductVO;
import com.whythem.shop.promotion.service.PromotionService; // ★ 임포트 확인
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductMapper productMapper;
    private final PromotionService promotionService;

    /**
     * 상품 목록 가져오기 (수정됨: 할인가 계산 추가)
     */
    public List<ProductVO> getProductList(Long categoryId, Long memberId) {
        List<ProductVO> list = productMapper.getProductList(categoryId, memberId);

        // ★ [추가] 리스트를 돌면서 할인가를 계산해서 채워넣습니다!
        applyPromotionToList(list);

        return list;
    }

    /**
     * 상품 상세 조회
     */
    @Transactional
    public ProductVO findById(Long productId, Long memberId) {
        productMapper.updateViewCount(productId);
        ProductVO product = productMapper.findById(productId);

        if (product != null) {
            product.setWished(checkWishStatus(productId, memberId));

            // 상세 페이지용 단건 계산 로직
            if (product.getPromotion() != null) {
                int salePrice = promotionService.calculateDiscountedPrice(product.getPrice(), product.getPromotion());
                product.setSalePrice(salePrice);
            }
        }
        return product;
    }

    /**
     * Weekly Best 조회 (수정됨: 할인가 계산 추가)
     */
    public List<ProductVO> getWeeklyBest(int limit, Long memberId) {
        List<ProductVO> list = productMapper.getWeeklyBest(limit, memberId);
        applyPromotionToList(list); // ★ 추가
        return list;
    }

    /**
     * New Arrivals 조회 (수정됨: 할인가 계산 추가)
     */
    public List<ProductVO> getNewArrivals(int limit, Long memberId) {
        List<ProductVO> list = productMapper.getNewArrivals(limit, memberId);
        applyPromotionToList(list); // ★ 추가
        return list;
    }

    // ==========================================================
    //  [Helper Method] 중복되는 할인 계산 로직을 하나로 뺐습니다.
    // ==========================================================
    private void applyPromotionToList(List<ProductVO> list) {
        if (list == null) return;

        for (ProductVO product : list) {
            // 프로모션 정보가 있다면 계산기 돌려서 salePrice 세팅!
            if (product.getPromotion() != null) {
                int salePrice = promotionService.calculateDiscountedPrice(product.getPrice(), product.getPromotion());
                product.setSalePrice(salePrice);
            }
        }
    }

    // 위시리스트 체크 로직 (기존 유지)
    private boolean checkWishStatus(Long productId, Long memberId) {
        if (memberId == null || memberId == 0) return false;
        List<ProductVO> list = productMapper.getProductList(null, memberId);
        return list.stream()
                .anyMatch(p -> p.getProductId().equals(productId) && p.isWished());
    }

    public List<ProductVO> getAdminProductList() {
        return productMapper.getAdminProductList();
    }
}