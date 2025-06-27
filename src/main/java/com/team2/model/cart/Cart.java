package com.team2.model.cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter 
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
    private int cartId;
    private int roomId;
    private int customerId;
    private int adultCount;
    private int childCount;
    private Date desiredCheckInAt;
    private Date desiredCheckOutAt;
}
