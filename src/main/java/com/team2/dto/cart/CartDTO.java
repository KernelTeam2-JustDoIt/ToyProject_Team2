package com.team2.dto.cart;

import com.team2.model.Cart;
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




    public CartDTO() { }

    public CartDTO(int roomId, int customerId, int adultCount, int childCount, LocalDateTime desiredCheckInAt, LocalDateTime desiredCheckOutAt) {
        this.roomId = roomId;
        this.customerId = customerId;
        this.adultCount = adultCount;
        this.childCount = childCount;
        this.desiredCheckInAt = desiredCheckInAt;
        this.desiredCheckOutAt = desiredCheckOutAt;
    }

}