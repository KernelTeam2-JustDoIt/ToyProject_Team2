package com.team2.dto.cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartAddDTO {
    private int cartId;
    private long roomId;
    private int customerId;
    private String createdAt;
    private int adultCount;
    private int childCount;
}
