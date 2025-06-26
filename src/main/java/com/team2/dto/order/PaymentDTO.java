package com.team2.dto.order;

import java.time.LocalDateTime;

/**
 * PAYMENT 테이블 매핑 DTO (간소화).
 */
public class PaymentDTO {
    private int paymentId;
    private int reserveId;
    private int paymentOptionId = 1; // 기본 옵션
    private int paymentStatusId = 1; // 결제 완료
    private int price;
    private int isRefundable = 1;
    private LocalDateTime createdAt;

    // getters / setters
    public int getPaymentId() {return paymentId;}
    public void setPaymentId(int paymentId) {this.paymentId = paymentId;}
    public int getReserveId() {return reserveId;}
    public void setReserveId(int reserveId) {this.reserveId = reserveId;}
    public int getPaymentOptionId() {return paymentOptionId;}
    public void setPaymentOptionId(int paymentOptionId) {this.paymentOptionId = paymentOptionId;}
    public int getPaymentStatusId() {return paymentStatusId;}
    public void setPaymentStatusId(int paymentStatusId) {this.paymentStatusId = paymentStatusId;}
    public int getPrice() {return price;}
    public void setPrice(int price) {this.price = price;}
    public int getIsRefundable() {return isRefundable;}
    public void setIsRefundable(int isRefundable) {this.isRefundable = isRefundable;}
    public LocalDateTime getCreatedAt() {return createdAt;}
    public void setCreatedAt(LocalDateTime createdAt) {this.createdAt = createdAt;}
} 