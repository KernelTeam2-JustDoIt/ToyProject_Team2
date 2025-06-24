package com.team2.controller;

import com.team2.dto.accommdetail.*;
import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.service.AccommDetailService;
import com.team2.service.PagingAccommService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

// 호텔/모텔 나눌 시 메서드 이름 재설정
@Controller
@RequestMapping("/domestic")
public class SearchAccommController {

    @Autowired
    private PagingAccommService pagingAccommService;

    @Autowired
    private AccommDetailService accommDetailService;

    /* 숙소 검색 메인 페이지 */
    @GetMapping("/hotel")
    public String hotelMain(@ModelAttribute ConditionDTO conditionDTO, Model model) {

        /* 디폴트 검색 */
        if (conditionDTO.getDistrict() == null) {
            return "hotelMotelSearch";
        }

        int totalPages = pagingAccommService.getTotalPages(conditionDTO, conditionDTO.getSize());
        List<PagingAccommDTO> previewAccomm = pagingAccommService.getSearchAccommPaging(conditionDTO);

        model.addAttribute("roomList", previewAccomm);
        model.addAttribute("condition", conditionDTO);
        model.addAttribute("totalPages", totalPages);

        return "hotelMotelSearch";
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

        return "accommDetail";
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

        return "roomDetail";
    }
}
