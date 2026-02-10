package com.whythem.shop.promotion.service;

import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

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

        String status = calculateStatus(
                promotion.getStartDate(),
                promotion.getEndDate()
        );

        promotion.setStatus(status);
        return promotion;
    }

    @Override
    public void endPromotion(Long promotionId) {
        promotionMapper.updatePromotionStatus(promotionId, "END");
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

}
