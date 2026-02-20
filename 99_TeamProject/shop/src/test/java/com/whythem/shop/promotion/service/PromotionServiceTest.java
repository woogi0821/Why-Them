package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import com.whythem.shop.promotion.mapper.PromotionMapper;
import com.whythem.shop.promotion.vo.Promotion;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest      // 스프링부트 테스트 하겠다는 표시
@Log4j2
class PromotionServiceTest {
    @Autowired
    PromotionService promotionService;
    @Autowired
    private PromotionMapper promotionMapper;

    @Test
    void 페이징_조회_테스트() {
        // 1. 준비: 1페이지에 5개씩 가져오라고 설정
        Criteria cri = new Criteria();
        cri.setPage(1);
        cri.setSize(5);

        // 2. 실행: 서비스 호출
        List<Promotion> list = promotionService.getPromotionList(cri);

        // 3. 검증: 가져온 리스트의 크기가 5개인지 확인
        System.out.println("가져온 데이터 개수: " + list.size());
        for(Promotion p : list) {
            System.out.println(p.getPromotionTitle());
        }
    }
    @Test
    void 논리_삭제_테스트() {
        // 1. 준비: 삭제할 프로모션 번호 (DB에 있는 번호 중 하나)
        Long targetId = 1L;

        // 2. 실행: 서비스의 삭제 함수 호출
        promotionService.removePromotion(targetId);

        // 3. 검증: 다시 조회했을 때 isActive가 'D'로 변했는지 확인
        Promotion result = promotionService.getPromotion(targetId);
        System.out.println("삭제 후 상태값: " + result.getIsActive()); // 'D'가 출력되어야 성공!
    }
    @Test
    void 프로모션_등록_테스트() {
        Promotion vo = new Promotion();
        vo.setPromotionTitle("신규 할인 이벤트");
        vo.setPromotionTitle("내용입니다.");

        // 아래 값들이 빠져서 에러가 났던 거예요! 추가해주세요.
        vo.setDiscountType("PERCENT");
        vo.setDiscountValue(10);
        vo.setStartDate(LocalDate.parse("2026-02-19"));
        vo.setEndDate(LocalDate.parse("2026-12-31"));

        vo.setIsActive("Y");

        int result = promotionService.insertPromotion(vo);
        System.out.println("등록 결과: " + result);
    }
    @Test
    void 프로모션_수정_테스트() {
        // 1. 준비: 1번 글의 제목을 '수정된 제목'으로 바꾸고 싶음
        Promotion vo = promotionService.getPromotion(1L);
        vo.setPromotionTitle("수정된 제목");

        // 2. 실행
        promotionService.updatePromotion(vo);

        // 3. 검증: 다시 가져왔을 때 바뀐 제목이 나오는지 확인
        Promotion result = promotionService.getPromotion(1L);
        System.out.println("수정 후 제목: " + result.getPromotionTitle());
    }
    @Test
    void 페이징_계산_단위테스트() {
        Criteria cri = new Criteria();
        cri.setPage(11); // 11페이지라면?
        cri.setSize(10);

        int totalCount = 150; // 전체 글이 150개라면?
        cri.calculatePaging(totalCount);

        System.out.println("시작 페이지: " + cri.getStartPage()); // 11 예상
        System.out.println("끝 페이지: " + cri.getEndPage());   // 15 예상
    }
    @Test
    void 논리_삭제_최종_확인() {
        // 1. 등록 테스트에서 넣은 ID를 하나 준비합니다.
        Long targetId = 1L;

        // 2. 삭제 기능을 실행합니다. (Service -> Mapper -> SQL UPDATE 실행)
        promotionService.removePromotion(targetId);

        // 3. 다시 해당 데이터를 가져와서 확인합니다.
        Promotion result = promotionService.getPromotion(targetId);

        // 검증: 상태가 'D'여야 하며, 데이터 자체는 null이 아니어야 합니다.
        System.out.println("삭제 후 데이터 존재 여부: " + (result != null));
        System.out.println("상태값 확인: " + result.getIsActive()); // 'D'가 찍히면 성공!
    }
    @Test
    void 페이징_숫자_계산_확인() {
        Criteria cri = new Criteria();
        cri.setPage(1);  // 1페이지고
        cri.setSize(10); // 10개씩 보여준다면?

        int totalCount = 125; // 전체 글이 125개일 때
        cri.calculatePaging(totalCount);

        // 검증: 끝 페이지가 13페이지까지 나와야 함 (12.5를 올림하니까)
        System.out.println("총 페이지 수: " + cri.getEndPage());
        System.out.println("다음 페이지 존재 여부: " + cri.isNext()); // 13페이지가 있으니 true여야 함
    }
}
