package com.team2.service;

import com.team2.model.CustomerVO;


public interface CustomerService {

    // 회원가입
    void registerCustomer(CustomerVO customer);

    // 로그인
    CustomerVO login(String customerLoginId, String customerPassword);

    boolean isPasswordCorrect(String rawPassword, String encodedPassword);

    // 아이디 중복 체크: true면 이미 존재하는 아이디
    boolean isLoginIdDuplicate(String customerLoginId);

    //  이메일 중복 체크: true면 이미 존재하는 이메일
    boolean isEmailDuplicate(String customerEmail);

    //  로그인 시 아이디로 조회 → 해시된 비밀번호 비교용
    CustomerVO findByLoginId(String customerLoginId);

    // 로그인 ID와 이메일로 고객 정보를 조회
    CustomerVO findCustomerByLoginIdAndEmail(String customerLoginId, String email);

    //비밀번호 변경 -> 비밀번호는 서비스 구현체에서 암호화(BCrypt 등)한 후 전달
    void updatePassword(String customerLoginId, String newPassword);

    //고객 계정을 탈퇴 처리
    void deactivateCustomer(int customerId);

    CustomerVO updateCustomerInfo(CustomerVO loginCustomer, CustomerVO updatedCustomerVo);

    //비회원 customerId
    CustomerVO findCustomerById(int customerId);

    Integer insertNonMember();
}