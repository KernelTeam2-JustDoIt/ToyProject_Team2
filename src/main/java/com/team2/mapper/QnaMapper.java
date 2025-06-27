package com.team2.mapper;

import com.team2.dto.qna.QnaDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface QnaMapper {

    //  고객 문의 작성
    void insertQna(QnaDTO qna);

    //  관리자 전체 QNA 목록 (페이징 + 검색 포함)
    List<QnaDTO> getQnaList(Map<String, Object> param);

    //  QNA 상세 조회
    QnaDTO getQnaDetail(int qnaId);

    //  관리자 답변 등록
    void answerQna(QnaDTO qna);

    //  QNA 총 개수 조회 (페이징용)
    int countQnaList(Map<String, Object> param);

    void softDelete(int qnaId);

    void updateQna(QnaDTO qna);

    void increaseViewCount(int qnaId);

}

