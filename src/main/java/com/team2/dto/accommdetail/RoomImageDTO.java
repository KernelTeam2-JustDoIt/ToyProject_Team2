package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RoomImageDTO {
    private int isThumbnail;
    private String roomImageFilePath;
    private int priority;
}
