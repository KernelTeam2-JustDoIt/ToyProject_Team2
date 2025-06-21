package com.team2.service;

import com.team2.dto.cart.CartDTO;
import com.team2.mapper.CartMapper;
import com.team2.model.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CartService {

    @Autowired
    CartMapper cartMapper;

    // 회원의 장바구니 리스트 조회
    public List<CartDTO> getCartList(CartDTO cartDTO) {
        List<CartDTO> result = cartMapper.getCartList(cartDTO);
        return result;
    }

    // 장바구니 추가
    public void addCart(CartDTO cartDTO) {
//        보통 서비스에는 @Autowired CartMapper cartMapper 만 두고,
//        검증 로직(isValidDateRange)은 DTO 인스턴스 메서드로 구현해서
//        cartDTO.isValidDateRange() 처럼 쓰는 게 깔끔합니다.

        Cart cart = new Cart();
        if (!cart.isValidDateRange()) {
            throw new IllegalArgumentException("체크아웃 날짜는 체크인 이후여야 합니다.");
        }
        cartMapper.addCart(cartDTO);
    }

    // 장바구니 인원 수정
    public int updateCart(CartDTO cartDTO) {
        // 장바구니 총 인원이 룸 최대 인원보다 많을 경우 검사
       int total = cartDTO.getAdultCount() + cartDTO.getChildCount();
       // 룸 최대인원
        int capacity =
        if (total > capacity)
        throw new IllegalArgumentException("선택하신 인원(" + total + "명)이 객실 수용인원(" + capacity + "명)을 초과합니다.");{
        }

        Cart cart = new Cart();
        if (!cart.isValidDateRange()) {
            throw new IllegalArgumentException("체크아웃 날짜는 체크인 이후여야 합니다.");
        }
        cartMapper.addCart(cartDTO);

        return cartMapper.updateCart(cartDTO);
    }

    // 장바구니 삭제
    public void deleteCart(int cartId) {
        cartMapper.deleteCart(cartId);
    }
}