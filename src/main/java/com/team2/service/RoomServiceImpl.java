package com.team2.service;

import com.team2.dto.accommdetail.RoomDTO;
import com.team2.mapper.RoomMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomMapper roomMapper;

    @Override
    public List<RoomDTO> getAllRooms() {
        return roomMapper.selectAllRooms();
    }

    @Override
    public RoomDTO getRoom(int roomId) {
        return roomMapper.selectRoomById(roomId);
    }
} 