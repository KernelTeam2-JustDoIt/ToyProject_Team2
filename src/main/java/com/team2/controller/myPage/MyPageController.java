package com.team2.controller.myPage;

import com.team2.model.CustomerVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/myPage")
public class MyPageController {

    @GetMapping("")
    public String showMyPageMain(HttpSession session){
        // login 한 사용자인지 확인
        // TODO loginUser DTO 를 따로 만들어서 세션에 저장해도 될까? id 만 저장하면 부족할 수도?
        CustomerVO customer = (CustomerVO) session.getAttribute("loginCustomer");
        // login 안 돼있으면 login 페이지로 redirect
        if(customer == null){
            return "redirect:/login";
        }
        return "myPage/myPage";
    }
}
