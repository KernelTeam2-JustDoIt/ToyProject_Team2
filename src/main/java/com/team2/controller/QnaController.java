package com.team2.controller;

import com.team2.dto.Admin.AdminDTO;
import com.team2.dto.qna.QnaDTO;
import com.team2.model.CustomerVO;
import com.team2.service.qna.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/qna")
public class QnaController {

    @Autowired
    private QnaService qnaService;

    @GetMapping("/list")
    public String qnaList(@RequestParam(defaultValue = "1") int page,
                          @RequestParam(required = false) String keyword,
                          Model model,
                          HttpSession session) {

        int pageSize = 10;
        int offset = (page - 1) * pageSize;

        // 세션에서 로그인 정보 가져오기
        Object loginAdmin = session.getAttribute("loginAdmin");
        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");

        Map<String, Object> param = new HashMap<>();
        param.put("limit", pageSize);
        param.put("offset", offset);

        // 검색 키워드가 있으면 추가
        if (keyword != null && !keyword.trim().isEmpty()) {
            param.put("keyword", keyword.trim());
        }

        // 권한 분기 처리
        if (loginAdmin != null) {
            param.put("isAdmin", true);
        } else if (loginCustomer != null) {
            param.put("isAdmin", false);
            param.put("customerId", loginCustomer.getCustomerId());
        } else {
            // 비로그인 사용자 → 비밀글 전체 숨김
            param.put("isAdmin", false);
            param.put("customerId", -1); // 존재하지 않는 ID 처리
        }

        // 리스트 및 날짜 포맷 처리
        List<QnaDTO> qnaList = qnaService.getQnaList(param);
        for (QnaDTO qna : qnaList) {
            if (qna.getPostedAt() != null) {
                qna.setFormattedPostedDate(qna.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            }
        }

        // 페이징 계산
        int totalCount = qnaService.countQnaList(param);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        int blockSize = 5;
        int startPage = ((page - 1) / blockSize) * blockSize + 1;
        int endPage = Math.min(startPage + blockSize - 1, totalPages);

        boolean hasPrevPage = startPage > 1;
        boolean hasNextPage = endPage < totalPages;

        // 모델에 값 담기
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("keyword", keyword);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("hasPrevPage", hasPrevPage);
        model.addAttribute("hasNextPage", hasNextPage);

        return "qna/qnaList";
    }



    @GetMapping("/{qnaId}")
    public String qnaDetail(@PathVariable int qnaId, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        QnaDTO qna = qnaService.getQnaDetail(qnaId);

        // 게시글이 존재하지 않거나 삭제된 경우
        if (qna == null || "DEL".equals(qna.getQnaStatus())) {
            redirectAttributes.addFlashAttribute("msg", "존재하지 않거나 삭제된 글입니다.");
            return "redirect:/qna/list";
        }

        // 세션 정보
        Integer loginCustomerId = (Integer) session.getAttribute("loginCustomerId");
        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        boolean isAdmin = admin != null && admin.getRoleId() == 1;
        boolean isAuthor = loginCustomerId != null && loginCustomerId == qna.getCustomerId();

        // 비밀글이면 관리자 또는 작성자만 열람 가능
        if (qna.getIsSecret() == 1 && !(isAdmin || isAuthor)) {
            redirectAttributes.addFlashAttribute("msg", "비밀글입니다.");
            return "redirect:/qna/list";
        }

        // 날짜 포맷
        if (qna.getPostedAt() != null)
            qna.setFormattedPostedDate(qna.getPostedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        if (qna.getAnsweredAt() != null)
            qna.setFormattedAnsweredDate(qna.getAnsweredAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));

        model.addAttribute("qna", qna);
        return "qna/qnaDetail";
    }







    // QNA 작성 폼 (고객용)
    @GetMapping("/form")
    public String QnaForm(Model model) {
        model.addAttribute("qna", new QnaDTO());
        return "qna/qnaForm";
    }
    // 고객 질문 수정 폼
    @GetMapping("/edit/{qnaId}")
    public String editQnaForm(@PathVariable int qnaId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) {
            redirectAttributes.addFlashAttribute("msg", "로그인이 필요합니다.");
            return "redirect:/customer/login";
        }



        QnaDTO qna = qnaService.getQnaDetail(qnaId);
        if (qna == null || !"WAIT".equals(qna.getQnaStatus())) {
            redirectAttributes.addFlashAttribute("msg", "수정할 수 없는 글입니다.");
            return "redirect:/qna/list";
        }

        if (loginCustomer.getCustomerId() != qna.getCustomerId()) {
            redirectAttributes.addFlashAttribute("msg", "권한이 없습니다.");
            return "redirect:/qna/list";
        }

        model.addAttribute("qna", qna);
        return "qna/qnaForm"; // 등록폼 재사용
    }

    //고객 수정 처리
    @PostMapping("/update")
    public String updateQna(@ModelAttribute QnaDTO qna, HttpSession session, RedirectAttributes redirectAttributes) {
        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");

        QnaDTO original = qnaService.getQnaDetail(qna.getQnaId());
        if (original == null || !"WAIT".equals(original.getQnaStatus()) ||
                loginCustomer == null || loginCustomer.getCustomerId() != original.getCustomerId()) {
            redirectAttributes.addFlashAttribute("msg", "수정 권한이 없습니다.");
            return "redirect:/qna/list";
        }

        // 수정 가능한 필드만 반영
        original.setTitle(qna.getTitle());
        original.setContent(qna.getContent());
        original.setIsSecret(qna.getIsSecret());

        qnaService.updateQna(original);

        redirectAttributes.addFlashAttribute("msg", "수정 완료되었습니다.");
        return "redirect:/qna/" + qna.getQnaId();
    }



    // QNA 작성 처리 (고객용)
    @PostMapping("/add")
    public String insertQna(@ModelAttribute QnaDTO qna, HttpSession session , HttpServletRequest request) {
        // 세션에서 고객 ID 가져오기 (예시)
        CustomerVO loginCustomer = (CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) return "redirect:/customer/login";

        // 기본값 설정
        qna.setCustomerId(loginCustomer.getCustomerId());
        qna.setPostedAt(LocalDateTime.now());
        qna.setQnaStatus("WAIT"); // 기본 상태값 설정

        // 비밀글 체크 안 했을 경우 기본값 설정
        if (qna.getIsSecret() != 1) {
            qna.setIsSecret(0);
        }

        qnaService.insertQna(qna);
        return  "redirect:/qna/list";
    }

    // 관리자 답변 작성/수정 폼
    @GetMapping("/answerForm/{qnaId}")
    public String AnswerForm(@PathVariable int qnaId, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        // 로그인 및 권한 확인
        if (admin == null || admin.getRoleId() != 1) {
            redirectAttributes.addFlashAttribute("msg", "관리자만 접근 가능합니다.");
            return "redirect:/login";
        }

        QnaDTO qna = qnaService.getQnaDetail(qnaId);

        if (qna == null || "DEL".equals(qna.getQnaStatus())) {
            redirectAttributes.addFlashAttribute("msg", "존재하지 않거나 삭제된 글입니다.");
            return "redirect:/qna/list";
        }

        model.addAttribute("qna", qna);
        return "qna/qnaAnswerForm";
    }


    // 관리자 답변 처리
    @PostMapping("/answer")
    @Transactional
    public String answerQna(@ModelAttribute QnaDTO qna,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        // 로그인한 관리자 검증
        AdminDTO loginAdmin = (AdminDTO) session.getAttribute("loginAdmin");

        if (loginAdmin == null || loginAdmin.getRoleId() != 1) {
            redirectAttributes.addFlashAttribute("msg", "관리자 권한이 필요합니다.");
            return "redirect:/login";
        }

        // 답변 처리
        qna.setAdminId(loginAdmin.getAdminId());
        qna.setAnsweredAt(LocalDateTime.now());

        try {
            qnaService.answerQna(qna);
            redirectAttributes.addFlashAttribute("msg", "답변이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("msg", "답변 등록 중 오류가 발생했습니다.");
            return "redirect:/qna/list";
        }

        return "redirect:/qna/" + qna.getQnaId();
    }

    // 관리자 전용 QnA 삭제 처리
    @PostMapping("/delete/{qnaId}")
    public String deleteQna(@PathVariable int qnaId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        AdminDTO admin = (AdminDTO) session.getAttribute("loginAdmin");

        if (admin == null || admin.getRoleId() != 1) {
            redirectAttributes.addFlashAttribute("msg", "관리자 권한이 필요합니다.");
            return "redirect:/login";
        }

        // 소프트 딜리트 처리
        qnaService.deleteQna(qnaId);

        redirectAttributes.addFlashAttribute("msg", "삭제가 완료되었습니다.");
        return "redirect:/qna/list";
    }




}
