package com.team2.service;

import com.team2.dto.Admin.AdminDTO;
import com.team2.mapper.AdminMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public AdminDTO getAdminById(int adminId) {
        return adminMapper.getAdminById(adminId);
    }

    @Override
    public AdminDTO loginAdmin(String email, String password) {
        return adminMapper.loginAdmin(email, password);
    }

    @Override
    public void insertAdmin(AdminDTO admin) {
        adminMapper.insertAdmin(admin);
    }

    @Override
    public void updateAdmin(AdminDTO admin) {
        adminMapper.updateAdmin(admin);
    }

    @Override
    public void deleteAdmin(int adminId) {
        adminMapper.deleteAdmin(adminId);
    }
}
