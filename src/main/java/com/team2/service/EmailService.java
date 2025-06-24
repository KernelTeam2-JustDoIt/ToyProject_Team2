package com.team2.service;

public interface EmailService {

    // 이메일로 인증코드 전송
    void sendVerificationEmail(String toEmail, String verificationCode);

    // 인증코드 생성
    String generateCode();
}
