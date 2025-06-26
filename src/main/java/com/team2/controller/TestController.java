package com.team2.controller;

import com.team2.model.CustomerVO;
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
        return "order/testLogin"; // JSP 경로: /WEB-INF/views/order/testLogin.jsp
    }

    @PostMapping("/login")
    public String doTestLogin(HttpSession session, String customerId, Model model) {
        // 단순 테스트용: 입력된 ID를 그대로 세션에 저장하여 로그인 상태를 모의한다.
        try {
            int id = Integer.parseInt(customerId);
            CustomerVO customer = new CustomerVO();
            customer.setCustomerId(id);
            customer.setCustomerName("테스트사용자" + id);
            session.setAttribute("loginCustomer", customer);
        } catch (NumberFormatException e) {
            CustomerVO customer = new CustomerVO();
            customer.setCustomerId(1);
            customer.setCustomerName("테스트사용자1");
            session.setAttribute("loginCustomer", customer);
        }
        return "redirect:/cart";
    }

    @GetMapping("/autologin")
    public String autoLogin(HttpSession session) {
        CustomerVO dummy = new CustomerVO();
        dummy.setCustomerId(1);
        dummy.setCustomerName("테스트사용자1");
        session.setAttribute("loginCustomer", dummy);
        return "redirect:/cart";
    }
} 