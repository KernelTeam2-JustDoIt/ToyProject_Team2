package com.team2.controller;

import com.team2.dto.Admin.AdminDTO;
import com.team2.dto.notice.NoticeDTO;
import com.team2.service.NoticeService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    // 메인 배너에 노출할 메인 공지 조회
    @GetMapping("/main")
    public String getMainNotice(Model model) {
        NoticeDTO mainNotice = noticeService.getMainNotice();
        model.addAttribute("mainNotice", mainNotice); // 모델 이름은 유지하거나 mainNotice로 바꿔도 됨
        return "main"; // main.jsp에서 출력
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
        return "notice/noticeDetail"; // noticeDetail.jsp
    }

    // 공지 목록
    @GetMapping("/list")
    public String noticeList(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session) {
        int pageSize = 10;
        int blockSize = 5;
        int offset = (page - 1) * pageSize;

        // ✅ 관리자 여부 판단
        boolean isAdmin = false;
        AdminDTO loginAdmin = (AdminDTO) session.getAttribute("loginAdmin");
        if (loginAdmin != null && loginAdmin.getRoleId() == 1) {
            isAdmin = true;
        }

        // ✅ 파라미터 맵 구성
        Map<String, Object> param = new HashMap<>();
        param.put("limit", pageSize);
        param.put("offset", offset);
        param.put("isAdmin", isAdmin);


        // 전체 게시물 수, 전체 페이지 수 계산
        int totalCount = noticeService.countNotices(param);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 페이징 블록 처리
        int currentBlock = (int) Math.ceil((double) page / blockSize);
        int startPage = (currentBlock - 1) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPages);



        // ✅ 전체 공지 목록 (메인, 상단 포함)
        List<NoticeDTO> noticeList = noticeService.getNoticeList(param);


        // ✅ 상단 고정 공지
        List<NoticeDTO> pinnedNotices = noticeService.getPinnedNotices();


        // ✅ 날짜 포맷 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (NoticeDTO notice : noticeList) {
            if (notice.getPostedAt() != null) {
                notice.setFormattedDate(notice.getPostedAt().format(formatter));
            }
        }
        for (NoticeDTO pinned : pinnedNotices) {
            if (pinned.getPostedAt() != null) {
                pinned.setFormattedDate(pinned.getPostedAt().format(formatter));
            }
        }

        // 모델 등록
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("pinnedNotices", pinnedNotices);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasNextBlock", endPage < totalPages);
        model.addAttribute("hasPrevBlock", startPage > 1);

        return "notice/noticeList";
    }

    //공지사항 작성
    @PostMapping("/add")
    @Transactional
    public String insertNotice(@ModelAttribute NoticeDTO notice, HttpSession session) {
        // 임시 관리자 객체 생성 (추후 로그인 세션에서 꺼내는 방식으로 변경)
        AdminDTO admin = new AdminDTO();
        admin.setAdminId(1001);
        admin.setRoleId(1); // 1 = 관리자

        // 추후 교체 로그인기능 들어갔을때
        //  AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        // ✅ noticeStatus가 null 또는 비어있다면 기본값 설정
        if (notice.getNoticeStatus() == null || notice.getNoticeStatus().isEmpty()) {
            notice.setNoticeStatus("UNACTIVE");
        }
        // 세션에 로그인 정보가 없거나, 관리자 권한이 아닌 경우
        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }
        //추후 교체 로그인 기능 들어갔을때
//        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");
//        if (admin == null || admin.getRoleId() != 1) {
//            return "redirect:/login";
//        }


        // ✅ 메인 여부 체크박스가 선택되어 메인 공지로 등록될 경우 기존 메인 공지 해제
        if (notice.isMain()) {
            noticeService.unsetMainNotice();
        }

        // 작성 후 작성 된 게시글 보기
        notice.setWriterAdminId(admin.getAdminId());
        int newNoticeId = noticeService.insertNotice(notice); // 새 공지사항 등록 후 ID 반환
        return "redirect:/notice/" + newNoticeId; // 상세페이지로 이동
    }

        // 공지사항 작성 폼 이동
    @GetMapping("/form")
    public String showInsertForm(Model model) {
        model.addAttribute("notice", new NoticeDTO());
        return "notice/noticeForm"; // 작성 JSP 페이지
    }

    // 공지사항 수정 폼 이동
    @GetMapping("/updateForm/{noticeId}")
    public String showUpdateForm(@PathVariable int noticeId, Model model) {
        NoticeDTO notice = noticeService.getNoticeDetail(noticeId);
        model.addAttribute("notice", notice);
        return "notice/noticeForm"; // 수정과 작성 공통 폼 사용
    }

    // 공지사항 수정하기
    @PostMapping("/update")
    public String updateNotice(@ModelAttribute NoticeDTO notice, HttpSession session) {
        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        if (admin == null || admin.getRoleId() != 1) {
            return "redirect:/login";
        }

        // ✅ noticeStatus가 null 또는 비어있다면 기본값 설정
        if (notice.getNoticeStatus() == null || notice.getNoticeStatus().isEmpty()) {
            notice.setNoticeStatus("NOACT");
        }
        if (notice.isMain()) {
            noticeService.unsetMainNotice();
        }



        notice.setUpdatedAt(LocalDateTime.now());
        notice.setUpdatedBy(admin.getAdminId());
        noticeService.updateNotice(notice);

        System.out.println("noticeId = " + notice.getNoticeId());
        System.out.println("noticeStatus = " + notice.getNoticeStatus());
        System.out.println("isMain = " + notice.isMain());
        System.out.println("isNeedPin = " + notice.isNeedPin());
        System.out.println("priority = " + notice.getPriority());

        return "redirect:/notice/" + notice.getNoticeId();
    }




}
