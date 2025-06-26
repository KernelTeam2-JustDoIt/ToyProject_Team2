package com.team2.service;

import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.mapper.ShoppingCartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Override
    public List<ShoppingCartItemDTO> getCartItems(int customerId) {
        return shoppingCartMapper.selectCartItemsByCustomer(customerId);
    }

    @Override
    public ShoppingCartItemDTO addCartItem(ShoppingCartItemDTO item) {
        shoppingCartMapper.insertCartItem(item);
        return shoppingCartMapper.selectById(item.getCartId());
    }

    @Override
    public void removeCartItems(List<Integer> cartIds) {
        if (cartIds != null && !cartIds.isEmpty()) {
            shoppingCartMapper.deleteByIds(cartIds);
        }
    }
} 