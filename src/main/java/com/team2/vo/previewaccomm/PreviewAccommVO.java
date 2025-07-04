package com.team2.vo.previewaccomm;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Builder
@ToString
public class PreviewAccommVO {

    private int accommodationId;
    private String accommodationName;
    private String provinceName;
    private String districtName;
    private String rating;
    private int clickViews;
    private int price;
    private String accommodationImageFilePath;
    private String accommodationImageType;
    private int accommodationImageFileSize;
    private int accommodationImageHeight;
    private int accommodationImageWidth;
    private double reviewScore;
    private int reviewCnt;
    private String checkIn;
    private String checkOut;
}
