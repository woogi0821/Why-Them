package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PromotionServiceImpl implements PromotionService {
    private final PromotionMapper promotionMapper;

    @Override
    public Promotion getPromotion(Long promotionId) {
        Promotion promotion = promotionMapper.selectPromotion(promotionId);

        if (promotion == null) {
            return null;
        }
        if ("N".equals(promotion.getIsActive())) {
            promotion.setStatus("END");
            return promotion;
        }

        String status = calculateStatus(
                promotion.getStartDate(),
                promotion.getEndDate()
        );

        promotion.setStatus(status);
        return promotion;
    }

    @Override
    public void endPromotion(Long promotionId) {
        promotionMapper.updatePromotionStatus(promotionId);
    }
    private String calculateStatus(LocalDate startDate, LocalDate endDate) {
        LocalDate today = LocalDate.now();

        if (today.isBefore(startDate)) {
            return "READY";
        }

        if (today.isAfter(endDate)) {
            return "END";
        }
        return "ACTIVE";
    }
    @Override
    public List<Promotion> getPromotionList(Criteria criteria) {

        criteria.calculateOffset();

        List<Promotion> list = promotionMapper.selectPromotionList(criteria);

        LocalDate today = LocalDate.now();

        for (Promotion promotion : list) {
            promotion.setStatus(calculateStatus(promotion)); // 여기만 추가
        }
        return list;
    }
    @Override
    public int getPromotionTotalCount(Criteria criteria) {
        return promotionMapper.selectPromotionTotalCount(criteria);
    }
    private String calculateStatus(Promotion promotion) {

        if ("N".equals(promotion.getIsActive())) {
            return "END";
        }

        LocalDate today = LocalDate.now();

        if (today.isBefore(promotion.getStartDate())) {
            return "READY";
        }

        if (today.isAfter(promotion.getEndDate())) {
            return "END";
        }

        return "ACTIVE";
    }
}
