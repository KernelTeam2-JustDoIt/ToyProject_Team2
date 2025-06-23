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
    public String getCartList(CartDTO cartDTO, Model model, @SessionAttribute("loginUser") Customer loginCustomer) {
        cartDTO.setCustomerId(loginCustomer.getCustomerId());

        if (loginCustomer == null) {
            // 세션이 없으면 로그인 페이지로
            return "redirect:/login";
        }

        List<CartDTO> cartList = cartService.getCartList(cartDTO);

        for (CartDTO cartInfo : cartList) {
            System.out.println(cartInfo);
        }
        model.addAttribute("cartList", cartList);
        return "cart";
    }

    @PostMapping("/add")
    public String addCart(CartDTO cartDTO, HttpSession session, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        if (loginCustomer == null) {
            // 세션이 없으면 로그인 페이지로
            return "redirect:/login";
        }
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        String originUrl = (String) session.getAttribute("originUrl"); // 상품팀에 url attribute 요청
        if (originUrl == null) originUrl = "/cart/list";
        cartService.addCart(cartDTO);
        System.out.println("[TEST] addCart 호출: " + cartDTO);
        return "redirect:" + originUrl;
    }

    @PostMapping("/update")
    public String updatePeopleCnt(CartDTO cartDTO, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        if (loginCustomer == null) {
            // 세션이 없으면 로그인 페이지로
            return "redirect:/login";
        }
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartService.updatePeopleCnt(cartDTO);
        return "redirect:/cart/list";
    }

    @PostMapping("/delete")
// 매개변수 cartDTO 지우고 싶은데 잘 모르겠음
    public String deleteCart(CartDTO cartDTO, @RequestParam("cartId")int cartId, @SessionAttribute("loginCustomer") Customer loginCustomer) {
        if (loginCustomer == null) {
            return "redirect:/login";
        }
        cartDTO.setCustomerId(loginCustomer.getCustomerId());
        cartService.deleteCart(cartId);
        return "redirect:/cart/list";
    }
}