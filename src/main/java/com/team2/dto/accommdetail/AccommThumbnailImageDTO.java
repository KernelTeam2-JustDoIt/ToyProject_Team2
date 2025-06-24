package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommThumbnailImageDTO {

    private int accommodationId;
    private int priority;
    private String accommodationImageFilePath;
    private String accommodationName;
}
