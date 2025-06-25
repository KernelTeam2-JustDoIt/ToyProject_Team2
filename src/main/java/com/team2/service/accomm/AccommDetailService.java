package com.team2.service.accomm;

import com.team2.dto.accommdetail.*;
import com.team2.mapper.AccommDetailMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AccommDetailService {

    @Autowired
    private AccommDetailMapper accommDetailMapper;

    public AccommInfoDTO getAccommDetail(int id) {
        return accommDetailMapper.getAccommInfo(id);
    }

    public List<AccommImageDTO> getAccommImageList(int id) {
        return accommDetailMapper.getAccommImage(id);
    }

    public AccommReviewDTO getAccommReview(int id) {
        return accommDetailMapper.getAccommReview(id);
    }

    public List<AccommReviewImageDTO> getAccommReviewImage(int id) {
        return accommDetailMapper.getAccommReviewImage(id);
    }

    public List<RoomPreviewDTO> getRoomPreview(int id) {
        return accommDetailMapper.getRoomPreview(id);
    }

    public void increaseViews(int id) {
        accommDetailMapper.increaseViews(id);
    }
}
