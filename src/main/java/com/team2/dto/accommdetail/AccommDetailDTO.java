package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommDetailDTO {

    private int accommodationId;
    private String accommodationName;
    private String provinceName;
    private String districtName;
    private String rating;

    private String description;
    private String guideLine;
    private String reserveNotice;
    private String summaryReview;
    private String directions;

    private String accommodationImageFilePath;

    private double reviewScore;
}
