package com.team2.controller;

import com.team2.dto.previewaccomm.ConditionDTO;
import com.team2.dto.previewaccomm.PreviewAccommRoomDTO;
import com.team2.service.PreviewAccommService;
import com.team2.vo.previewaccomm.PreviewAccommVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


@Controller
@RequestMapping("/domestic")
public class AccommController {

    @Autowired
    PreviewAccommService accommService;

    @GetMapping("/hotel")
    public String pensionMain() {
        return "pensionSearch";
    }

    @PostMapping("/hotel")
    public String getCondition(ConditionDTO conditionDTO, Model model,
                               @RequestParam(defaultValue = "1") int page) {

        conditionDTO.setTotalPeopleCnt(conditionDTO.getAdultCnt() + conditionDTO.getBabyCnt());
        List<PreviewAccommVO> previewAccomm = accommService.getAccommPreviewInfo(conditionDTO);

        model.addAttribute("roomList", previewAccomm);

        return "pensionSearch";
    }

}
