package com.team2.dto.order;

import java.time.LocalDateTime;

/**
 * RESERVE 테이블 매핑 DTO (간소화 버전).
 */
public class ReserveDTO {
    private int reserveId;
    private int reserverId; // 고객 ID
    private int roomId;
    private String checkInAt;  // 원하는 체크인 일시 (String -> DATETIME)
    private String checkOutDate; // 체크아웃 일시
    private int reserveStatusId = 1; // 기본 예약 상태 (예: 예약완료)
    private int isCancelable = 1;    // 취소 가능 여부 (1: 가능)
    private LocalDateTime reserveDate; // 예약 생성 시각 (DB NOW())

    // getters / setters
    public int getReserveId() {return reserveId;}
    public void setReserveId(int reserveId) {this.reserveId = reserveId;}
    public int getReserverId() {return reserverId;}
    public void setReserverId(int reserverId) {this.reserverId = reserverId;}
    public int getRoomId() {return roomId;}
    public void setRoomId(int roomId) {this.roomId = roomId;}
    public String getCheckInAt() {return checkInAt;}
    public void setCheckInAt(String checkInAt) {this.checkInAt = checkInAt;}
    public String getCheckOutDate() {return checkOutDate;}
    public void setCheckOutDate(String checkOutDate) {this.checkOutDate = checkOutDate;}
    public int getReserveStatusId() {return reserveStatusId;}
    public void setReserveStatusId(int reserveStatusId) {this.reserveStatusId = reserveStatusId;}
    public int getIsCancelable() {return isCancelable;}
    public void setIsCancelable(int isCancelable) {this.isCancelable = isCancelable;}
    public LocalDateTime getReserveDate() {return reserveDate;}
    public void setReserveDate(LocalDateTime reserveDate) {this.reserveDate = reserveDate;}
} 