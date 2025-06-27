package com.team2.controller;

import com.team2.dto.cart.CartResponse;
import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.model.CustomerVO;
import com.team2.service.CustomerService;
import com.team2.service.ShoppingCartService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {
    private static final Logger logger = LoggerFactory.getLogger(CartController.class);

    @Autowired
    private ShoppingCartService shoppingCartService;

    @Autowired
    CustomerService customerService;

    @GetMapping("")
    public String cartPage(
            Model model
            ,@SessionAttribute(name="loginCustomer", required = false) CustomerVO loginCustomer
            , HttpServletRequest request
    ) {
        Integer customerId = null;
        String nonmemberIdStr = null;
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("nonMemberId")) {
                nonmemberIdStr = cookie.getValue();
                customerId = Integer.parseInt(nonmemberIdStr);
                System.out.println("customerId = " + customerId);
            }
        }
        if (loginCustomer != null) {
            System.out.println("loginCustomer != null");
            customerId = loginCustomer.getCustomerId();
        }

        if (customerId == null) {
            System.out.println("customerId == null");
            model.addAttribute("cartList", new ArrayList<CartResponse>());
        }
        else {
            List<CartResponse> cartList = shoppingCartService.getCartList(customerId);
            model.addAttribute("cartList", cartList);
            System.out.println(cartList);
        }
        return "order/cart";
    }

    @PostMapping("/update")
    public String updatePeopleCnt(ShoppingCartItemDTO item) {
        try {
            shoppingCartService.updatePeopleCnt(item);
        } catch (IllegalArgumentException e) {
            logger.error(e.getMessage());
        }
        return "redirect:/cart/"; // 혜정님 cart 페이지로 돌아가게 수정
    }


    /**
     * 선택한 객실을 장바구니에 추가한다.
     * 로그인되어 있지 않은 경우 로그인 페이지로 이동한다.
     */
    @PostMapping("/add")
    @ResponseBody
     // 지훈님 JSON 받을려고 영경 추가
    public ResponseEntity<String> addToCart(@RequestBody ShoppingCartItemDTO cartItem
                            , HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        CustomerVO customer = (CustomerVO) session.getAttribute("loginCustomer");
        System.out.println("cartItem.getRoomId() = " + cartItem.getRoomId());
        if (customer == null) {
            String nonMemberIdStr = null;
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("nonMemberId")) {
                    nonMemberIdStr = cookie.getValue();
                }
            }
            if (nonMemberIdStr == null) {
                Integer nonMemberId = customerService.insertNonMember();
                Cookie cookie = new Cookie("nonMemberId", nonMemberId.toString());
                response.addCookie(cookie);
            }
            else {
                cartItem.setCustomerId(Integer.parseInt(nonMemberIdStr));
            }
        }
        else {
            cartItem.setCustomerId(customer.getCustomerId());
        }
        System.out.println("cartItem = " + cartItem);
        shoppingCartService.addCartItem(cartItem);
        return ResponseEntity.ok("added");
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