package com.team2.service;

import com.team2.dto.cart.CartDTO;
import com.team2.dto.cart.CartResponse;
import com.team2.mapper.CartMapper;
import com.team2.model.Cart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CartService {

    @Autowired
    CartMapper cartMapper;

    // 회원의 장바구니 리스트 조회
    public List<CartResponse> getCartList(CartDTO cartDTO) {
        List<CartResponse> result = cartMapper.getCartList(cartDTO.getCustomerId());
        return result;
    }

    // 장바구니 추가
    public void addCart(CartDTO cartDTO) {
        Cart cart = new Cart();
        if (!cart.isValidDateRange()) {
            throw new IllegalArgumentException("체크아웃 날짜는 체크인 이후여야 합니다.");
        }

        // 동일 회원 + 동일 객실 중복 방지 -> 과제 평가사항에 있음
        CartDTO existing = cartMapper.findByCustomerAndRoom(
                cartDTO.getCustomerId(),
                cartDTO.getRoomId()
        );

        if (existing != null) {
            throw new IllegalArgumentException("장바구니에 동일 상품이 존재합니다.");
        } else {
            cartMapper.addCart(cartDTO);
        }
    }

    // 장바구니 인원 수정
    public int updatePeopleCnt(CartDTO cartDTO) {
        // 어른, 아이 인원이 -가 되면 안됨
        if (cartDTO.getAdultCount() < 0 || cartDTO.getChildCount() < 0) {
            throw new IllegalArgumentException("체크인 인원은 0명보다 작을 수 없습니다.");
        }

        // 장바구니 총 인원이 룸 최대 인원보다 많을 경우 검사
//        int total = cartDTO.getAdultCount() + cartDTO.getChildCount();
//        int capacity = PagingConditionDTO.getTotalPepleCnt();
//        //int capacity = roomService.getRoomCapacity(cartDTO.getRoomId()); ??
//        if (total > capacity)
//        throw new IllegalArgumentException("선택하신 인원(" + total + "명)이 객실 수용인원(" + capacity + "명)을 초과합니다.");{
//        }

        Cart cart = new Cart();
        cart.setDesiredCheckInAt(cartDTO.getDesiredCheckInAt());
        cart.setDesiredCheckOutAt(cartDTO.getDesiredCheckOutAt());

        if (!cart.isValidDateRange()) {
            throw new IllegalArgumentException("체크아웃 날짜는 체크인 날짜 이후여야 합니다.");
        }
//        cartMapper.addCart(cartDTO);

        return cartMapper.updatePeopleCnt(cartDTO);
    }

    // 장바구니 삭제
    public void deleteCart(int cartId, int customerId) {

        // 동일 회원 + 동일 객실 중복 방지 -> 과제 평가사항에 있음
        CartDTO existing = cartMapper.findByCustomerIdAndCartId(
                customerId,
                cartId
        );

        if (existing == null) {
            throw new IllegalArgumentException("장바구니에 해당하는 정보가 없습니다.");
        } else {
            cartMapper.deleteCart(cartId);
        }


    }
}