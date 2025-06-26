package com.team2.service;

import com.team2.dto.accommdetail.RoomDTO;
import java.util.List;

/**
 * 객실(Room) 조회 비즈니스 로직 인터페이스.
 */
public interface RoomService {

    /**
     * 판매가능한 모든 객실 목록
     */
    List<RoomDTO> getAllRooms();

    /**
     * 객실 단건 조회
     */
    RoomDTO getRoom(int roomId);
} 