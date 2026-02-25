package com.whythem.shop.common;

import lombok.extern.log4j.Log4j2;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
// 목적: Controller 클래스에서 발생하는 모든 에러는 이곳에서 처리가 됩니다.
// 왜 사용? 이것이 없다면 모든 Controller 에서 try/catch 작성하셔야 합니다.(함수별로)
@Log4j2
@ControllerAdvice   // 모든 Controller 클래스에서 에러를 가져오는(에러 발생이 있다면) 어노테이션
public class CommonException {

//  컨트롤러에서 어떤 에러가 발생하더라도 이 함수가 실행됨
    @ExceptionHandler(Exception.class)
    public String internalServerErrorException(Exception e
    		, Model model
    		) {
        String errors = e.getMessage();
        log.info("에러: " + errors);                // 밑에 결과창에 에러가 표시됨
        model.addAttribute("errors", errors);
        
        return "errors";                           // errors.jsp 로 에러 내용 전달
    }
}