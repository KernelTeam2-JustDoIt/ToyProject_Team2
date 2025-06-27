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

    private int orderId;           // RESERVE_ID (PK)
    private int customerId;        // RESERVER_ID (주문자 ID)
    private int totalPrice;        // PAYMENT.PRICE (총 결제 금액)
    private String status;         // 결제 상태 (e.g., COMPLETED, CANCELLED)
    private Date orderDate;        // RESERVE_DATE (주문일시)
    
    // RESERVE 테이블 추가 필드
    private int roomId;            // ROOM_ID
    private Date checkInAt;        // CHECK_IN_AT
    private Date checkOutDate;     // CHECK_OUT_DATE

    // 하위 아이템들 (옵션)
    private List<OrderItemDTO> items;
} 