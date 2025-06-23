package com.team2.dto.accommdetail;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AccommReviewDTO {

    private int accommodationId;
    private double reviewScore;
    private int reviewCnt;
}
