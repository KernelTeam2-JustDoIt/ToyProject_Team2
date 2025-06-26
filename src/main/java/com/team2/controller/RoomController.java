package com.team2.controller;

import com.team2.dto.RoomDTO;
import com.team2.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/room")
public class RoomController {

    @Autowired
    private RoomService roomService;

    /**
     * 객실 상세 페이지  /room/{roomId}
     */
    @GetMapping("/{roomId}")
    public String detailPage(@PathVariable("roomId") int roomId, Model model) {
        RoomDTO room = roomService.getRoom(roomId);
        if (room == null) {
            return "redirect:/room/list"; // 목록 페이지가 /room/list 로 유지
        }
        model.addAttribute("room", room);
        return "accom_detail";
    }

    /**
     * 객실 목록 (기존 /rooms) 그대로 두기 위해 보조 메서드 유지
     */
    @GetMapping("/list")
    public String listPage(Model model) {
        List<RoomDTO> list = roomService.getAllRooms();
        model.addAttribute("roomList", list);
        return "hotelMotelSearch";
    }
} 