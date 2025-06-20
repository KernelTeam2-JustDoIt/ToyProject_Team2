package com.team2.mapper;

import com.team2.dto.cart.CartDTO;

import java.util.List;

public interface CartMapper {

    // 특정 회원의 장바구니 조회
    List<CartDTO> getCartList(CartDTO cartDTO);

    // 장바구니 추가
    void addCart(CartDTO cartDTO);

    // 장바구니 인원 수정
    int updateCart(CartDTO cartDTO);

    // 장바구니 삭제
    void deleteCart(int cartId);



}