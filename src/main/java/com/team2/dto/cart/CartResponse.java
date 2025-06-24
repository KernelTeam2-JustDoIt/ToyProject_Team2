package com.team2.dto.cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CartResponse {
    // SHOPPING_CART columns
    private int cartId;
    private int roomId;
    private int customerId;
    private Date desiredCheckInAt;
    private Date desiredCheckOutAt;
    private Integer adultCount;
    private Integer childCount;
    private Date shoppingCartCreatedAt;
    private Integer shoppingCartCreatedBy;
    private Date shoppingCartUpdatedAt;
    private Integer shoppingCartUpdatedBy;

    // ROOM columns
    private Long accommodationId;
    private String roomStatus;
    private Boolean isAvailable;
    private Integer price;
    private String roomCategory;
    private String roomSelect;
    private String roomName;
    private LocalTime checkinTime;
    private LocalTime checkoutTime;
    private String basicInfo;
    private String facilityServiceInfo;
    private Integer roomSize;
    private Integer roomCount;
    private Boolean isUsePolicyNeeded;
    private String view;
    private Integer standardCapacity;
    private Integer maximumCapacity;
    private LocalDate roomCheckinDate;
    private LocalDate roomCheckoutDate;
    private Date roomCreatedAt;
    private Integer roomCreatedBy;
    private Date roomUpdatedAt;
    private Integer roomUpdatedBy;




}