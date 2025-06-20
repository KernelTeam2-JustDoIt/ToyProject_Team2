package com.team2.controller;

import com.team2.dto.cart.CartDTO;
import com.team2.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class ShoppingCartController {

    @Autowired
    CartService cartService;

    @GetMapping("/")
    public String cart() {
        return "cart";
    }

    @GetMapping("/info")
    public String getCartList(CartDTO cartDTO, Model model) {
        List<CartDTO> cartList = cartService.getCartList(cartDTO);

        for (CartDTO cartInfo : cartList) {
            System.out.println(cartInfo);
        }
        model.addAttribute("cartList", cartList);
        return "cart";
    }

}