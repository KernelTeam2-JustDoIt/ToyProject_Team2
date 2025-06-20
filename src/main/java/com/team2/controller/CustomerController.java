package com.team2.controller;


import com.team2.model.CustomerVO;
import com.team2.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @GetMapping("/customer")
    public String customer() {
        return "customer/join";
    }

    @GetMapping("/customer/login")
    public String customerLogin() {
        return "customer/login";
    }

    @PostMapping("/customer/join")
    public String registerCustomer(@ModelAttribute CustomerVO customer) {
        customerService.registerCustomer(customer);
        System.out.println(customer.getIsMarketingUseAgreed());
        return "redirect:/customer/login"; // 가입 후 로그인 페이지로 이동
    }
}
