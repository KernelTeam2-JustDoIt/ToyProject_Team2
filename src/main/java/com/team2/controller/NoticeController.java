package com.team2.controller;

import com.team2.dto.notice.NoticeDTO;
import com.team2.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    // 메인 배너에서 최신 공지 타이틀 조회
    @GetMapping("/latest")
    public String getLatestNotice(Model model) {
        NoticeDTO latestNotice = noticeService.getLatestNotice();
        model.addAttribute("latestNotice", latestNotice);
        return "main"; // main.jsp에 출력용
    }

    // 공지사항 상세
    @GetMapping("/{noticeId}")
    public String noticeDetail(@PathVariable int noticeId, Model model) {
        NoticeDTO notice = noticeService.getNoticeDetail(noticeId);

        if (notice.getPostedAt() != null) {
            String formattedPostedAt = notice.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            model.addAttribute("formattedPostedAt", formattedPostedAt);
        }

        model.addAttribute("notice", notice);
        return "noticeDetail"; // noticeDetail.jsp
    }

    // 공지 목록
    @GetMapping("/list")
    public String noticeList(Model model) {
        model.addAttribute("noticeList", noticeService.getNoticeList());
        return "noticeList"; // noticeList.jsp
    }
    //공지사항 작성
    @PostMapping("/add")
    public String insertNotice(@ModelAttribute NoticeDTO notice, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        // 세션에 로그인 정보가 없거나, 관리자 권한이 아닌 경우
        if (admin == null || !admin.getRoleId().equals("ADMIN")) {
            return "redirect:/login"; // 또는 "error/unauthorized.jsp"
        }

        // 작성자 정보 입력
        notice.setWriterAdminId(admin.getAdminId());
        noticeService.insertNotice(notice);
        return "redirect:/notice/list";
    }

}
