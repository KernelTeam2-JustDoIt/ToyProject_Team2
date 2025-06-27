package com.team2.service.qna;

import com.team2.dto.qna.QnaDTO;
import com.team2.mapper.QnaMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QnaServiceImpl implements QnaService {

    @Autowired
    private QnaMapper qnaMapper;

    @Override
    public void insertQna(QnaDTO qna) {
        qnaMapper.insertQna(qna);
    }



    @Override
    public List<QnaDTO> getQnaList(Map<String, Object> param) {
        return qnaMapper.getQnaList(param);
    }

    @Override
    public QnaDTO getQnaDetail(int qnaId) {
        return qnaMapper.getQnaDetail(qnaId);
    }

    @Override
    public void answerQna(QnaDTO qna) {
        qnaMapper.answerQna(qna);
    }

    @Override
    public int countQnaList(Map<String, Object> param) {
        return qnaMapper.countQnaList(param);
    }
    @Override
    public void deleteQna(int qnaId) {
        qnaMapper.softDelete(qnaId);
    }
    @Override
    public void updateQna(QnaDTO qna) {
        qnaMapper.updateQna(qna);
    }

}
