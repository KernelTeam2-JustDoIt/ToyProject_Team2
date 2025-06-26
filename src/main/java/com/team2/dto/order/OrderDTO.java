package com.team2.dto.order;

import java.util.Date;
import java.util.List;

/**
 * 주문(예약) 정보를 담는 DTO.
 */
public class OrderDTO {

    private int orderId;           // PK
    private int customerId;        // 주문자 ID
    private int totalPrice;        // 총 결제 금액
    private String status;         // 결제 상태 (e.g., COMPLETED, CANCELLED)
    private Date orderDate;         // 주문일시

    // 하위 아이템들 (옵션)
    private List<OrderItemDTO> items;

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderItemDTO> getItems() {
        return items;
    }

    public void setItems(List<OrderItemDTO> items) {
        this.items = items;
    }
} 