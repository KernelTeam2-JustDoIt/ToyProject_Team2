package com.team2.controller.mainpage;

import com.team2.dto.accommdetail.TopAccommDTO;
import com.team2.dto.notice.NoticeDTO;
import com.team2.model.CustomerVO;
import com.team2.service.NoticeService;
import com.team2.service.accomm.AccommDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.sql.Timestamp;
import java.time.LocalDateTime;

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
        // TODO 공지사항중에 중요한 것은 메인 페이지에서 보여줘야함
        NoticeDTO getMainNotice = noticeService.getMainNotice();
        model.addAttribute("getMainNotice", getMainNotice);

        // 조회수 TOP 10
        List<TopAccommDTO> topAccomm = accommDetailService.getTopAccomm();
        model.addAttribute("topViewedList", topAccomm);

        // 세션 테스트용 강제 로그인 상태
        // 로그인 할때 CustomerVO 를 세션에 저장하는 기능 구현이 필요
//        CustomerVO customer = new CustomerVO();
//        customer.setCustomerId(1);
//        customer.setCustomerStatusId(1);
//        customer.setCustomerName("이강현");
//        customer.setCustomerTel("010-2585-1790");
//        customer.setCustomerEmail("bill29123@gmail.com");
//        customer.setCustomerLoginId("bill291104");
//        customer.setCustomerPassword("123456");
//        customer.setCustomerGender("M");
//        customer.setCustomerAge(26);
//        customer.setIsMarketingUseAgreed(1);
//        customer.setCustomerJob("학생");
//        customer.setGradeId(1);
//        customer.setJoinedAt(Timestamp.valueOf(LocalDateTime.now()));
//        customer.setGradeExpireDate(Timestamp.valueOf(LocalDateTime.now()));
//        customer.setPoint(100);
//        session.setAttribute("loginCustomer", customer);
        return "index";
    }
}
