package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommImageDTO {

    private int accommodationId;
    private int priority;
    private int isThumbnail;
    private String accommodationImageFilePath;
}
