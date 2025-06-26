package com.team2.dto.previewaccomm;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
@ToString
public class ConditionDTO {

    // 검색 조건
    private String district;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkIn;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOut;
    private Integer adultCnt;
    private Integer babyCnt;
    private int totalPeopleCnt;
    private int onOff;

    // 페이징 관련
    private int page = 1;
    private int size = 6;
    private int limit;
    private int offset;

}
