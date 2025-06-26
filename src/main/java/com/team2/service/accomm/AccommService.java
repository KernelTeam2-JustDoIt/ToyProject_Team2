package com.team2.service.accomm;

import com.team2.dto.accomm.AccommodationDTO;
import com.team2.mapper.AccommMapper;
import com.team2.vo.previewaccomm.AccommVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccommService {

    @Autowired
    private AccommMapper mapper;

    public List<AccommVO> findBy(AccommodationDTO criteria) {
        return mapper.findBy(criteria);
    }

    public List<AccommVO> findById(Integer id) {
        AccommodationDTO criteria = new AccommodationDTO();
        criteria.setAccommodationId(id);
        return mapper.findBy(criteria);
    }

    public void create(AccommodationDTO accommodationDTO) {
        mapper.insert(accommodationDTO);
    }

    public void updateSelective(AccommodationDTO accommodationDTO) {
        mapper.update(accommodationDTO);
    }

    public String delete(Integer id) {
        int cnt = mapper.delete(id);
        if (cnt == 1) {
            return "삭제 성공!";
        } else {
            return "삭제 실패";
        }
    }
}
