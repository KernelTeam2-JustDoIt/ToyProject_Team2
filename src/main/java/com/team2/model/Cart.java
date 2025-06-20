package com.team2.model;

import java.time.LocalDateTime;

public class Cart {
    private int cartId;
    private int roomId;
    private int customerId;
    private int adultCount;
    private int childCount;
    private LocalDateTime desiredCheckInAt;
    private LocalDateTime desiredCheckOutAt;

    public Cart() {}

    public Cart(int roomId, int customerId, int adultCount, int childCount, LocalDateTime desiredCheckInAt, LocalDateTime desiredCheckOutAt) {
        this.roomId = roomId;
        this.customerId = customerId;
        this.adultCount = adultCount;
        this.childCount = childCount;
        this.desiredCheckInAt = desiredCheckInAt;
        this.desiredCheckOutAt = desiredCheckOutAt;
    }

    // 희망일자로 추가 가능한지 확인해야 되나...?
    // 체크아웃이 체크인보다 빠른지 확인해야 되나?!?!?!?

}
