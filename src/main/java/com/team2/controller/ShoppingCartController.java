package com.team2.controller;

import com.team2.dto.cart.CartDTO;
import com.team2.model.Customer;
import com.team2.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class ShoppingCartController {

    @Autowired
    CartService cartService;

//    @GetMapping("/")
//    public String cart() {
//        return "cart";
//    }

    // 장바구니 목록 조회
    @GetMapping("/list")
    // customerId 매개변수 추가해야 함?
    public String getCartList(CartDTO cartDTO, Model model, @SessionAttribute("loginUser") Customer loginCustomer) {
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        List<CartDTO> cartList = cartService.getCartList(cartDTO);

        for (CartDTO cartInfo : cartList) {
            System.out.println(cartInfo);
        }
        model.addAttribute("cartList", cartList);
        return "cart";
    }

    @PostMapping("/add")
    public String addCart(CartDTO cartDTO, HttpSession session, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        String originUrl = (String) session.getAttribute("originUrl"); // 상품팀에 url attribute 요청
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartService.addCart(cartDTO);
        return "redirect:" + originUrl;
    }

    @PostMapping("/update")
    public String updateCart(CartDTO cartDTO, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartService.updateCart(cartDTO);
        return "redirect:/cart/list";
    }
    @PostMapping("/delete")
    public String deleteCart(@RequestParam("cartId")int cartId, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        cartService.deleteCart(cartId);
        return "redirect:/cart/list";
    }
}