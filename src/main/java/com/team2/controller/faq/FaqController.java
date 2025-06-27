package com.team2.controller.faq;

import com.team2.dto.Admin.AdminDTO;
import com.team2.dto.faq.FaqDTO;
import com.team2.service.faq.FaqService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/faq")
public class FaqController {

    private final FaqService faqService;

    public FaqController(FaqService faqService) {
        this.faqService = faqService;
    }

    // FAQ 리스트 조회 (전체 또는 카테고리별 + 페이징)
    @GetMapping("/list")
    public String listFaqs(
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "search", required = false) String search,
            Model model, HttpSession session) {

        Integer writerAdminId =null;
        AdminDTO loginAdmin = (AdminDTO) session.getAttribute("loginAdmin");
        if (loginAdmin != null) {
           writerAdminId = loginAdmin.getAdminId();

        }


        // FAQ 목록 조회
        Map<String, Object> result = faqService.findByPaging(category, page, search, writerAdminId);

        // 모델에 필요한 데이터 추가
        model.addAttribute("faqList", result.get("faqList"));
        model.addAttribute("selectedCategory", result.get("category"));
        model.addAttribute("currentPage", result.get("page"));
        model.addAttribute("search", result.get("search"));
        model.addAttribute("totalPages", result.get("totalPages"));
        model.addAttribute("startPage", result.get("startPage"));
        model.addAttribute("endPage", result.get("endPage"));

        return "faq/faqList"; // JSP 페이지로 이동
    }

//     관리자 - FAQ 등록/수정 폼
    @GetMapping("/form/{faqId}")
    public String updateFaqForm( @PathVariable(value = "faqId",required = false) Integer faqId, Model model) {
        System.out.println("FaqController.updateFaqForm");;
        FaqDTO faq = faqService.findById(faqId); // 새로운 FAQ 객체 생성
        System.out.println("faqId = " + faqId);
        if (faqId != null) {
            // 수정일 경우: faqId를 통해 데이터를 가져옵니다.
            faq = faqService.findById(faqId);
        }

        // model에 faq 객체 추가
        model.addAttribute("faq", faq);

        // 폼으로 이동
        return "faq/faqForm";
    }
    @GetMapping("/form")
public String insertFaqForm() {

        return "faq/faqForm";
    }
    // 관리자 - FAQ 등록 처리
    @PostMapping("/add")
    public String insertFaq(@ModelAttribute FaqDTO faqDTO) {
        System.out.println("faqDTO.getWriterAdminId() = " + faqDTO.getWriterAdminId());
        faqService.insert(faqDTO);

        return "redirect:/faq/list"; // 등록 후 FAQ 리스트로 리다이렉트
    }

    // 관리자 - FAQ 수정 처리
    @PostMapping("/update")
    public String updateFaq(@ModelAttribute FaqDTO faqDTO) {
        faqService.update(faqDTO);
        return "redirect:/faq/list"; // 수정 후 FAQ 리스트로 리다이렉트
    }

    // 관리자 - FAQ 삭제
    @PostMapping("/delete/{faqId}")
    public String deleteFaq(@PathVariable Integer faqId) {
        faqService.delete(faqId);
        return "redirect:/faq/list"; // 삭제 후 FAQ 리스트로 리다이렉트
    }

    // FAQ 상세 보기
    @GetMapping("/{faqId}")
    public String faqDetail(@PathVariable Integer faqId, Model model) {
        // FAQ 데이터 가져오기
        FaqDTO faq = faqService.findById(faqId);

        // 날짜 포맷 변환
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        if (faq.getPostedAt() != null) {
            faq.setFormattedDate(faq.getPostedAt().format(formatter)); // 등록일 포맷팅
        }
        if (faq.getUpdatedAt() != null) {
            faq.setFormattedUpdatedDate(faq.getUpdatedAt().format(formatter)); // 수정일 포맷팅
        }

        // 모델에 FAQ 데이터 추가
        model.addAttribute("faq", faq);

        return "faq/faqDetail"; // FAQ 상세 페이지로 이동
    }
}
