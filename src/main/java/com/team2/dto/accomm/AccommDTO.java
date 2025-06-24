package com.team2.dto.accomm;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AccommDTO {

    private int accommId;
    private int sellerId;
    private int adminId;
    private int categoryL1Id;
    private int categoryL2Id;
    private int categoryL3Id;
    private String accommName;
    private String accommStatus;
    private int clickViews;
    private String accommRate;
    private String provinceName;
    private String districtName;
    private String roadName;
    private int buildingNumber;
    private int buildingSubNumber;
    private Date createdAt;
    private Date updatedAt;
    private int createdBy;
    private int updatedBy;

}
