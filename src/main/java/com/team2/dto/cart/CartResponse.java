package com.team2.dto.cart;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CartResponse {
    // SHOPPING_CART columns
    private int cartId;
    private int roomId;
    private int customerId;
    private int adultCount;
    private int childCount;

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