package com.team2.service;

import com.team2.dto.Admin.AdminDTO;

public interface AdminService {

    // ID로 조회
    AdminDTO getAdminById(int adminId);

    // 로그인
    AdminDTO loginAdmin(String email, String password);

    // 등록
    void insertAdmin(AdminDTO admin);

    // 수정
    void updateAdmin(AdminDTO admin);

    // 삭제
    void deleteAdmin(int adminId);
}
