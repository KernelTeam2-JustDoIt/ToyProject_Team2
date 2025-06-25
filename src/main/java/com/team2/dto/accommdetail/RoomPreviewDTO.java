package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class RoomPreviewDTO {
    private int roomId;
    private int accommodationId;
    private boolean isAvailable;
    private int price;
    private String roomCategory;
    private String roomName;
    private String checkinTime;
    private String checkoutTime;
    private int roomCount;
    private int standardCapacity;
    private int maximumCapacity;

    private String basicInfo;
    private String facilityServiceInfo;
    private int roomSize;

    private List<RoomBedDTO> bedList;
    private List<RoomImageDTO> imageList;
}