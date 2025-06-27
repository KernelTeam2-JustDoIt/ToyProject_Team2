package com.team2.dto.order;

import lombok.Getter;
import lombok.Setter;

/**
 * 주문 하위 항목(객실/상품)을 나타내는 DTO.
 */
@Getter
@Setter
public class OrderItemDTO {
    private int itemId;      // PK
    private int orderId;     // 주문 PK (FK)
    private int accommId;    // 숙소(상품) ID
    private String roomName; // 객실명
    private int price;       // 결제 가격 (원)
    private int quantity;    // 수량 (항상 1)
    private String checkInAt;   // 체크인 날짜(yyyy-MM-dd)
    private String checkOutDate; // 체크아웃 날짜(yyyy-MM-dd)
    private String checkInTime;  // 체크인 시간 (HH:mm)
    private String checkOutTime; // 체크아웃 시간 (HH:mm)
    private int standardCapacity; // 기준 인원
    private int maximumCapacity;  // 최대 인원
    private String accommodationName; // 숙소명
    private String thumbnailUrl; // 썸네일 이미지 URL
    private int reserveId; // 예약 ID (reserve 테이블 FK)
    
    // 추가: 리뷰 작성 가능 여부
    private boolean canWriteReview; // 리뷰 작성 가능 여부 (체크아웃 후 7일 이내)
    private long daysAfterCheckout; // 체크아웃 후 경과 일수
} 