package com.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/test")
public class TestController {

    @GetMapping("/login")
    public String testLoginPage() {
        return "testLogin"; // /WEB-INF/views/testLogin.jsp
    }

    @PostMapping("/login")
    public String doTestLogin(HttpSession session, String customerId, Model model) {
        // 간단 테스트: 아무 아이디나 입력하면 해당 ID로 로그인 처리 (실제 회원 검증 생략)
        try {
            int id = Integer.parseInt(customerId);
            session.setAttribute("loginCustomerId", id);
        } catch (NumberFormatException e) {
            // 숫자 아니면 1로 고정
            session.setAttribute("loginCustomerId", 1);
        }
        return "redirect:/cart";
    }
} 