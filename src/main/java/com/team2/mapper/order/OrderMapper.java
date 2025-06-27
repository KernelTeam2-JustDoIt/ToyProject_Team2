package com.team2.mapper.order;

import com.team2.dto.order.OrderDTO;
import com.team2.dto.order.OrderItemDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OrderMapper {

    int insertOrder(OrderDTO order);

    int insertOrderItem(OrderItemDTO item);

    List<OrderDTO> selectOrdersByCustomerId(int customerId);

    OrderDTO selectOrderById(int orderId);

    List<OrderItemDTO> selectOrderItems(int orderId);
} 