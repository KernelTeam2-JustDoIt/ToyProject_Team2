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
    private PreviewAccommService previewAccommService;

    @Autowired
    private PagingAccommService pagingAccommService;

    /* 숙소 검색 메인 페이지 */
    @GetMapping("/hotel")
    public String hotelMain(@ModelAttribute ConditionDTO conditionDTO, Model model) {

        /* 관심사의 분리 필요*/
        conditionDTO.prepareForQuery();
        conditionDTO.setOnOff(1);

        /* 디폴트 검색 */
        if (conditionDTO.getDistrict() == null) {
            return "hotelMotelSearch";
        }

        List<PagingAccommDTO> previewAccomm = pagingAccommService.getSearchAccommPaging(conditionDTO);
        int totalPages = pagingAccommService.getTotalPages(conditionDTO, conditionDTO.getSize());

        model.addAttribute("roomList", previewAccomm);
        model.addAttribute("condition", conditionDTO);
        model.addAttribute("totalPages", totalPages);

        return "hotelMotelSearch";
    }
}
