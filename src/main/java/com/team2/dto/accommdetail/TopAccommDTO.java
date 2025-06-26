package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TopAccommDTO {

    private int accommodationId;
    private String accommodationName;
    private String accommodationImageFilePath;
    private int clickViews;
}
