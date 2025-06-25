package com.team2.service;

import com.team2.dto.order.CartItemDTO;
import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.OrderItemDTO;
import com.team2.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Override
    @Transactional
    public OrderDTO createOrder(int customerId, List<CartItemDTO> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("결제할 상품이 없습니다.");
        }

        // 총 금액 계산
        int totalPrice = cartItems.stream().mapToInt(CartItemDTO::getPrice).sum();

        // Order 정보 생성
        OrderDTO order = new OrderDTO();
        order.setCustomerId(customerId);
        order.setTotalPrice(totalPrice);
        order.setStatus("COMPLETED"); // 간단하게 결제 완료 처리
        order.setOrderDate(LocalDateTime.now());

        // 1. orders 테이블 insert
        orderMapper.insertOrder(order); // orderId 생성됨

        // 2. order_items 테이블 insert
        List<OrderItemDTO> items = new ArrayList<>();
        for (CartItemDTO cartItem : cartItems) {
            OrderItemDTO item = new OrderItemDTO();
            item.setOrderId(order.getOrderId());
            item.setAccommId(cartItem.getAccommId());
            item.setRoomName(cartItem.getRoomName());
            item.setPrice(cartItem.getPrice());
            item.setQuantity(1);
            orderMapper.insertOrderItem(item);
            items.add(item);
        }

        order.setItems(items);
        return order;
    }

    @Override
    public List<OrderDTO> getOrdersByCustomer(int customerId) {
        return orderMapper.selectOrdersByCustomerId(customerId);
    }

    @Override
    public OrderDTO getOrderDetail(int orderId) {
        OrderDTO order = orderMapper.selectOrderById(orderId);
        if (order != null) {
            order.setItems(orderMapper.selectOrderItems(orderId));
        }
        return order;
    }
} 