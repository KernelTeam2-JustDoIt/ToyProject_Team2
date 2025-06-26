package com.team2.dto.order;

/**
 * 주문 하위 항목(객실/상품)을 나타내는 DTO.
 */
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

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getAccommId() {
        return accommId;
    }

    public void setAccommId(int accommId) {
        this.accommId = accommId;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getCheckInAt() {
        return checkInAt;
    }

    public void setCheckInAt(String checkInAt) {
        this.checkInAt = checkInAt;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public String getCheckInTime() {
        return checkInTime;
    }

    public void setCheckInTime(String checkInTime) {
        this.checkInTime = checkInTime;
    }

    public String getCheckOutTime() {
        return checkOutTime;
    }

    public void setCheckOutTime(String checkOutTime) {
        this.checkOutTime = checkOutTime;
    }

    public int getStandardCapacity() {
        return standardCapacity;
    }

    public void setStandardCapacity(int standardCapacity) {
        this.standardCapacity = standardCapacity;
    }

    public int getMaximumCapacity() {
        return maximumCapacity;
    }

    public void setMaximumCapacity(int maximumCapacity) {
        this.maximumCapacity = maximumCapacity;
    }

    public String getAccommodationName() {
        return accommodationName;
    }

    public void setAccommodationName(String accommodationName) {
        this.accommodationName = accommodationName;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public void setThumbnailUrl(String thumbnailUrl) {
        this.thumbnailUrl = thumbnailUrl;
    }

    public int getReserveId() {
        return reserveId;
    }

    public void setReserveId(int reserveId) {
        this.reserveId = reserveId;
    }
} 