package com.team2.dto.order;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * RESERVE 테이블 매핑 DTO (간소화 버전).
 */
@Getter
@Setter
public class ReserveDTO {
    private int reserveId;
    private int reserverId; // 고객 ID
    private int roomId;
    private String checkInAt;  // 원하는 체크인 일시 (String -> DATETIME)
    private String checkOutDate; // 체크아웃 일시
    private int reserveStatusId = 1; // 기본 예약 상태 (예: 예약완료)
    private int isCancelable = 1;    // 취소 가능 여부 (1: 가능)
    private LocalDateTime reserveDate; // 예약 생성 시각 (DB NOW())
} 