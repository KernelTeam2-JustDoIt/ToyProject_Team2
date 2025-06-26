package com.team2.dto.order;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * PAYMENT 테이블 매핑 DTO (간소화).
 */
@Getter
@Setter
public class PaymentDTO {
    private int paymentId;
    private int reserveId;
    private int paymentOptionId = 1; // 기본 옵션
    private int paymentStatusId = 1; // 결제 완료
    private int price;
    private int isRefundable = 1;
    private LocalDateTime createdAt;
} 