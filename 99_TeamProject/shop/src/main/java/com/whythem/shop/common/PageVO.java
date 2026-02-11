package com.whythem.shop.common;

public class PageVO {

    private int startPage;
    private int endPage;
    private boolean prev;
    private boolean next;

    private int total;
    private Criteria criteria;

    public PageVO(Criteria criteria, int total) {
        this.criteria = criteria;
        this.total = total;

        int pageSize = 10;

        this.endPage = (int) (Math.ceil(criteria.getPageNum() / (double) pageSize) * pageSize);
        this.startPage = this.endPage - pageSize + 1;

        int realEnd = (int) Math.ceil(total / (double) criteria.getAmount());

        if (realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        this.prev = this.startPage > 1;
        this.next = this.endPage < realEnd;
    }

    // getter만 생성 (setter는 필요 없음)
    public int getStartPage() { return startPage; }
    public int getEndPage() { return endPage; }
    public boolean isPrev() { return prev; }
    public boolean isNext() { return next; }
    public int getTotal() { return total; }
    public Criteria getCriteria() { return criteria; }

}
