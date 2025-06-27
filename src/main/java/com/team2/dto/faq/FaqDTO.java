package com.team2.dto.faq;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
public class FaqDTO {

    private Integer faqId;             // FAQ_ID
    private Integer writerAdminId; // WRITER_ADMIN_ID
    private String faqStatus;      // FAQ_STATUS
    private String faqCategory;    // FAQ_CATEGORY
    private String faqTitle;       // FAQ_TITLE
    private String faqContent;     // FAQ_CONTENT
    private LocalDateTime postedAt; // POSTED_AT
    private LocalDateTime updatedAt; // UPDATED_AT
    private Integer updatedBy;       // UPDATED_BY
    private Integer viewCount;       // VIEW_COUNT
    // 추가된 필드 (포맷된 날짜)
    private String formattedDate;       // 포맷된 등록일
    private String formattedUpdatedDate; // 포맷된 수정일
}
