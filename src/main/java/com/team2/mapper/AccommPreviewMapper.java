package com.team2.mapper;

import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.dto.previewaccomm.PreviewAccommImageDTO;
import com.team2.dto.previewaccomm.PreviewAccommReviewDTO;
import com.team2.dto.previewaccomm.PreviewAccommRoomDTO;

import java.util.List;

public interface AccommPreviewMapper {

    /* 숙소 프리뷰에 사용할 숙소 정보 검색 */
    List<PreviewAccommRoomDTO> getAccommPreview(ConditionDTO conditionDTO);

    /* 숙소 프리뷰 썸네일에 사용할 이미지 얻기 */
    List<PreviewAccommImageDTO> getAccommImage();

    /* 숙소 프리뷰 리뷰에 사용할 리뷰 정보 얻기 */
    List<PreviewAccommReviewDTO> getAccommReview();

}