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
} 