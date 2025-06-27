package com.team2.dto.cart;

import com.team2.model.cart.Cart;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class CartDTO {
    private int cartId;
    private int roomId;
    private int customerId;
    private String checkIn;
    private String checkOut;
    private int adultCount;
    private int childCount;
//    private Date desiredCheckInAt;
//    private Date desiredCheckOutAt;

}