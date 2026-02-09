package com.whythem.shop.promotion.vo;

import java.time.LocalDate;

public class Promotion {

    private Long promotionId;      // 프로모션 ID (PK)
    private String promotionName;   // 프로모션명

    private String discountType;    // 할인 타입 (RATE, PRICE)
    private int discountValue;      // 할인 값

    private LocalDate startDate;    // 시작일
    private LocalDate endDate;      // 종료일

    private String status;          // READY, ACTIVE, END

    // 기본 생성자
    public Promotion() {
    }

    // getter / setter
    public Long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Long promotionId) {
        this.promotionId = promotionId;
    }

    public String getPromotionName() {
        return promotionName;
    }

    public void setPromotionName(String promotionName) {
        this.promotionName = promotionName;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public int getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(int discountValue) {
        this.discountValue = discountValue;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
