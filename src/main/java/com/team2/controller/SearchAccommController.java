package com.team2.controller;

import com.team2.dto.paging.PagingAccommDTO;
import com.team2.dto.paging.PagingConditionDTO;
import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.service.PagingAccommService;
import com.team2.service.PreviewAccommService;
import com.team2.vo.previewaccomm.PreviewAccommVO;
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

    /* 숙소 검색 메인 페이지 */
    @GetMapping("/hotel")
    public String hotelMain(@ModelAttribute ConditionDTO conditionDTO, Model model) {

        /* 디폴트 검색 */ // 영경 여기 잠깐 수정해봄
        if (conditionDTO.getDistrict() == null
                || conditionDTO.getDistrict().trim().isEmpty()) {
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
        System.out.println(id);

        return "accommDetail";
    }

}
