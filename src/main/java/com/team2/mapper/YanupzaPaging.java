package com.team2.mapper;

import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.paging.PagingConditionDTO;
import com.team2.dto.previewaccomm.ConditionDTO;

import java.util.List;

public interface YanupzaPaging {

    /* 숙소 검색 페이징 */
    List<PagingAccommDTO> searchAccommPaging(ConditionDTO conditionDTO);

    /* 페이징 조건에 맞는 숙소 개수 구하기 */
    int getAccommPagingCnt(ConditionDTO conditionDTO);
}
