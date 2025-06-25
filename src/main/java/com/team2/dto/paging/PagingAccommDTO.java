package com.team2.dto.paging;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
@ToString
public class PagingAccommDTO {

    private int accommodationId;
    private String accommodationName;
    private String provinceName;
    private String districtName;
    private String rating;
    private int clickViews;
    private int price;
    private String accommodationImageFilePath;
    private double reviewScore;
    private int reviewCnt;
    private String checkIn;
    private String checkOut;
}
