package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommReviewImageDTO {

    private int reserveId;
    private String filePath;
    private int isThumbnail;
    private int sortOrder;
    private int accommodationId;
    private String reviewDetail;
    private String createdAt;
    private double reviewScore;
}
