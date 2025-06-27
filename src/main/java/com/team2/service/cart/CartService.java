package com.team2.service.cart;

import com.team2.dto.accommdetail.RoomDTO;
import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import com.team2.mapper.AccommDetailMapper;
import com.team2.mapper.cart.CartMapper;
import com.team2.model.cart.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartService {

    @Autowired
    CartMapper cartMapper;

    @Autowired
    AccommDetailMapper accommDetailMapper;

    // 회원의 장바구니 리스트 조회
    public List<CartResponse> getCartList(int customerId) {
        return cartMapper.getCartList(customerId);
    }

    // 장바구니 추가
    public void addCart(CartDTO cartDTO) {
        System.out.println("3. Service    received cartDTO: " + cartDTO);

        // 동일 회원 + 동일 객실 중복 방지 -> 과제 평가사항에 있음
        CartDTO existing = cartMapper.findByCustomerAndRoom(cartDTO);

        if (existing != null) {
            throw new IllegalArgumentException("장바구니에 동일 상품이 존재합니다.");
        } else {
            cartMapper.addCart(cartDTO);
        }
    }

    // 장바구니 인원 수정
    public void updatePeopleCnt(CartDTO cartDTO) {
        // 어른, 아이 인원이 -가 되면 안됨
        if (cartDTO.getAdultCount() < 0 || cartDTO.getChildCount() < 0) {
            throw new IllegalArgumentException("체크인 인원은 0명보다 작을 수 없습니다.");
        }
        int total = cartDTO.getAdultCount() + cartDTO.getChildCount();
        RoomDTO room = accommDetailMapper.findRoomById(cartDTO.getRoomId());
        if (room.getMaximumCapacity() < total) {
            throw new IllegalArgumentException("희망인원이 객실 최대 인원보다 많을 수 없습니다.");
        }
        cartMapper.updatePeopleCnt(cartDTO);
    }

    // 장바구니 삭제
    public void deleteCart(int cartId) {
        cartMapper.deleteCart(cartId);
    }

    // 장바구니 모두 삭제
    public void deleteAllCart() {
        cartMapper.deleteAllCart();
    }
}