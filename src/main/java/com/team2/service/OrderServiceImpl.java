package com.team2.service;

import com.team2.dto.order.ShoppingCartItemDTO;
import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.OrderItemDTO;
import com.team2.dto.order.ReserveDTO;
import com.team2.dto.order.PaymentDTO;
import com.team2.dto.accommdetail.RoomDTO;
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
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

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
            item.setAccommId(roomInfo != null ? roomInfo.getAccommodationId() : cartItem.getRoomId());
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
                // LocalTime을 String으로 변환하여 설정
                item.setCheckInTime(roomInfo.getCheckinTime() != null ? roomInfo.getCheckinTime().toString() : "");
                item.setCheckOutTime(roomInfo.getCheckoutTime() != null ? roomInfo.getCheckoutTime().toString() : "");
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

            // 각 아이템의 리뷰 작성 가능 여부 계산
            for (OrderItemDTO item : items) {
                // 매퍼에서 이미 체크인/체크아웃 날짜와 숙소 정보를 가져왔으므로 추가 처리 불필요
                // 리뷰 작성 가능 여부만 계산
                calculateReviewEligibility(item, order.getStatus());
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
                // 매퍼에서 이미 체크인/체크아웃 날짜와 숙소 정보를 가져왔으므로 추가 처리 불필요
                // 리뷰 작성 가능 여부만 계산
                calculateReviewEligibility(item, order.getStatus());
            }
            order.setItems(items);
        }
        return order;
    }
    
    /**
     * 리뷰 작성 가능 여부를 계산하는 메서드
     * @param item 주문 아이템
     * @param orderStatus 주문 상태
     */
    private void calculateReviewEligibility(OrderItemDTO item, String orderStatus) {
        // 주문 상태가 완료가 아니면 리뷰 작성 불가
        if (!"COMPLETED".equals(orderStatus)) {
            item.setCanWriteReview(false);
            item.setDaysAfterCheckout(0);
            return;
        }
        
        try {
            String checkOutDateStr = item.getCheckOutDate();
            if (checkOutDateStr != null && !checkOutDateStr.isEmpty()) {
                // 날짜 형식이 "yyyy-MM-dd" 또는 "yyyy-MM-dd HH:mm:ss" 형태일 수 있음
                String dateOnly = checkOutDateStr.split(" ")[0]; // 날짜 부분만 추출
                LocalDate checkOutDate = LocalDate.parse(dateOnly, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                LocalDate today = LocalDate.now();
                
                long daysBetween = ChronoUnit.DAYS.between(checkOutDate, today);
                item.setDaysAfterCheckout(daysBetween);
                
                // 체크아웃 후 7일 이내이면 리뷰 작성 가능
                item.setCanWriteReview(daysBetween <= 7 && daysBetween >= 0);
            } else {
                item.setCanWriteReview(false);
                item.setDaysAfterCheckout(0);
            }
        } catch (Exception e) {
            // 날짜 파싱 오류 시 리뷰 작성 불가
            item.setCanWriteReview(false);
            item.setDaysAfterCheckout(0);
        }
    }
} 