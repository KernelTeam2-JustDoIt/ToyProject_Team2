package com.team2.controller;

import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
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

    @GetMapping("/")
    public String cart() {
        return "cart";
    }

    // 장바구니 목록 조회
    @GetMapping("/list")
    public String getCartList(CartDTO cartDTO, Model model) {
//        cartDTO.setCustomerId(loginCustomer.getCustomerId());

//        if (loginCustomer == null) {
//            // 세션이 없으면 로그인 페이지로
//            return "redirect:/login";
//        }
        cartDTO.setCustomerId(3); // test
        List<CartResponse> cartList = cartService.getCartList(cartDTO);

        for (CartResponse cartInfo : cartList) {
            System.out.println(cartInfo.getCartId());
        }
        model.addAttribute("cartList", cartList);
        return "cart";
    }

    @PostMapping("/add")
    public String addCart(CartDTO cartDTO, HttpSession session
//                          ,@SessionAttribute("loginCustomer") Customer loginCustomer
    ) {
//        if (loginCustomer == null) {
//            // 세션이 없으면 로그인 페이지로
//            return "redirect:/login";
//        }

//        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartDTO.setCustomerId(3); // test;

        String originUrl = (String) session.getAttribute("originUrl"); // 상품팀에 url attribute 요청
        if (originUrl == null) originUrl = "/cart/list";
        cartService.addCart(cartDTO);
        System.out.println("[TEST] addCart 호출: " + cartDTO);
        return "redirect:" + originUrl;
    }

    @PostMapping("/update")
    public String updatePeopleCnt(CartDTO cartDTO
//            , @SessionAttribute("loginCustomer") Customer loginCustomer
            ) {
//        if (loginCustomer == null) {
//            // 세션이 없으면 로그인 페이지로
//            return "redirect:/login";
//        }
//        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartDTO.setCustomerId(3);
        cartService.updatePeopleCnt(cartDTO);
        return "redirect:/cart/list";
    }

    @PostMapping("/delete")
    public String deleteCart(
            @RequestParam("cartId") int cartId
//            ,@SessionAttribute("loginCustomer") Customer loginCustomer
//            ,@RequestParam("customerId") int customerId
    ) {
//        if (loginCustomer == null) {
//            return "redirect:/login";
//        }

//        cartDTO.setCustomerId(3); // test

        int customerId = 3;

        cartService.deleteCart(cartId, customerId);
        return "redirect:/cart/list";
    }
}