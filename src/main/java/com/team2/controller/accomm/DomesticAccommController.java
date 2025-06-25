package com.team2.controller.accomm;

import com.team2.dto.accommdetail.AccommThumbnailImageDTO;
import com.team2.service.accomm.RandomAccommService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/domestic")
public class DomesticAccommController {

    @Autowired
    private RandomAccommService randomAccommService;

    @GetMapping
    public String domesticMain(Model model) {

        List<AccommThumbnailImageDTO> imageDTOList = randomAccommService.getRandomAccommImage();
        model.addAttribute("imageList", imageDTOList);
        System.out.println(imageDTOList.size());
        System.out.println(imageDTOList);


        return "accomm/domesticMain";
    }
}
