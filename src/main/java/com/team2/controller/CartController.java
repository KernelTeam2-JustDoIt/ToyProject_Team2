package com.team2.controller;

import com.team2.dto.order.CartItemDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    /**
     * 장바구니 페이지
     */
    @GetMapping("")
    public String cartPage(HttpSession session, Model model) {
        List<CartItemDTO> cart = getCart(session);
        model.addAttribute("cart", cart);
        return "cart";
    }

    /**
     * 상품을 장바구니에 추가
     */
    @PostMapping("/add")
    public String addToCart(@ModelAttribute CartItemDTO cartItem, HttpSession session) {
        List<CartItemDTO> cart = getCart(session);
        cart.add(cartItem);
        session.setAttribute("cart", cart);
        // 단순 팝업 처리를 위해 redirect url param 사용
        return "redirect:/cart?added=true";
    }

    /**
     * 결제 화면으로 이동 (선택된 아이템)
     */
    @PostMapping("/checkout")
    public String checkout(HttpSession session) {
        // 선택된 항목은 이미 cartItem.selected 로 판단 가능 (프론트에서 처리)
        return "redirect:/reservation";
    }

    @SuppressWarnings("unchecked")
    private List<CartItemDTO> getCart(HttpSession session) {
        Object obj = session.getAttribute("cart");
        if (obj == null) {
            List<CartItemDTO> list = new ArrayList<>();
            session.setAttribute("cart", list);
            return list;
        }
        return (List<CartItemDTO>) obj;
    }
} 