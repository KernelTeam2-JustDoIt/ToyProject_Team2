package com.team2.dto.paging;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
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
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkIn;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOut;
}
