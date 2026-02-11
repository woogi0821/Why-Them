package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.vo.Promotion;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface PromotionService {
    Promotion getPromotion(Long promotionId);

    void endPromotion(Long promotionId);

    List<Promotion> getPromotionList(Criteria criteria);

    int getPromotionTotalCount(Criteria criteria);
}
