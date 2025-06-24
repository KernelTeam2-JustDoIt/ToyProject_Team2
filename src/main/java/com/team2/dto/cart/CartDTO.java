package com.team2.dto.cart;

import com.team2.model.Cart;
import lombok.Getter;
import lombok.Setter;
import java.util.Date;

@Getter
@Setter
public class CartDTO {
    private int cartId;
    private int roomId;
    private int customerId;
    private int adultCount;
    private int childCount;
    private Date desiredCheckInAt;
    private Date desiredCheckOutAt;

    public CartDTO() { }

    public CartDTO(int roomId, int customerId, int adultCount, int childCount, Date desiredCheckInAt, Date desiredCheckOutAt) {
        this.roomId = roomId;
        this.customerId = customerId;
        this.adultCount = adultCount;
        this.childCount = childCount;
        this.desiredCheckInAt = desiredCheckInAt;
        this.desiredCheckOutAt = desiredCheckOutAt;
    }
}