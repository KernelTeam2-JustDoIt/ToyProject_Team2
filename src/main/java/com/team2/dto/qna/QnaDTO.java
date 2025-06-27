package com.team2.dto.qna;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class QnaDTO {
    private int qnaId;              // 문의 ID
    private int customerId;         // 문의 작성자 (고객 ID)
    private String title;           // 문의 제목
    private String content;        // 문의 내용
    private String answerContent;          // 관리자 답변 (nullable)
    private LocalDateTime postedAt;  // 문의 작성일
    private LocalDateTime answeredAt; // 답변 작성일 (nullable)
    private int adminId;         // 답변한 관리자 ID (nullable)
    private String qnaStatus;       // 상태: WAIT(답변 대기) / DONE(답변 완료)
    private int isSecret; // 0: 공개글, 1: 비밀글
    private String formattedPostedDate;    // 작성일 포맷용
    private String formattedAnsweredDate; // 답변일 포맷용
    private int viewCount; // 글 카운트

}
