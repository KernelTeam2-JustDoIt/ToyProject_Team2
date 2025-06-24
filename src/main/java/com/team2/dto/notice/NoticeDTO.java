package com.team2.dto.notice;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class NoticeDTO {
    private int noticeId;
    private int writerAdminId; //작성자
    private String title;
    private String content;
    private Date postedAt;
    private Date updatedAt;
    private int updatedBy; //수정자
    private String noticeStatus; // 활성상태
    private boolean isMain; // 메인페이지 상단공지 여부
    private Integer priority; // 상단 공지 우선순위
    private boolean isNeedPin;   // 상단고정 여부
    private String formattedDate; // DB 작성일시에서 작성일만 담기위한 변수 선언
}
