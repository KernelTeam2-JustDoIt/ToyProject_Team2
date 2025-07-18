package com.team2.controller.order;

import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.service.order.OrderService;
import com.team2.service.cart.ShoppingCartService;
import com.team2.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Cookie;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/")
public class ReservationController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ShoppingCartService shoppingCartService;

    @Autowired
    private RoomService roomService;

    /**
     * 예약/결제 화면 출력
     */
    @GetMapping("reservation")
    public String reservationPage(HttpSession session, Model model, HttpServletRequest request) {
        System.out.println("=== ReservationController.reservationPage 시작 ===");
        
        List<Integer> selectedIds = (List<Integer>) session.getAttribute("selectedCartIds");
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        
        System.out.println("selectedIds: " + selectedIds);
        System.out.println("loginCustomer: " + loginCustomer);
        
        if (selectedIds == null || selectedIds.isEmpty()) {
            System.out.println("selectedIds가 null이거나 비어있어서 cart로 리다이렉트");
            return "redirect:/cart";
        }

        // 회원/비회원 customerId 처리
        Integer customerId = null;
        
        // 로그인된 사용자가 있으면 해당 사용자의 customerId 사용 (우선순위)
        if (loginCustomer != null) {
            customerId = loginCustomer.getCustomerId();
            System.out.println("로그인 사용자 customerId: " + customerId);
        } else {
            // 쿠키에서 비회원 ID 확인
            Cookie[] cookies = request.getCookies();
            System.out.println("쿠키 배열: " + (cookies != null ? cookies.length : "null"));
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    System.out.println("쿠키 이름: " + cookie.getName() + ", 값: " + cookie.getValue());
                    if (cookie.getName().equals("nonMemberId")) {
                        String nonmemberIdStr = cookie.getValue();
                        System.out.println("비회원 쿠키 값: " + nonmemberIdStr);
                        try {
                            customerId = Integer.parseInt(nonmemberIdStr);
                            System.out.println("비회원 customerId: " + customerId);
                        } catch (NumberFormatException e) {
                            // 쿠키 값이 유효하지 않은 경우 무시
                            customerId = null;
                            System.out.println("비회원 쿠키 값 파싱 실패");
                        }
                        break;
                    }
                }
            } else {
                System.out.println("쿠키가 없습니다.");
            }
        }

        // customerId가 없으면 장바구니로 리다이렉트
        if (customerId == null) {
            System.out.println("customerId가 null이어서 cart로 리다이렉트");
            return "redirect:/cart";
        }

        List<ShoppingCartItemDTO> items = shoppingCartService.getCartItems(customerId);
        System.out.println("전체 장바구니 아이템 수: " + items.size());
        
        items.removeIf(i -> !selectedIds.contains(i.getCartId()));
        System.out.println("선택된 아이템 수: " + items.size());
        
        if (items.isEmpty()) {
            System.out.println("선택된 아이템이 없어서 cart로 리다이렉트");
            return "redirect:/cart";
        }

        model.addAttribute("cart", items);
        int totalPrice = items.stream().mapToInt(ShoppingCartItemDTO::getPrice).sum();
        model.addAttribute("totalPrice", totalPrice);
        System.out.println("예약 페이지로 이동, 총 가격: " + totalPrice);
        return "order/reservation";
    }

    /**
     * 직접 예약 - 숙소 상세 페이지에서 바로 예약하기
     */
    @GetMapping("reservation/direct")
    public String directReservation(
            @RequestParam(value = "roomId", required = false) String roomIdStr,
            @RequestParam(value = "checkIn", required = false) String checkIn,
            @RequestParam(value = "checkOut", required = false) String checkOut,
            @RequestParam(value = "adultCnt", defaultValue = "2") String adultCntStr,
            @RequestParam(value = "babyCnt", defaultValue = "0") String babyCntStr,
            Model model,
            HttpSession session
    ) {
        // 파라미터 검증 및 변환
        if (roomIdStr == null || roomIdStr.trim().isEmpty()) {
            return "redirect:/"; // 메인 페이지로 리다이렉트
        }
        
        int roomId;
        int adultCnt;
        int babyCnt;
        
        try {
            roomId = Integer.parseInt(roomIdStr.trim());
            adultCnt = Integer.parseInt(adultCntStr.trim());
            babyCnt = Integer.parseInt(babyCntStr.trim());
        } catch (NumberFormatException e) {
            return "redirect:/"; // 파라미터 오류 시 메인 페이지로 리다이렉트
        }
        // 체크인/체크아웃 날짜가 없으면 기본값 설정
        if (checkIn == null || checkIn.isEmpty()) {
            checkIn = java.time.LocalDate.now().toString();
        }
        if (checkOut == null || checkOut.isEmpty()) {
            checkOut = java.time.LocalDate.now().plusDays(1).toString();
        }

        // 직접 예약 정보를 모델에 추가
        model.addAttribute("isDirect", true);
        model.addAttribute("directRoomId", roomId);
        model.addAttribute("directCheckIn", checkIn);
        model.addAttribute("directCheckOut", checkOut);
        model.addAttribute("directAdultCnt", adultCnt);
        model.addAttribute("directBabyCnt", babyCnt);

        return "order/reservation";
    }

    /**
     * 결제 완료 처리
     */
    @PostMapping("reservation/complete")
    public String completeReservation(HttpSession session, Model model, HttpServletRequest request) {
        List<Integer> selectedIds = (List<Integer>) session.getAttribute("selectedCartIds");
        if (selectedIds == null || selectedIds.isEmpty()) {
            return "redirect:/cart";
        }

        // 회원/비회원 customerId 처리
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        Integer customerId = null;
        
        // 로그인된 사용자가 있으면 해당 사용자의 customerId 사용 (우선순위)
        if (loginCustomer != null) {
            customerId = loginCustomer.getCustomerId();
        } else {
            // 쿠키에서 비회원 ID 확인
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("nonMemberId")) {
                        String nonmemberIdStr = cookie.getValue();
                        try {
                            customerId = Integer.parseInt(nonmemberIdStr);
                        } catch (NumberFormatException e) {
                            // 쿠키 값이 유효하지 않은 경우 무시
                            customerId = null;
                        }
                        break;
                    }
                }
            }
        }

        // customerId가 없으면 장바구니로 리다이렉트
        if (customerId == null) {
            return "redirect:/cart";
        }

        List<ShoppingCartItemDTO> items = shoppingCartService.getCartItems(customerId);
        items.removeIf(i -> !selectedIds.contains(i.getCartId()));
        if (items.isEmpty()) {
            return "redirect:/cart";
        }

        OrderDTO order = orderService.createOrder(customerId, items);

        shoppingCartService.removeCartItems(selectedIds);

        session.removeAttribute("selectedCartIds");

        // 완료 화면에 표시할 데이터
        model.addAttribute("order", order);
        return "order/payment_success";
    }

    /**
     * 예약 목록 - 회원/비회원 처리
     */
    @GetMapping("orders")
    public String orderList(
            HttpSession session, 
            Model model,
            HttpServletRequest request
    ) {
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        
        Integer customerId = null;
        String nonmemberIdStr = null;
        
        // 쿠키에서 비회원 ID 확인
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("nonMemberId")) {
                    nonmemberIdStr = cookie.getValue();
                    try {
                        customerId = Integer.parseInt(nonmemberIdStr);
                    } catch (NumberFormatException e) {
                        // 쿠키 값이 유효하지 않은 경우 무시
                        customerId = null;
                    }
                    break;
                }
            }
        }
        
        // 로그인된 사용자가 있으면 해당 사용자의 customerId 사용 (우선순위)
        if (loginCustomer != null) {
            customerId = loginCustomer.getCustomerId();
        }
        
        // customerId가 없으면 빈 목록 표시
        if (customerId == null) {
            model.addAttribute("orders", new ArrayList<OrderDTO>());
        } else {
            List<OrderDTO> orders = orderService.getOrdersByCustomer(customerId);
            model.addAttribute("orders", orders);
        }
        
        return "order/orderList";
    }

    /**
     * 예약 상세
     */
    @GetMapping("orders/detail")
    public String orderDetail(int orderId, Model model) {
        OrderDTO order = orderService.getOrderDetail(orderId);
        if (order == null) {
            return "redirect:/orders";
        }
        model.addAttribute("order", order);
        return "order/orderDetail";
    }

    /**
     * 직접 예약 완료 처리
     */
    @PostMapping("reservation/direct/complete")
    public String completeDirectReservation(
            @RequestParam("roomId") int roomId,
            @RequestParam("checkIn") String checkIn,
            @RequestParam("checkOut") String checkOut,
            @RequestParam("adultCnt") int adultCnt,
            @RequestParam("babyCnt") int babyCnt,
            @RequestParam("bookerName") String bookerName,
            @RequestParam("bookerPhone") String bookerPhone,
            @RequestParam(value = "userName", required = false) String userName,
            @RequestParam(value = "userPhone", required = false) String userPhone,
            @RequestParam("transport") String transport,
            HttpSession session,
            HttpServletRequest request,
            Model model
    ) {
        // 로그인 사용자 확인 또는 비회원 ID 생성
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        Integer customerId = null;
        
        if (loginCustomer != null) {
            // 로그인된 사용자
            customerId = loginCustomer.getCustomerId();
        } else {
            // 비회원 - 쿠키에서 ID 확인 또는 생성
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("nonMemberId")) {
                        try {
                            customerId = Integer.parseInt(cookie.getValue());
                        } catch (NumberFormatException e) {
                            customerId = null;
                        }
                        break;
                    }
                }
            }
            
            // 비회원 ID가 없으면 새로 생성 (임시 로직)
            if (customerId == null) {
                customerId = (int) (System.currentTimeMillis() % 1000000); // 임시 ID 생성
                // 쿠키에 저장 (실제로는 더 안전한 방법 사용 필요)
                // Cookie nonMemberCookie = new Cookie("nonMemberId", String.valueOf(customerId));
                // nonMemberCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
                // response.addCookie(nonMemberCookie);
            }
        }

        // TODO: 실제 예약 처리 로직 구현
        // 현재는 임시로 성공 페이지로 리다이렉트
        
        model.addAttribute("message", "예약이 완료되었습니다!");
        model.addAttribute("roomId", roomId);
        model.addAttribute("checkIn", checkIn);
        model.addAttribute("checkOut", checkOut);
        
        return "order/payment_success";
    }
} 