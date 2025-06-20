package com.team2.service;

import com.team2.dto.cart.CartDTO;
import com.team2.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class CartService {

    @Autowired
    CartMapper cartMapper;

    public List<CartDTO> getCartList(CartDTO cartDTO) {
        List<CartDTO> result = cartMapper.getCartList(cartDTO);
        return result;
    }

    public void addCart(CartDTO cartDTO) {
        cartMapper.addCart(cartDTO);
    }

    public int updateCart(CartDTO cartDTO) {
        return cartMapper.updateCart(cartDTO);
    }

//    public void deleteCart(int cartId) {
//        cartMapper.deleteCart(int cartId);
//    }
}