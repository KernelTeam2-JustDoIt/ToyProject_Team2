package com.team2.service;

import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.paging.PagingConditionDTO;
import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.mapper.YanupzaPaging;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PagingAccommService {

    @Autowired
    private YanupzaPaging yanupzaPaging;

    /* 페이지네이션 알고리즘 처리 */
    public List<PagingAccommDTO> getSearchAccommPaging(ConditionDTO conditionDTO) {
        return yanupzaPaging.searchAccommPaging(conditionDTO);
    }

    /* 숙소 개수 구하기 */
    public int getTotalAccomm(ConditionDTO conditionDTO) {
        return yanupzaPaging.getAccommPagingCnt(conditionDTO);
    }

}
