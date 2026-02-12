package com.whythem.shop.promotion.service;

import com.whythem.shop.common.Criteria;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest      // 스프링부트 테스트 하겠다는 표시
@Log4j2
class PromotionServiceTest {
    @Autowired
    PromotionService promotionService;
    @Test
    void getPromotionList() {
//        테스트 코드: 패턴이 정해져있음: 추천 코드 작성
//        1) 준비: 매개변수들에 가짜 값 넣기
        Criteria criteria=new Criteria();
        criteria.setSearchKeyword(""); // 테스트용 검색어 넣기
//      TODO: 아래 2개 추가하세요 (페이징 조건)
        criteria.setOffset(3);         // 오프셋 넣기(자료의 순번)
        criteria.setSize(3);           // 화면에 보일 개수
//        2) 실행-> 부서 배열
        List<?> list= promotionService.getPromotionList(criteria);
//        3) 결과확인
        log.info(list);
    }
}