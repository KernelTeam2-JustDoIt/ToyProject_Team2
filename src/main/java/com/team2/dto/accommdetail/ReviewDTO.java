package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReviewDTO {

    private int accommodationId;
    private int reviewId;
    private int reviewScore;
    private String createdAt;
    private String reviewDetail;
    private String accommodationName;
    private String rating;
}
