package com.team2.mapper;

import com.team2.dto.faq.FaqDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface FaqMapper {

    // 전체 FAQ 조회
    List<FaqDTO> findAll(Integer writerAdminId);

    // 카테고리별 FAQ 조회
    List<FaqDTO> findByCategory(Map<String,Object> param);

    // 단건 FAQ 조회
    FaqDTO findById(@Param("faqId") Integer faqId);

    // FAQ 등록
    void insert(FaqDTO faq);

    // FAQ 수정
    void update(FaqDTO faq);

    // FAQ 삭제 (소프트 딜리트)
    void delete(@Param("faqId") Integer faqId);

    // 페이징 + 카테고리 필터링
    List<FaqDTO> findByPaging(Map<String, Object> param);

    // 카테고리별 FAQ 개수 조회
    int countByCategory(Map<String, Object> param);

    void increaseViewCount(Integer faqId);
}
