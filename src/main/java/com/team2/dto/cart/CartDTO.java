package com.team2.dto.cart;

import com.team2.model.Cart;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class CartDTO {
    private int cartId;
    private long roomId;
    private int customerId;
    private String checkIn;
    private String checkOut;
    private int adultCnt;
    private int babyCnt;
//    private Date desiredCheckInAt;
//    private Date desiredCheckOutAt;

}