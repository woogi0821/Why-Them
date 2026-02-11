package com.whythem.shop.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author : GGG
 * @fileName : Criteria
 * @since : 2024-04-02 description :
 *      공통 클래스
 *      페이징처리 목적
 *      전자정부 프레임워크에서 가져옴
 *      일부 수정
 */
@Getter
@Setter
@ToString
public class Criteria {
    /** 검색조건 */
    private String searchCondition = "";

    /** 검색Keyword */
    private String searchKeyword = "";

    /** 검색사용여부 */
    private String searchUseYn = "";

    /** 현재페이지(초기값) */
    private int page=0;

    /** 페이지갯수: 화면에 보일 행 개수(초기값) */
    private int size=3;

    /** 오프셋 */
    private int offset;
    /** 총페이지 수 */
    private int totalPages;

    private String insertTime;

    private String updateTime;

    // 현재 페이지
    private int pageNum;

    // 페이지당 데이터 수
    private int amount;

    public Criteria() {
        this.pageNum = 1;
        this.amount = 10;
    }

    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    /**
     * ✅ 오프셋 자동 계산
     * number = 1 → offset = 0
     * number = 2 → offset = 3
     * number = 3 → offset = 6
     */
    public void calculateOffset() {
        if (page < 1) page = 1;
        if (size < 1) size = 3;

        this.offset = (page - 1) * size;
    }

    /** 총페이지 수 자동 계산 */
    public void calculateTotalPage(int totalNumber) {
        if (totalNumber < 0) totalNumber = 0;

        this.totalPages=(int)Math.ceil((double)totalNumber/size);
    }

    /**
     * ✅ pageIndex 변경되면 바로 계산되도록 추가
     */
    public void setPageOffset(int page) {
        this.page = page;
        calculateOffset();
    }

    /**
     * ✅ pageUnit 변경되어도 자동 계산되도록 추가
     */
    public void setSizeOffset(int size) {
        this.size = size;
        calculateOffset();
    }
}
