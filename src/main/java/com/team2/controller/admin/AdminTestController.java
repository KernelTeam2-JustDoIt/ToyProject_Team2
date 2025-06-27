// AdminTestController.java
package com.team2.controller.admin;

import com.team2.dto.Admin.AdminDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class AdminTestController {

    @GetMapping("/admin/login-test")
    public String simulateAdminLogin(HttpSession session) {
        AdminDTO dummyAdmin = new AdminDTO();
        dummyAdmin.setAdminId(1001);
        dummyAdmin.setRoleId(1); // 1 = 관리자
        session.setAttribute("loginAdmin", dummyAdmin);

        return "redirect:/"; // 로그인 후 공지사항 목록으로 리다이렉트
    }

}
