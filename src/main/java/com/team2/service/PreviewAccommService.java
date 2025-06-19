package com.team2.service;

import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.dto.previewaccomm.PreviewAccommImageDTO;
import com.team2.dto.previewaccomm.PreviewAccommReviewDTO;
import com.team2.dto.previewaccomm.PreviewAccommRoomDTO;
import com.team2.mapper.AccommPreviewMapper;
import com.team2.vo.previewaccomm.PreviewAccommVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PreviewAccommService {

    @Autowired
    AccommPreviewMapper accommodationMapper;

    /* 3개의 DTO를 합쳐서, 숙소 ID별 VO에 정보 저장 */
    public List<PreviewAccommVO> getAccommPreviewInfo(ConditionDTO conditionDTO) {

        List<PreviewAccommRoomDTO> accommPreview = accommodationMapper.getAccommPreview(conditionDTO);
        List<PreviewAccommImageDTO> accommImage = accommodationMapper.getAccommImage();
        List<PreviewAccommReviewDTO> accommReview = accommodationMapper.getAccommReview();

        for (PreviewAccommReviewDTO reviewDTO : accommReview) {
            System.out.println(reviewDTO);
        }

        for (PreviewAccommRoomDTO accommRoomDTO : accommPreview) {
            System.out.println(accommRoomDTO);
        }

        for (PreviewAccommImageDTO imageDTO : accommImage) {
            System.out.println(imageDTO);
        }

        Map<Integer, PreviewAccommImageDTO> imageMap = new HashMap<>();
        for (PreviewAccommImageDTO image : accommImage) {
            imageMap.put(image.getAccommodationId(), image);
        }

        Map<Integer, PreviewAccommReviewDTO> reviewMap = new HashMap<>();
        for (PreviewAccommReviewDTO review : accommReview) {
            reviewMap.put(review.getAccommodationId(), review);
        }

        List<PreviewAccommVO> result = new ArrayList<>();
        for (PreviewAccommRoomDTO accommRoom : accommPreview) {

            PreviewAccommImageDTO image =  imageMap.get(accommRoom.getAccommodationId());
            PreviewAccommReviewDTO review = reviewMap.get(accommRoom.getAccommodationId());

            PreviewAccommVO vo = PreviewAccommVO.builder()
                    .accommodationId(accommRoom.getAccommodationId())
                    .accommodationName(accommRoom.getAccommodationName())
                    .provinceName(accommRoom.getProvinceName())
                    .districtName(accommRoom.getDistrictName())
                    .rating(accommRoom.getRating())
                    .clickViews(accommRoom.getClickViews())
                    .price(accommRoom.getPrice())
                    .accommodationImageFilePath(image.getAccommodationImageFilePath())
                    .accommodationImageType(image.getAccommodationImageType())
                    .accommodationImageFileSize(image.getAccommodationImageFileSize())
                    .accommodationImageHeight(image.getAccommodationImageHeight())
                    .accommodationImageWidth(image.getAccommodationImageWidth())
                    .reviewScore(review.getReviewScore())
                    .reviewCnt(review.getReviewCnt())
                    .checkIn(conditionDTO.getCheckIn())
                    .build();

            result.add(vo);
        }

        return result;
    }
}
