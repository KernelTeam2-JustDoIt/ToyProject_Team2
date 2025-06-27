package com.team2.controller;

import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.service.OrderService;
import com.team2.service.ShoppingCartService;
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

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 예약/결제 화면 출력
     */
    @GetMapping("reservation")
    public String reservationPage(HttpSession session, Model model) {
        List<Integer> selectedIds = (List<Integer>) session.getAttribute("selectedCartIds");
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if (selectedIds == null || selectedIds.isEmpty()) {
            System.out.println("111111");
            System.out.println(selectedIds);
            System.out.println(loginCustomer);
            return "redirect:/cart";
        }


        Integer customerId = loginCustomer.getCustomerId();
        List<ShoppingCartItemDTO> items = shoppingCartService.getCartItems(customerId);
        items.removeIf(i -> !selectedIds.contains(i.getCartId()));
        if (items.isEmpty()) {
            System.out.println("2222222222222");
            return "redirect:/cart";
        }

        model.addAttribute("cart", items);
        int totalPrice = items.stream().mapToInt(ShoppingCartItemDTO::getPrice).sum();
        model.addAttribute("totalPrice", totalPrice);
        return "order/reservation";
    }

    /**
     * 결제 완료 처리
     */
    @PostMapping("reservation/complete")
    public String completeReservation(HttpSession session, Model model) {
        List<Integer> selectedIds = (List<Integer>) session.getAttribute("selectedCartIds");
        if (selectedIds == null || selectedIds.isEmpty()) {
            return "redirect:/cart";
        }

        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) {
            return "redirect:/customer/login"; // 로그인 필요
        }

        Integer customerId = loginCustomer.getCustomerId();
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
     * 예약 목록
     */
    @GetMapping("orders")
    public String orderList(HttpSession session, Model model) {
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) {
            return "redirect:/customer/login";
        }
        Integer customerId = loginCustomer.getCustomerId();
        List<OrderDTO> orders = orderService.getOrdersByCustomer(customerId);
        model.addAttribute("orders", orders);
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
} 