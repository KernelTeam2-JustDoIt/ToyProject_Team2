package com.team2.dto.cart;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class CartDTO {
    private int cartId;
    private int roomId;
    private int customerId;
    private int adultCount;
    private int childCount;
    private LocalDateTime desiredCheckInAt;
    private LocalDateTime desiredCheckOutAt;

}