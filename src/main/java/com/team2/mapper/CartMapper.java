package com.team2.mapper;

import com.team2.dto.cart.CartAddDTO;
import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CartMapper {

    // 장바구니 조회
    List<CartResponse> getCartList(@Param("customerId") int customerId );

    // 장바구니 추가
    void addCart(CartDTO cartDTO);

    // 장바구니 인원 수정
    void updatePeopleCnt(CartDTO cartDTO);

    // 장바구니 삭제
    void deleteCart(int cartId);

    // 모든 장바구니 삭제
    void deleteAllCart();

    // 고객+방으로 조회
    CartDTO findByCustomerAndRoom(CartDTO cartDTO);

    // 고객+카트 번호로 조회 -> 다른 고객꺼 지우기 방지용
    CartDTO findByCustomerIdAndCartId(
            @Param("customerId") int customerId,
            @Param("cartId")     int cartId
    );

    List<CartAddDTO> findByCustomer(int customerId);

}