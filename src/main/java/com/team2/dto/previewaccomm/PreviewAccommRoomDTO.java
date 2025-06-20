package com.team2.dto.previewaccomm;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PreviewAccommRoomDTO {

    private int accommodationId;
    private String accommodationName;
    private String provinceName;
    private String districtName;
    private double rating;
    private int clickViews;
    private int price;
}
