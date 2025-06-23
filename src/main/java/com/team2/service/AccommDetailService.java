package com.team2.service;

import com.team2.dto.accommdetail.AccommDetailDTO;
import com.team2.mapper.AccommDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccommDetailService {

    @Autowired
    private AccommDetailMapper accommDetailMapper;

    public List<AccommDetailDTO> getAccommDetailList(int id) {
        List<AccommDetailDTO> acccommDetailList =  accommDetailMapper.getAccommDetail(id);

        for (AccommDetailDTO accommDetailDTO : acccommDetailList) {
            System.out.println(accommDetailDTO);
        }

        return acccommDetailList;
    }
}
