package com.team2.dto.accomm;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

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
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int createdBy;
    private int updatedBy;
}
