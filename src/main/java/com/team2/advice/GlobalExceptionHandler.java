package com.team2.advice;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

import org.slf4j.Logger; // Logger 임포트
import org.slf4j.LoggerFactory; // LoggerFactory 임포트

@ControllerAdvice
public class GlobalExceptionHandler {

    // 로거 인스턴스 생성
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    // 404 처리 (존재하지 않는 URL 요청 시)
    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleNotFound(Exception ex, Model model) {
        logger.warn("404 Not Found Exception 발생: {}", ex.getMessage()); // WARN 레벨로 로그 남기기
        model.addAttribute("errorMessage", "페이지를 찾을 수 없습니다.");
        return "error/404";
    }

    // 500 처리 (모든 예외)
    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleException(Exception ex, Model model) {
        logger.error("서버 내부 오류 발생: ", ex); // ERROR 레벨로 로그 남기기, 예외 스택 트레이스 포함
        model.addAttribute("errorMessage", "서버 내부 오류가 발생했습니다.");
        return "error/500";
    }
}
