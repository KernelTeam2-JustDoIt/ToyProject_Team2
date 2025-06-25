package com.team2.controller.accomm;

import com.team2.dto.accommdetail.*;
import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.service.accomm.AccommDetailService;
import com.team2.service.accomm.AccommReviewService;
import com.team2.service.accomm.PagingAccommService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

// 호텔/모텔 나눌 시 메서드 이름 재설정
@Controller
@RequestMapping("/domestic")
public class SearchAccommController {

    @Autowired
    private PagingAccommService pagingAccommService;

    @Autowired
    private AccommDetailService accommDetailService;

    @Autowired
    private AccommReviewService accommReviewService;

    /* 숙소 검색 메인 페이지 */
    @GetMapping("/hotel")
    public String hotelMain(@ModelAttribute ConditionDTO conditionDTO, Model model) {

        /* 디폴트 검색 */
        if (conditionDTO.getDistrict() == null) {
            List<PagingAccommDTO> pagingAccommDTOList = new ArrayList<>();
            ConditionDTO con = pagingAccommService.getDefaultCondition();
            pagingAccommDTOList = pagingAccommService.getSearchAccommPaging(con);
            int totalPages = pagingAccommService.getTotalPages(con, con.getSize());

            model.addAttribute("roomList", pagingAccommDTOList);
            model.addAttribute("condition", conditionDTO);
            model.addAttribute("totalPages", totalPages);

            return "accomm/hotelMotelSearch";
        }

        int totalPages = pagingAccommService.getTotalPages(conditionDTO, conditionDTO.getSize());
        List<PagingAccommDTO> pagingAccommDTOList = pagingAccommService.getSearchAccommPaging(conditionDTO);

        model.addAttribute("roomList", pagingAccommDTOList);
        model.addAttribute("condition", conditionDTO);
        model.addAttribute("totalPages", totalPages);

        return "accomm/hotelMotelSearch";
    }

    @GetMapping("/hotel/{id}")
    public String showHotel(@PathVariable int id, Model model) {
        AccommInfoDTO accommInfoDTO = accommDetailService.getAccommDetail(id);
        List<AccommImageDTO> accommImageDTO = accommDetailService.getAccommImageList(id);
        AccommReviewDTO accommReviewDTO = accommDetailService.getAccommReview(id);
        List<AccommReviewImageDTO> accommReviewImageDTO = accommDetailService.getAccommReviewImage(id);
        List<RoomPreviewDTO> roomPreviewDTOList = accommDetailService.getRoomPreview(id);

        model.addAttribute("accomm", accommInfoDTO);
        model.addAttribute("accommImage", accommImageDTO);
        model.addAttribute("review", accommReviewDTO);
        model.addAttribute("reviews", accommReviewImageDTO);
        model.addAttribute("roomList", roomPreviewDTOList);

        return "accomm/accommDetail";
    }

    @GetMapping("/room/{id}")
    public String showRoom(@PathVariable int id,
                           @RequestParam("accommodationId") int accommId,
                           Model model) {

        List<RoomPreviewDTO> roomPreviewDTOList = accommDetailService.getRoomPreview(accommId);

        RoomPreviewDTO selectedRoom = roomPreviewDTOList.stream()
                .filter(room -> room.getRoomId() == id)
                .findFirst()
                .orElse(null);

        model.addAttribute("room", selectedRoom);

        return "accomm/roomDetail";
    }

    @GetMapping("/review/{id}")
    public String showReview(@PathVariable int id,
                             @RequestParam(defaultValue = "1") int page,
                             Model model) {

        AccommReviewDTO accommReviewDTO = accommDetailService.getAccommReview(id);
        List<AccommImageDTO> accommImageDTOList = accommDetailService.getAccommImageList(id);

        int size = 5;
        int offset = (page - 1) * size;

        List<ReviewDTO> reviewDTOList = accommReviewService.getReviewInfo(id, offset, size);

        model.addAttribute("review", accommReviewDTO);
        model.addAttribute("reviewImages", accommImageDTOList);
        model.addAttribute("reviewList", reviewDTOList);

        return "accomm/review";
    }

    /* ajax 렌더링 페이지 */
    @GetMapping("/review/more")
    @ResponseBody
    public String getMoreReviews(@RequestParam int accommodationId,
                                 @RequestParam(defaultValue = "1") int page,
                                 Model model) {

        int size = 5;
        int offset = (page - 1) * size;

        List<ReviewDTO> reviews = accommReviewService.getReviewInfo(accommodationId, offset, size);
        model.addAttribute("reviewList", reviews);

        return "accomm/reviewFragment";
    }


}
