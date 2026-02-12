package com.whythem.shop.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 통합 페이징 관리 클래스
 * Criteria(조회 기준) + PageVO(화면 계산) 기능을 하나로 합침
 */
@Getter
@Setter
@ToString
public class Criteria {

    /* --- [1. DB 조회용 파라미터] --- */
    private int page;           // 현재 페이지 번호 (사용자 요청)
    private int size;           // 한 페이지에 보여줄 게시물 수
    private int offset;         // DB에서 건너뛸 행 개수 (page와 size로 계산)

    /* --- [2. 검색 및 필터 조건] --- */
    private String searchCondition = "";
    private String searchKeyword = "";
    private String status;      // 프로모션 상태 (READY, ACTIVE, END)

    /* --- [3. 화면 페이징 버튼 계산 결과] --- */
    private int total;          // 전체 데이터 개수
    private int startPage;      // 페이징 블록의 시작 번호
    private int endPage;        // 페이징 블록의 끝 번호
    private boolean prev, next; // 이전/다음 버튼 활성화 여부
    private int realEnd;        // 실제 마지막 페이지 번호

    // 기본 생성자: 초기값 설정
    public Criteria() {
        this.page = 1;
        this.size = 10; // 기본 10개씩 보기
    }

    /**
     * ✅ 핵심 메서드: 전체 개수를 전달받아 페이징에 필요한 모든 수치를 계산합니다.
     * 서비스에서 조회가 끝난 직후 또는 컨트롤러에서 호출합니다.
     */
    public void calculatePaging(int total) {
        this.total = total;

        // 1. DB 오프셋 계산: (현재페이지 - 1) * 페이지당 개수
        this.offset = (this.page - 1) * this.size;

        // 2. 화면 하단 끝 페이지 계산 (일반적으로 10개씩 보여줌)
        // 공식: ceil(현재페이지 / 10.0) * 10
        this.endPage = (int) (Math.ceil(this.page / 10.0) * 10);

        // 3. 화면 하단 시작 페이지 계산
        this.startPage = this.endPage - 9;

        // 4. 실제 전체 데이터 기준 마지막 페이지 계산
        this.realEnd = (int) (Math.ceil(total / (double) this.size));

        // 5. 끝 페이지 보정: 실제 마지막 페이지가 계산된 끝 페이지보다 작으면 변경
        if (this.realEnd < this.endPage) {
            this.endPage = this.realEnd;
        }

        // 6. 이전/다음 버튼 유무
        this.prev = this.startPage > 1;
        this.next = this.endPage < this.realEnd;
    }
}
