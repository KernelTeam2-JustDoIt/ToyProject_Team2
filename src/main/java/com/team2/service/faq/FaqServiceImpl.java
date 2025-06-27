package com.team2.service.faq;

import com.team2.dto.faq.FaqDTO;
import com.team2.mapper.FaqMapper;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FaqServiceImpl implements FaqService {

    private final FaqMapper faqMapper;

    // FaqMapper를 생성자 주입받습니다.
    public FaqServiceImpl(FaqMapper faqMapper) {
        this.faqMapper = faqMapper;
    }

    // 전체 FAQ 목록 조회
    @Override
    public List<FaqDTO> findAll(Integer writerAdminId) {
        return faqMapper.findAll(writerAdminId);
    }

    // 카테고리별 FAQ 목록 조회
    @Override
    public List<FaqDTO> findByCategory(String category , Integer writerAdminId) {
        HashMap<String, Object> param = new HashMap<>();
        param.put("category", category);
        param.put("writerAdminId", writerAdminId);
        return faqMapper.findByCategory(param);

    }

    // 특정 FAQ 조회
    @Override
    public FaqDTO findById(Integer faqId) {
        return faqMapper.findById(faqId);
    }

    // FAQ 등록
    @Override
    public void insert(FaqDTO faqDTO) {

        faqMapper.insert(faqDTO);

    }

    // FAQ 수정
    @Override
    public void update(FaqDTO faqDTO) {
        faqMapper.update(faqDTO);
    }

    // FAQ 삭제 (소프트 딜리트)
    @Override
    public void delete(Integer faqId) {
        faqMapper.delete(faqId);
    }

    // 페이징 처리 및 카테고리별 FAQ 조회
    @Override
    public Map<String, Object> findByPaging(String category, int page ,String search ,Integer writerAdminId ) {
        // 페이지당 개수 설정
        int pageSize = 10;

        // 현재 페이지에 따른 offset 계산 (음수 값이 나오지 않도록 처리)
        int offset = Math.max(0, (page - 1) * pageSize);

        // 파라미터를 담을 Map 생성
        Map<String, Object> param = new HashMap<>();
        param.put("offset", offset);
        param.put("pageSize", pageSize);
        param.put("writerAdminId", writerAdminId);
        param.put("search", search);

        // 카테고리가 null이면 전체 조회, 아니면 카테고리별 조회
        if (category != null && !category.isEmpty()) {
            param.put("category", category);  // 카테고리 필터 추가
        }
        if (search != null && !search.trim().isEmpty()) {
            param.put("keyword", search); //
        }
        List<FaqDTO> faqList = faqMapper.findByPaging(param);

        // 전체 FAQ 개수 조회 (카테고리가 null이면 전체 개수, 아니면 카테고리별 개수)
        int totalCount = countByCategory(param);

        // 전체 페이지 수 계산
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);

        // 페이지네이션을 위한 startPage, endPage 계산
        int startPage = Math.max(1, page - 2); // 최소 1페이지
        int endPage = Math.min(startPage + 4, totalPages); // 최대 5페이지까지 표시

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        for (FaqDTO faq : faqList) {
            if (faq.getPostedAt() != null) {
                faq.setFormattedDate(faq.getPostedAt().format(formatter));
            }
            if (faq.getUpdatedAt() != null) {
                faq.setFormattedUpdatedDate(faq.getUpdatedAt().format(formatter));
            }
        }


        Map<String, Object> result = new HashMap<>();
        result.put("faqList", faqList);
        result.put("selectedCategory", category);
        result.put("currentPage", page);
        result.put("search", search);
        result.put("totalPages", totalPages);
        result.put("startPage", startPage);
        result.put("endPage", endPage);
        return result;
    }

    // 카테고리별 FAQ 개수 조회
    @Override
    public int countByCategory(Map<String, Object> param) {
        return faqMapper.countByCategory(param);
    }
}
