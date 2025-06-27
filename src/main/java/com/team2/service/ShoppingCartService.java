package com.team2.service;

import com.team2.dto.cart.CartResponse;
import com.team2.dto.order.ShoppingCartItemDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShoppingCartService {
    List<ShoppingCartItemDTO> getCartItems(int customerId);

    ShoppingCartItemDTO addCartItem(ShoppingCartItemDTO item);

    void removeCartItems(List<Integer> cartIds);

    void updatePeopleCnt(ShoppingCartItemDTO item);

    List<CartResponse> getCartList(@Param("customerId") int customerId);
} 