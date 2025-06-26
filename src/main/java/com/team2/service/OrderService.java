package com.team2.service;

import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.dto.order.OrderDTO;

import java.util.List;

public interface OrderService {

    /**
     * 장바구니 항목들을 기반으로 주문을 생성하고 결제를 완료 처리합니다.
     * @param customerId 로그인 사용자 ID
     * @param cartItems 결제할 장바구니 항목
     * @return 생성된 주문 정보
     */
    OrderDTO createOrder(int customerId, List<ShoppingCartItemDTO> cartItems);

    /**
     * 특정 사용자에 대한 주문(예약) 목록
     */
    List<OrderDTO> getOrdersByCustomer(int customerId);

    /**
     * 주문 상세 조회
     */
    OrderDTO getOrderDetail(int orderId);
} 