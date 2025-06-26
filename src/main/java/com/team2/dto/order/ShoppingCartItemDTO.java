package com.team2.dto.order;

import java.time.LocalDateTime;

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

    // getters / setters
    public int getCartId() {return cartId;}
    public void setCartId(int cartId) {this.cartId = cartId;}
    public int getRoomId() {return roomId;}
    public void setRoomId(int roomId) {this.roomId = roomId;}
    public int getCustomerId() {return customerId;}
    public void setCustomerId(int customerId) {this.customerId = customerId;}
    public String getRoomName() {return roomName;}
    public void setRoomName(String roomName) {this.roomName = roomName;}
    public String getDesiredCheckInAt() {return desiredCheckInAt;}
    public void setDesiredCheckInAt(String desiredCheckInAt) {this.desiredCheckInAt = desiredCheckInAt;}
    public String getDesiredCheckOutAt() {return desiredCheckOutAt;}
    public void setDesiredCheckOutAt(String desiredCheckOutAt) {this.desiredCheckOutAt = desiredCheckOutAt;}
    public int getAdultCount() {return adultCount;}
    public void setAdultCount(int adultCount) {this.adultCount = adultCount;}
    public int getChildCount() {return childCount;}
    public void setChildCount(int childCount) {this.childCount = childCount;}
    public LocalDateTime getCreatedAt() {return createdAt;}
    public void setCreatedAt(LocalDateTime createdAt) {this.createdAt = createdAt;}
    public boolean isSelected() {return selected;}
    public void setSelected(boolean selected) {this.selected = selected;}
    public int getPrice() {return price;}
    public void setPrice(int price) {this.price = price;}

    public int getStandardCapacity() {return standardCapacity;}
    public void setStandardCapacity(int standardCapacity) {this.standardCapacity = standardCapacity;}
    public int getMaximumCapacity() {return maximumCapacity;}
    public void setMaximumCapacity(int maximumCapacity) {this.maximumCapacity = maximumCapacity;}
} 