package com.team2.mapper;

import com.team2.dto.Admin.AdminDTO;

public interface AdminMapper {
    AdminDTO getAdminById(int adminId);

    AdminDTO loginAdmin(String email, String password);

    void insertAdmin(AdminDTO admin);

    void updateAdmin(AdminDTO admin);

    void deleteAdmin(int adminId);
}
