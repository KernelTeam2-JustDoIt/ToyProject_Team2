package com.team2.controller.cart;

import com.team2.dto.cart.CartResponse;
import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.model.CustomerVO;
import com.team2.service.CustomerService;
import com.team2.service.cart.ShoppingCartService;
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
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals("nonMemberId")) {
                    nonmemberIdStr = cookie.getValue();
                    try {
                        customerId = Integer.parseInt(nonmemberIdStr);
                    } catch (NumberFormatException e) {
                        customerId = null;
                    }
                }
            }
        }
        if (loginCustomer != null) {
            customerId = loginCustomer.getCustomerId();
        }

        if (customerId == null) {
            model.addAttribute("cart", new ArrayList<CartResponse>());
        }
        else {
            List<CartResponse> cartList = shoppingCartService.getCartList(customerId);
            model.addAttribute("cart", cartList);
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

        if (customer == null) {
            String nonMemberIdStr = null;
            if (request.getCookies() != null) {
                for (Cookie cookie : request.getCookies()) {
                    if (cookie.getName().equals("nonMemberId")) {
                        nonMemberIdStr = cookie.getValue();
                    }
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
        shoppingCartService.addCartItem(cartItem);
        return ResponseEntity.ok("added");
    }

    /**
     * 장바구니에서 선택된 항목으로 예약/결제 화면으로 이동한다.
     */
    @PostMapping("/checkout")
    public String checkout(@RequestParam(value = "selectedCartId", required = false) List<Integer> selectedIds,
                           HttpSession session) {
        logger.info("=== Checkout 요청 시작 ===");
        logger.info("선택된 장바구니 ID들: {}", selectedIds);
        
        if (selectedIds == null || selectedIds.isEmpty()) {
            logger.warn("선택된 장바구니 항목이 없어서 장바구니로 리다이렉트");
            return "redirect:/cart";
        }

        // 예약 화면에서 조회할 수 있도록 선택된 장바구니 ID를 세션에 저장한다.
        session.setAttribute("selectedCartIds", selectedIds);
        logger.info("세션에 selectedCartIds 저장 완료, 예약 페이지로 리다이렉트");
        return "redirect:/reservation";
    }

    /**
     * 객실을 장바구니에 담은 뒤 즉시 예약 페이지로 이동한다.
     */
    @PostMapping("/addAndCheckout")
    public String addAndCheckout(@ModelAttribute ShoppingCartItemDTO cartItem, HttpSession session, HttpServletRequest request, HttpServletResponse response){
        com.team2.model.CustomerVO loginCustomer = (com.team2.model.CustomerVO) session.getAttribute("loginCustomer");
        Integer customerId = null;
        
        // 로그인된 사용자가 있으면 해당 사용자의 customerId 사용 (우선순위)
        if (loginCustomer != null) {
            customerId = loginCustomer.getCustomerId();
        } else {
            // 쿠키에서 비회원 ID 확인
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("nonMemberId")) {
                        String nonmemberIdStr = cookie.getValue();
                        try {
                            customerId = Integer.parseInt(nonmemberIdStr);
                        } catch (NumberFormatException e) {
                            customerId = null;
                        }
                        break;
                    }
                }
            }
            
            // 비회원 ID가 없으면 새로 생성
            if (customerId == null) {
                Integer nonMemberId = customerService.insertNonMember();
                Cookie cookie = new Cookie("nonMemberId", nonMemberId.toString());
                response.addCookie(cookie);
                customerId = nonMemberId;
            }
        }
        
        cartItem.setCustomerId(customerId);
        ShoppingCartItemDTO saved = shoppingCartService.addCartItem(cartItem);
        // 선택한 장바구니 ID를 세션에 저장한 뒤 예약 화면으로 이동한다.
        session.setAttribute("selectedCartIds", java.util.Collections.singletonList(saved.getCartId()));
        return "redirect:/reservation";
    }

    @PostMapping("/delete")
    public String deleteCart(
            @RequestParam("cartId") int cartId) {
        shoppingCartService.deleteCart(cartId);
        return "redirect:/cart";
    }
} 