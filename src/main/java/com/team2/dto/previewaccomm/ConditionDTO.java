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
    // 숙소 선택 조건(지역, 날짜, 인원 수) post로 받기
    private String district;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkIn;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkOut;
    private int adultCnt;
    private int babyCnt;
    private int totalPeopleCnt;

    public void setTotalPeopleCnt() {
        this.totalPeopleCnt = this.adultCnt + this.babyCnt;
    }
}
