package com.team2.dto.previewaccomm;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
@ToString
public class ConditionDTO {

    // 검색 조건
    private String district;
    private String checkIn;
    private String checkOut;
    private int adultCnt;
    private int babyCnt;
    private int totalPeopleCnt;
    private int onOff;

    // 페이징 관련
    private int page = 1;
    private int size = 6;
    private int limit;
    private int offset;

    /* Mapper에서 사용 */
    public List<String> getDistrictList() {
        if (district == null || district.isEmpty()) return null;
        return Arrays.stream(district.split("/"))
                .map(String::trim)
                .collect(Collectors.toList());
    }

}
