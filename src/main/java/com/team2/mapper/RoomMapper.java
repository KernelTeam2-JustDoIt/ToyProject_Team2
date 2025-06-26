package com.team2.mapper;

import com.team2.dto.accommdetail.RoomDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface RoomMapper {
    List<RoomDTO> selectAllRooms();
    RoomDTO selectRoomById(int roomId);
} 