package com.team2.service.qna;

import com.team2.dto.qna.QnaDTO;

import java.util.List;
import java.util.Map;

public interface QnaService {

    // 고객 문의 등록
    void insertQna(QnaDTO qna);


    // 문의 상세 조회
    QnaDTO getQnaDetail(int qnaId);

    // 관리자 답변 등록
    void answerQna(QnaDTO qna);

    // 전체 QNA 개수 (페이징 계산용)
    int countQnaList(Map<String, Object> param);

    List<QnaDTO> getQnaList(Map<String, Object> param);

    void deleteQna(int qnaId);

    void updateQna(QnaDTO original);
}
