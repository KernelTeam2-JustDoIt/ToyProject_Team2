package com.team2.dto.accommdetail;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

/**
 * ROOM 테이블을 위한 Data Transfer Object
 */
@Getter
@Setter
public class RoomDTO {

    private Integer roomId;
    private Integer accommodationId;
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
    private LocalDate checkinDate;
    private LocalDate checkoutDate;
}
