package com.team2.mapper;

import com.team2.dto.order.PaymentDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
    int insertPayment(PaymentDTO payment);

    PaymentDTO selectById(int paymentId);
} 