package com.team2.mapper;

import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CartMapper {

    // 특정 회원의 장바구니 조회
    List<CartResponse> getCartList(@Param("customerId") int customerId );

    // 장바구니 추가
    void addCart(CartDTO cartDTO);

    // 장바구니 인원 수정
    int updatePeopleCnt(CartDTO cartDTO);

    // 장바구니 삭제
    void deleteCart(int cartId);

    // 고객+방으로 조회
    CartDTO findByCustomerAndRoom(
            @Param("customerId") int customerId,
            @Param("roomId")     int roomId
    );

    CartDTO findByCustomerIdAndCartId(
            @Param("customerId") int customerId,
            @Param("cartId")     int cartId
    );

}