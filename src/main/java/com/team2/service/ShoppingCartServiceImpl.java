package com.team2.service;

import com.team2.dto.accommdetail.RoomDTO;
import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.mapper.AccommDetailMapper;
import com.team2.mapper.ShoppingCartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartServiceImpl implements ShoppingCartService {

    @Autowired
    private ShoppingCartMapper shoppingCartMapper;

    @Autowired
    AccommDetailMapper accommDetailMapper;

    @Override
    public List<ShoppingCartItemDTO> getCartItems(int customerId) {
        return shoppingCartMapper.selectCartItemsByCustomer(customerId);
    }

    @Override
    public ShoppingCartItemDTO addCartItem(ShoppingCartItemDTO item) {
        // 동일 회원 + 동일 객실 중복 방지 -> 과제 평가사항에 있음
        CartDTO existing = shoppingCartMapper.findByCustomerAndRoom(item);
        if (existing != null) {
            throw new IllegalArgumentException("장바구니에 동일 상품이 존재합니다.");
        } else {
            shoppingCartMapper.insertCartItem(item);
        }
        return shoppingCartMapper.selectById(item.getCartId());
    }

    @Override
    public void removeCartItems(List<Integer> cartIds) {
        if (cartIds != null && !cartIds.isEmpty()) {
            shoppingCartMapper.deleteByIds(cartIds);
        }
    }

    // 장바구니 인원 수정
    public void updatePeopleCnt(ShoppingCartItemDTO item) {
        // 어른, 아이 인원이 -가 되면 안됨
        if (item.getAdultCount() < 0 || item.getChildCount() < 0) {
            throw new IllegalArgumentException("체크인 인원은 0명보다 작을 수 없습니다.");
        }
        int total = item.getAdultCount() + item.getChildCount();
        RoomDTO room = accommDetailMapper.findRoomById(item.getRoomId());
        if (room.getMaximumCapacity() < total) {
            throw new IllegalArgumentException("희망인원이 객실 최대 인원보다 많을 수 없습니다.");
        }
        shoppingCartMapper.updatePeopleCnt(item);
    }

    public List<CartResponse> getCartList(int customerId) {
        System.out.println("ShoppingCartServiceImpl.getCartList");
        System.out.println("customerId = " + customerId);
        return shoppingCartMapper.getCartList(customerId);
    }
} 