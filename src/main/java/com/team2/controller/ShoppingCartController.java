//package com.team2.controller;
//import com.team2.dto.cart.CartDTO;
//import com.team2.dto.cart.CartResponse;
//import com.team2.dto.order.ShoppingCartItemDTO;
//import com.team2.model.CustomerVO;
//import com.team2.service.CartService;
//import com.team2.service.CustomerService;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.*;
//import javax.servlet.http.Cookie;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.util.ArrayList;
//import java.util.List;
//
////@Controller
//@RequestMapping("/cart")
//@SessionAttributes("cartListSession")// 클래스 레벨에서 세션 선언에서 어디서나 쓸 수 있게
//public class ShoppingCartController {
//
//    private static final Logger logger = LoggerFactory.getLogger(ShoppingCartController.class);
//
////    @Autowired
//    CartService cartService;
//
////    @Autowired
//    CustomerService customerService;
//
//    // 장바구니 목록 조회
//    @GetMapping("/list")
//    public String getCartList(
//            Model model
//            ,@SessionAttribute(name="loginCustomer", required = false) CustomerVO loginCustomer
//            , HttpServletRequest  request
//            ) {
//        Integer customerId = null;
//        String nonmemberIdStr = null;
//        for (Cookie cookie : request.getCookies()) {
//            if (cookie.getName().equals("nonMemberId")) {
//                nonmemberIdStr = cookie.getValue();
//                customerId = Integer.parseInt(nonmemberIdStr);
//            }
//        }
//        if (loginCustomer != null) {
//            customerId = loginCustomer.getCustomerId();
//        }
//
//        if (customerId == null) {
//            model.addAttribute("cartList", new ArrayList<CartResponse>());
//        }
//        else {
//            List<CartResponse> cartList = cartService.getCartList(customerId);
//            model.addAttribute("cartList", cartList);
//            System.out.println(cartList);
//        }
//        return "cart";
//    }
//
//    @PostMapping("/add")
//    @ResponseBody
//    public ResponseEntity<String> addCart(@RequestBody CartDTO cartDTO,
//                                          HttpServletResponse response,
//                                          HttpSession session
//                                         , HttpServletRequest request) {
//        CustomerVO customer = (CustomerVO) session.getAttribute("loginCustomer");
//        if (customer == null) {
//            String nonMemberIdStr = null;
//            for (Cookie cookie : request.getCookies()) {
//                if (cookie.getName().equals("nonMemberId")) {
//                    nonMemberIdStr = cookie.getValue();
//                }
//            }
//            if (nonMemberIdStr == null) {
//                Integer nonMemberId = customerService.insertNonMember();
//                Cookie cookie = new Cookie("nonMemberId", nonMemberId.toString());
//                response.addCookie(cookie);
//            }
//            else {
//                cartDTO.setCustomerId(Integer.parseInt(nonMemberIdStr));
//            }
//        }
//        else {
//            cartDTO.setCustomerId(customer.getCustomerId());
//        }
//        cartService.addCart(cartDTO);
//        return ResponseEntity.ok("added");
//    }
//
//    @PostMapping("/update")
//    public String updatePeopleCnt(ShoppingCartItemDTO item) {
//        try {
//            cartService.updatePeopleCnt(item);
//        } catch (IllegalArgumentException e) {
//            logger.error(e.getMessage());
//        }
//        return "redirect:/cart/list";
//    }
//
//    @PostMapping("/delete")
//    public String deleteCart(
//            @RequestParam("cartId") int cartId) {
//        cartService.deleteCart(cartId);
//        return "redirect:/cart/list";
//    }
//}