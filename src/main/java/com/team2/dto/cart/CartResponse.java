package com.team2.dto.cart;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CartResponse {
    // SHOPPING_CART columns
    private int cartId;
    private int roomId;
    private int customerId;
    private LocalDateTime desiredCheckInAt;
    private LocalDateTime desiredCheckOutAt;
    private Integer adultCount;
    private Integer childCount;
    private LocalDateTime shoppingCartCreatedAt;
    private Integer shoppingCartCreatedBy;
    private LocalDateTime shoppingCartUpdatedAt;
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
    private LocalDateTime roomCreatedAt;
    private Integer roomCreatedBy;
    private LocalDateTime roomUpdatedAt;
    private Integer roomUpdatedBy;




}