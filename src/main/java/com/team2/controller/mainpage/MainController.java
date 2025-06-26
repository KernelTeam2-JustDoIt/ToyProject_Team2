package com.team2.controller.mainpage;

import com.team2.dto.accommdetail.TopAccommDTO;
import com.team2.dto.notice.NoticeDTO;
import com.team2.service.NoticeService;
import com.team2.service.accomm.AccommDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MainController {
    // TODO 이벤트 서비스가 완성되면 자동 주입
//    @Autowired
//    private EventService eventService;
    @Autowired
    private NoticeService noticeService;

    @Autowired
    private AccommDetailService accommDetailService;

    @GetMapping("/")
    public String mainPage(Model model, HttpSession session) {
        // TODO 이벤트 서비스가 완성되면 List<EventDto> activeEvents 를 가져와서 model 로 전달
//        List<EventDto> activeEvents = eventService.getActiveEvents();
//        model.addAttribute("activeEvents", activeEvents); // 모델에 이벤트 목록 추가

        // 공지사항 가져와서 보여주기, view 로 전달
        NoticeDTO latestNotice = noticeService.getLatestNotice();
        model.addAttribute("latestNotice", latestNotice);

        // 조회수 TOP 10
        List<TopAccommDTO> topAccomm = accommDetailService.getTopAccomm();
        model.addAttribute("topViewedList", topAccomm);

        // 세션 테스트용 강제 로그인 상태
        // 로그인 할때 CustomerVO 를 세션에 저장하는 기능 구현이 필요
//        CustomerVO customer = new CustomerVO();
//        session.setAttribute("loginUser", customer);
        return "index";
    }
}
