package com.team2.controller;

import com.team2.dto.notice.NoticeDTO;
import com.team2.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;

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

//        if (notice.getPostedAt() != null) {
//            String formattedPostedAt = notice.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
//            model.addAttribute("formattedPostedAt", formattedPostedAt);
//        }
        if (notice.getPostedAt() != null) {
            Date postedAt = notice.getPostedAt();  // java.util.Date
            // 포맷터 생성 (스레드 세이프하지 않으므로, 메서드 로컬로 두는 게 안전)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String formattedPostedAt = sdf.format(postedAt);
            model.addAttribute("formattedPostedAt", formattedPostedAt);
        }

        model.addAttribute("notice", notice);
        return "noticeDetail"; // noticeDetail.jsp
    }

    // 공지 목록
    @GetMapping("/list")
    public String noticeList(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        int blockSize = 5;
        int offset = (page - 1) * pageSize;

        // 전체 게시물 수, 전체 페이지 수 계산
        int totalCount = noticeService.countNotices();
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);


        // 페이징 블록 처리
        int currentBlock = (int) Math.ceil((double) page / blockSize);
        int startPage = (currentBlock - 1) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPages);

        // ✅ 페이징 적용해서 공지 목록 조회
        List<NoticeDTO> noticeList = noticeService.getNoticeList(offset, pageSize);

        // 날짜 포맷 변환
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        for (NoticeDTO notice : noticeList) {
//            if (notice.getPostedAt() != null) {
//                notice.setFormattedDate(notice.getPostedAt().format(formatter));
//            }
//        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for (NoticeDTO notice : noticeList) {
            Date postedAt = notice.getPostedAt();  // java.util.Date 타입
            if (postedAt != null) {
                // Date → String 포맷팅
                notice.setFormattedDate(sdf.format(postedAt));
            }
        }
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        model.addAttribute("hasPrevBlock", startPage > 1);
        return "noticeList";
    }

    //공지사항 작성
//    @PostMapping("/add")
//    public String insertNotice(@ModelAttribute NoticeDTO notice, HttpSession session) {
//        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");
//
//        // 세션에 로그인 정보가 없거나, 관리자 권한이 아닌 경우
//        if (admin == null || !admin.getRoleId().equals("ADMIN")) {
//            return "redirect:/login"; // 또는 "error/unauthorized.jsp"
//        }
//
//        // 작성자 정보 입력
//        notice.setWriterAdminId(admin.getAdminId());
//        noticeService.insertNotice(notice);
//        return "redirect:/notice/list";
//    }

}
