package com.team2.mapper;

import com.team2.dto.accommdetail.AccommDetailDTO;

import java.util.List;

public interface AccommDetailMapper {

    /* id로 호텔 정보 및 호텔 상세 정보 찾기 */
    List<AccommDetailDTO> getAccommDetail(int id);
}
