package com.team2.dto.paging;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
public class PagingConditionDTO {

    private String district;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkIn;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOut;
    private int adultCnt;
    private int babyCnt;
    private int totalPeopleCnt;

    private int onOff;

    private int limit;
    private int offset;

    public void setTotalPeopleCnt() {
        this.totalPeopleCnt = this.adultCnt + this.babyCnt;
    }
}
