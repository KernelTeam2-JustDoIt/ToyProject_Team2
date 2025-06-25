package com.team2.controller;

import com.team2.dto.order.CartItemDTO;
import com.team2.dto.order.OrderDTO;
import com.team2.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class ReservationController {

    @Autowired
    private OrderService orderService;

    /**
     * 예약/결제 화면
     */
    @GetMapping("reservation")
    public String reservationPage(HttpSession session, Model model) {
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }
        model.addAttribute("cart", cart);
        int totalPrice = cart.stream().filter(CartItemDTO::isSelected).mapToInt(CartItemDTO::getPrice).sum();
        model.addAttribute("totalPrice", totalPrice);
        return "reservation";
    }

    /**
     * 결제 완료 처리
     */
    @PostMapping("reservation/complete")
    public String completeReservation(HttpSession session, Model model) {
        // 임시 로그인 고객 ID (테스트용)
        Integer customerId = (Integer) session.getAttribute("loginCustomerId");
        if (customerId == null) {
            customerId = 1; // 테스트 용 기본값
            session.setAttribute("loginCustomerId", customerId);
        }

        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return "redirect:/cart";
        }

        OrderDTO order = orderService.createOrder(customerId, cart);

        // 장바구니 비우기
        session.removeAttribute("cart");

        // 완료 화면에 표시할 데이터
        model.addAttribute("order", order);
        return "orderComplete";
    }

    /**
     * 예약 목록
     */
    @GetMapping("orders")
    public String orderList(HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("loginCustomerId");
        if (customerId == null) {
            return "redirect:/test/login";
        }
        List<OrderDTO> orders = orderService.getOrdersByCustomer(customerId);
        model.addAttribute("orders", orders);
        return "orderList";
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
        return "orderDetail";
    }
} 