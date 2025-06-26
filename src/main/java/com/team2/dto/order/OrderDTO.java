package com.team2.dto.order;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

/**
 * 주문(예약) 정보를 담는 DTO.
 */
@Getter
@Setter
public class OrderDTO {

    private int orderId;           // PK
    private int customerId;        // 주문자 ID
    private int totalPrice;        // 총 결제 금액
    private String status;         // 결제 상태 (e.g., COMPLETED, CANCELLED)
    private Date orderDate;         // 주문일시

    // 하위 아이템들 (옵션)
    private List<OrderItemDTO> items;
} 