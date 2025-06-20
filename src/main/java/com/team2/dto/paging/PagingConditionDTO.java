package com.team2.dto.paging;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingConditionDTO {

    private String district;
    private int onOff;
    private int limit;
    private int offset;
}
