package com.team2.mapper;

import com.team2.dto.accommdetail.ReviewDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReviewMapper {

    List<ReviewDTO> getPagedReviews(@Param("id") int id,
                                    @Param("offset") int offset,
                                    @Param("limit") int limit);
}
