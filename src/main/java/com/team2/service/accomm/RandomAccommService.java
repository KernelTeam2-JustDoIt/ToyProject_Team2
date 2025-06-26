package com.team2.service.accomm;

import com.team2.dto.accommdetail.AccommThumbnailImageDTO;
import com.team2.mapper.AccommDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class RandomAccommService {

    @Autowired
    private AccommDetailMapper accommDetailMapper;

    public List<AccommThumbnailImageDTO> getRandomAccommImage() {
        List<AccommThumbnailImageDTO> accommImageDTOList = new ArrayList<>();
        Set<Integer> idSet = new HashSet<>();

        while (idSet.size() < 8) {
            int num = accommDetailMapper.getRandomAccommId();

            if (!idSet.contains(num)) {
                idSet.add(num);
                AccommThumbnailImageDTO imageDTO = accommDetailMapper.getAccommThumbnailImage(num);
                accommImageDTOList.add(imageDTO);
            }
        }

        return accommImageDTOList;
    }
}
