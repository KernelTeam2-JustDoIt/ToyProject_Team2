package com.team2.mapper;

import com.team2.dto.accommdetail.*;

import java.util.List;

public interface AccommDetailMapper {

    /* id로 호텔 정보 및 호텔 상세 정보 찾기 1:1관계 */
    AccommInfoDTO getAccommInfo(int id);

    List<AccommImageDTO> getAccommImage(int id);

    AccommReviewDTO getAccommReview(int id);

    List<AccommReviewImageDTO> getAccommReviewImage(int id);

    List<RoomPreviewDTO> getRoomPreview(int id);

    AccommThumbnailImageDTO getAccommThumbnailImage(int id);

    int getRandomAccommId();

    /*  클릭 시, 조회 수 증가 */
    void increaseViews(int id);

    /* 조회 수 TOP 10 숙소 리스트 */
    List<TopAccommDTO> getTop10Accomm();
}
