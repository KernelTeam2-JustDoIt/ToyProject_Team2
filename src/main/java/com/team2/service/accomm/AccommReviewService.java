package com.team2.service.accomm;

import com.team2.dto.accommdetail.ReviewDTO;
import com.team2.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccommReviewService {

    @Autowired
    private ReviewMapper reviewMapper;

    public List<ReviewDTO> getReviewInfo(int id, int offset, int limit) {
        return reviewMapper.getPagedReviews(id, offset, limit);
    }

}
