package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.ProductMapper;
import com.whythem.shop.product.vo.ProductVO;
import com.whythem.shop.promotion.service.PromotionService;
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
     * 상품 목록 가져오기 (위시리스트 찜 여부 포함)
     * @param categoryId 카테고리 번호 (null일 경우 전체 조회)
     * @param memberId 로그인한 회원 ID (비로그인 시 0L)
     * @return 상품 리스트
     */
    public List<ProductVO> getProductList(Long categoryId, Long memberId) {
        return productMapper.getProductList(categoryId, memberId);
    }
    // [범인 검거] 여기에 있던 뜬금없는 '}' 를 삭제했습니다!

    /**
     * 상품 상세 조회
     * 상세 페이지 진입 시 조회수(ViewCount)를 1 증가시킨 후 데이터를 가져옵니다.
     * @param productId 상품 고유 번호
     * @return 상품 상세 정보
     */
    @Transactional // 조회수 증가와 조회를 하나의 작업 단위로 묶음
    public ProductVO findById(Long productId) {
        // 1. 조회수 증가 처리
        productMapper.updateViewCount(productId);

        ProductVO product = productMapper.findById(productId);

        // 3. [추가] 프로모션이 있으면 할인가 계산 (나의 작업분)
        if (product != null && product.getPromotion() != null) {
            int salePrice = promotionService.calculateDiscountedPrice(product.getPrice(), product.getPromotion());
            // [중요!] 계산된 할인가를 객체에 세팅합니다.
            product.setSalePrice(salePrice);

            System.out.println("할인가 세팅 완료: " + product.getSalePrice());
        }

        // 4. [변경] 모든 로직이 끝난 후 최종 결과 리턴
        return product;
    }

    // 메인페이지, weekly best 상품수 정하기 (memberId 파라미터 추가!)
    public List<ProductVO> getWeeklyBest(int limit, Long memberId) {
        return productMapper.getWeeklyBest(limit, memberId);
    }

    // 메인페이지, new arrivals 상품수 정하기 (memberId 파라미터 추가!)
    public List<ProductVO> getNewArrivals(int limit, Long memberId) {
        return productMapper.getNewArrivals(limit, memberId);

    }
}