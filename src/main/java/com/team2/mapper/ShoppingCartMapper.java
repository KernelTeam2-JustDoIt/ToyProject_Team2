package com.team2.mapper;

import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import com.team2.dto.order.ShoppingCartItemDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ShoppingCartMapper {

    List<ShoppingCartItemDTO> selectCartItemsByCustomer(@Param("customerId") int customerId);

    ShoppingCartItemDTO selectById(@Param("cartId") int cartId);

    int insertCartItem(ShoppingCartItemDTO item);

    int deleteById(@Param("cartId") int cartId);

    int deleteByIds(@Param("cartIds") List<Integer> cartIds);

    // 고객+방으로 조회
    CartDTO findByCustomerAndRoom(ShoppingCartItemDTO item);

    // 장바구니 인원 수정
    void updatePeopleCnt(ShoppingCartItemDTO item);

    List<CartResponse> getCartList(@Param("customerId") int customerId );
}

