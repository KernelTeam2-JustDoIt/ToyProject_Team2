package com.team2.service;

import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.OrderItemDTO;
import com.team2.dto.order.ReserveDTO;
import com.team2.dto.order.PaymentDTO;
import com.team2.dto.RoomDTO;
import com.team2.mapper.OrderMapper;
import com.team2.mapper.ReserveMapper;
import com.team2.mapper.PaymentMapper;
import com.team2.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private ReserveMapper reserveMapper;

    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private RoomService roomService;

    @Override
    @Transactional
    public OrderDTO createOrder(int customerId, List<ShoppingCartItemDTO> cartItems) {
        if (cartItems == null || cartItems.isEmpty()) {
            throw new IllegalArgumentException("결제할 상품이 없습니다.");
        }

        // 총 금액 계산
        int totalPrice = cartItems.stream().mapToInt(ShoppingCartItemDTO::getPrice).sum();

        // Order 정보 생성
        OrderDTO order = new OrderDTO();
        order.setCustomerId(customerId);
        order.setTotalPrice(totalPrice);
        order.setStatus("COMPLETED"); // 간단하게 결제 완료 처리
        order.setOrderDate(new Date());

        // 1. orders 테이블 insert
        orderMapper.insertOrder(order); // orderId 생성됨

        // 2. order_items 테이블 insert
        List<OrderItemDTO> items = new ArrayList<>();
        for (ShoppingCartItemDTO cartItem : cartItems) {
            // 객실 상세 정보 조회
            RoomDTO roomInfo = roomService.getRoom(cartItem.getRoomId());

            OrderItemDTO item = new OrderItemDTO();
            item.setOrderId(order.getOrderId());
            item.setAccommId(cartItem.getRoomId());
            item.setRoomName(cartItem.getRoomName());
            item.setAccommodationName(roomInfo != null ? roomInfo.getAccommodationName() : "");
            item.setPrice(cartItem.getPrice());
            item.setQuantity(1);

            // 체크인/체크아웃 날짜 및 시간, 인원 정보
            String checkIn = cartItem.getDesiredCheckInAt();
            String checkOut = cartItem.getDesiredCheckOutAt();
            if(checkIn == null || checkIn.isEmpty()) {
                checkIn = java.time.LocalDateTime.now().toString();
            }
            if(checkOut == null || checkOut.isEmpty()) {
                checkOut = java.time.LocalDateTime.now().plusDays(1).toString();
            }
            item.setCheckInAt(checkIn);
            item.setCheckOutDate(checkOut);
            if (roomInfo != null) {
                item.setCheckInTime(roomInfo.getCheckInTime());
                item.setCheckOutTime(roomInfo.getCheckOutTime());
                item.setStandardCapacity(roomInfo.getStandardCapacity());
                item.setMaximumCapacity(roomInfo.getMaximumCapacity());
            }

            orderMapper.insertOrderItem(item);
            items.add(item);

            // --- 추가 : RESERVE, PAYMENT 레코드 생성 ---
            ReserveDTO reserve = new ReserveDTO();
            reserve.setReserverId(customerId);
            reserve.setRoomId(cartItem.getRoomId());
            reserve.setCheckInAt(checkIn);
            reserve.setCheckOutDate(checkOut);
            reserveMapper.insertReserve(reserve);

            PaymentDTO payment = new PaymentDTO();
            payment.setReserveId(reserve.getReserveId());
            payment.setPrice(cartItem.getPrice());
            paymentMapper.insertPayment(payment);

            item.setReserveId(reserve.getReserveId());
        }

        order.setItems(items);
        return order;
    }

    @Override
    public List<OrderDTO> getOrdersByCustomer(int customerId) {
        List<OrderDTO> orders = orderMapper.selectOrdersByCustomerId(customerId);
        if (orders == null || orders.isEmpty()) return orders;

        for (OrderDTO order : orders) {
            List<OrderItemDTO> items = orderMapper.selectOrderItems(order.getOrderId());

            // 각 아이템 정보 보강
            for (OrderItemDTO item : items) {
                RoomDTO roomInfo = roomService.getRoom(item.getAccommId());
                if (roomInfo != null) {
                    item.setAccommodationName(roomInfo.getAccommodationName());
                    item.setCheckInTime(roomInfo.getCheckInTime());
                    item.setCheckOutTime(roomInfo.getCheckOutTime());
                    item.setStandardCapacity(roomInfo.getStandardCapacity());
                    item.setMaximumCapacity(roomInfo.getMaximumCapacity());
                }
            }
            order.setItems(items);
        }
        return orders;
    }

    @Override
    public OrderDTO getOrderDetail(int orderId) {
        OrderDTO order = orderMapper.selectOrderById(orderId);
        if (order != null) {
            List<OrderItemDTO> items = orderMapper.selectOrderItems(orderId);
            for (OrderItemDTO item : items) {
                RoomDTO roomInfo = roomService.getRoom(item.getAccommId());
                if (roomInfo != null) {
                    item.setAccommodationName(roomInfo.getAccommodationName());
                    item.setCheckInTime(roomInfo.getCheckInTime());
                    item.setCheckOutTime(roomInfo.getCheckOutTime());
                    item.setStandardCapacity(roomInfo.getStandardCapacity());
                    item.setMaximumCapacity(roomInfo.getMaximumCapacity());
                }
            }
            order.setItems(items);
        }
        return order;
    }
} 