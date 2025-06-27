package com.team2.controller.accomm;

import com.team2.dto.accomm.AccommodationDTO;
import com.team2.service.accomm.AccommService;
import com.team2.vo.previewaccomm.AccommVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/accommodations")
public class AdminAccommController {

    @Autowired
    private AccommService accommService;

    @GetMapping
    public String list(@ModelAttribute("condition") AccommodationDTO condition,
                       Model model) {
        List<AccommVO> vo = accommService.findBy(condition);
        System.out.println(vo);
        model.addAttribute("list", vo);
        return "accomm/accommAdmin";
    }

    @GetMapping("/{id}")
    public String detail(@PathVariable("id") Integer id,
                         Model model) {
        AccommodationDTO dto = new AccommodationDTO();
        dto.setAccommodationId(id);
        List<AccommVO> vo = accommService.findBy(dto);
        model.addAttribute("vo", vo);
        return "accomm/detail";
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("dto", new AccommodationDTO());
        return "accomm/create";
    }

    @PostMapping("/create")
    public String create(@ModelAttribute AccommodationDTO dto) {
        accommService.create(dto);
        return "redirect:/accommodations";
    }

    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable("id") Integer id,
                           Model model) {
        AccommodationDTO dto = new AccommodationDTO();
        dto.setAccommodationId(id);
        List<AccommVO> vo = accommService.findBy(dto);
        model.addAttribute("dto", dto);
        model.addAttribute("list", vo);
        return "accomm/edit";
    }

    @PostMapping("/{id}/edit")
    public String update(@PathVariable("id") Integer id,
                         @ModelAttribute AccommodationDTO dto,
                         RedirectAttributes redirectAttrs) {
        dto.setAccommodationId(id);
        accommService.updateSelective(dto);
        redirectAttrs.addFlashAttribute("message", "수정이 완료되었습니다.");
        return "redirect:/accommodations";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Integer id,
                         Model model) {
        String result = accommService.delete(id);
        model.addAttribute("message", result);
        return "redirect:/accommodations";
    }
}
