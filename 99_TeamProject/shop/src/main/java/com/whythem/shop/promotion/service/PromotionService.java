package com.whythem.shop.promotion.service;

import com.whythem.shop.promotion.vo.Promotion;

public interface PromotionService {
    Promotion getPromotion(Long promotionId);

    void endPromotion(Long promotionId);
}
