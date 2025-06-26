package com.team2.service;

import com.team2.dto.order.ShoppingCartItemDTO;

import java.util.List;

public interface ShoppingCartService {
    List<ShoppingCartItemDTO> getCartItems(int customerId);

    ShoppingCartItemDTO addCartItem(ShoppingCartItemDTO item);

    void removeCartItems(List<Integer> cartIds);
} 