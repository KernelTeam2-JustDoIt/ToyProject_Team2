package com.team2.mapper.order;

import com.team2.dto.order.ReserveDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReserveMapper {
    int insertReserve(ReserveDTO reserve);

    ReserveDTO selectById(int reserveId);
} 