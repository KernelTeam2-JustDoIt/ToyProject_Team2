package com.team2.controller;

import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 장바구니 메인 페이지를 반환한다.
     * <p>
     * 로그인되지 않은 사용자는 로그인 페이지로 리다이렉트된다.
     * </p>
     */
    @GetMapping("")
    public String cartPage(HttpSession session, Model model) {
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) {
            return "redirect:/customer/login";
        }

        Integer customerId = loginCustomer.getCustomerId();
        List<ShoppingCartItemDTO> items = shoppingCartService.getCartItems(customerId);
        model.addAttribute("cart", items);
        return "order/cart";
    }

    /**
     * 선택한 객실을 장바구니에 추가한다.
     * 로그인되어 있지 않은 경우 로그인 페이지로 이동한다.
     */
    @PostMapping("/add")
    public String addToCart(@ModelAttribute ShoppingCartItemDTO cartItem, HttpSession session) {
        // Integer customerId = (Integer) session.getAttribute("loginCustomerId");
        // if (customerId == null) {
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if (loginCustomer == null) {
            return "redirect:/customer/login";
        }
        Integer customerId = loginCustomer.getCustomerId();
        cartItem.setCustomerId(customerId);
        shoppingCartService.addCartItem(cartItem);
        return "redirect:/cart?added=true";
    }

    /**
     * 장바구니에서 선택된 항목으로 예약/결제 화면으로 이동한다.
     */
    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedCartId", required = false) List<Integer> selectedIds,
                           HttpSession session) {
        if (selectedIds == null || selectedIds.isEmpty()) {
            return "redirect:/cart";
        }

        // 예약 화면에서 조회할 수 있도록 선택된 장바구니 ID를 세션에 저장한다.
        session.setAttribute("selectedCartIds", selectedIds);
        return "redirect:/reservation";
    }

    /**
     * 객실을 장바구니에 담은 뒤 즉시 예약 페이지로 이동한다.
     */
    @PostMapping("/addAndCheckout")
    public String addAndCheckout(@ModelAttribute ShoppingCartItemDTO cartItem, HttpSession session){
        // Integer customerId = (Integer) session.getAttribute("loginCustomerId");
        // if(customerId == null){
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        if(loginCustomer == null){
            return "redirect:/customer/login";
        }
        Integer customerId = loginCustomer.getCustomerId();
        cartItem.setCustomerId(customerId);
        ShoppingCartItemDTO saved = shoppingCartService.addCartItem(cartItem);
        // 선택한 장바구니 ID를 세션에 저장한 뒤 예약 화면으로 이동한다.
        session.setAttribute("selectedCartIds", java.util.Collections.singletonList(saved.getCartId()));
        return "redirect:/reservation";
    }
} 