package com.team2.dto.accomm;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AccommInfoDTO {

    private int accommInfoId;
    private int accommId;
    private boolean IsParking;
    private boolean IsPickUp;
    private String description;
    private String guideLine;
    private String summaryReview;
    private String directions;
    private Date createdAt;
    private Date updatedAt;
    private int createdBy;
    private int updatedBy;
}
