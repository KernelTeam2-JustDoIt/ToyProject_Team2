package com.team2.dto.order;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class ShoppingCartItemDTO {
    private int cartId;
    private int roomId;
    private int customerId;
    private String roomName; // 화면 표시용 - JOIN으로 조회
    private String desiredCheckInAt;
    private String desiredCheckOutAt;
    private int adultCount;
    private int childCount;
    private LocalDateTime createdAt;
    private int price; // ROOM 테이블 가격 실시간 조회값

    // 선택 체크박스용
    private boolean selected = true;

    // 객실 정원 정보
    private int standardCapacity;
    private int maximumCapacity;
} 