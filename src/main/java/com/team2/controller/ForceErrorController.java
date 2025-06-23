package com.team2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@ResponseBody
public class ForceErrorController {
    @GetMapping("/force_error")
    public void force_error(){
        System.out.println("request accepted");
        throw new RuntimeException("500 error");
    }
}
