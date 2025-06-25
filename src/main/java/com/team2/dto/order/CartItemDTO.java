package com.team2.dto.order;

/**
 * 장바구니에 담는 숙소(상품) 정보를 보관하는 DTO.
 * 세션에 저장되어 DB 에는 저장되지 않습니다.
 */
public class CartItemDTO {

    private int accommId;          // 숙소(상품) ID
    private String roomName;       // 객실명 또는 상품명
    private int price;             // 1박 금액 (원)
    private String checkInDate;    // 체크인 날짜 (yyyy-MM-dd)
    private String checkOutDate;   // 체크아웃 날짜 (yyyy-MM-dd)
    private boolean selected = true; // 결제 대상 선택 여부 (기본 true)

    public CartItemDTO() {
    }

    public CartItemDTO(int accommId, String roomName, int price, String checkInDate, String checkOutDate) {
        this.accommId = accommId;
        this.roomName = roomName;
        this.price = price;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
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

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    // 1박 금액 * 숙박일 수 계산 편의를 위한 메서드 등을 필요 시 추가할 수 있습니다.
} 