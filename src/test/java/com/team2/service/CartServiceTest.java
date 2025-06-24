package com.team2.service;

import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import com.team2.mapper.CartMapper;
import junit.framework.TestCase;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class CartServiceTest extends TestCase {

    @Autowired
    CartService cartService;
    @Autowired
    CartMapper cartMapper;

    @Test
    public void testGetCartList() {
        Date now = new Date(System.currentTimeMillis());
        CartDTO cartDTO = new CartDTO(50000,1,1,2,now,now);
        cartDTO.setCustomerId(1);

        List<CartResponse> cartList = cartService.getCartList(cartDTO);
        assertEquals(0, cartList.size());
    }
    @Test
    public void testAddCart() {
        Date now = new Date(System.currentTimeMillis());
        CartDTO cartDTO = new CartDTO(50000,1,1,2,now,now);
        cartService.addCart(cartDTO);
        List<CartResponse> cartList = cartService.getCartList(cartDTO);
        assertEquals(1, cartList.size());
        assertEquals(cartDTO.getCustomerId(), cartList.get(0).getCustomerId());
    }

    public void testUpdatePeopleCnt() {
    }

    @Test
    public void testDeleteCart() {
        Date now = new Date(System.currentTimeMillis());
        CartDTO cartDTO = new CartDTO(50000,1,1,2,now,now);

        cartService.addCart(cartDTO);

        List<CartResponse> cartList = cartService.getCartList(cartDTO);
        assertEquals(1, cartList.size());

        cartService.deleteCart(cartDTO.getCartId(),  cartDTO.getCustomerId());

        cartList = cartService.getCartList(cartDTO);
        assertEquals(0, cartList.size());
    }

    @Before
    public void testDeleteAllCart() {
        cartService.deleteAllCart();
    }

}