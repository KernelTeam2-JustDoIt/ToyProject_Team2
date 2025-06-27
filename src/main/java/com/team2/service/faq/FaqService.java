package com.team2.service.faq;

import com.team2.dto.faq.FaqDTO;

import java.util.List;
import java.util.Map;

public interface FaqService {

    // 전체 FAQ 목록 조회
    List<FaqDTO> findAll(Integer writerAdminId);

    // 카테고리별 FAQ 목록 조회
    List<FaqDTO> findByCategory(String category, Integer writerAdminId);

    // 특정 FAQ 조회
    FaqDTO findById(Integer faqId);

    // FAQ 등록
    void insert(FaqDTO faqDTO);

    // FAQ 수정
    void update(FaqDTO faqDTO);

    // FAQ 삭제 (소프트 딜리트)
    void delete(Integer faqId);

    // 페이징 + 카테고리별 FAQ 조회
    Map<String, Object> findByPaging(String category,int page ,String search ,Integer writerAdminId);

    // 카테고리별 FAQ 개수 조회
    int countByCategory(Map<String, Object> param);
}
