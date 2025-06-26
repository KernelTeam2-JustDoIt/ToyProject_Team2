package com.team2.mapper;

import com.team2.dto.accomm.AccommodationDTO;
import com.team2.vo.previewaccomm.AccommVO;

import java.util.List;

public interface AccommMapper {

    List<AccommVO> findBy(AccommodationDTO accommodationDTO);
    int insert(AccommodationDTO accommodationDTO);
    int update(AccommodationDTO accommodationDTO);
    int delete(Integer accommodationId);
}
