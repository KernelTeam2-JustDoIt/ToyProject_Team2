package com.team2.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service
public class EmailServiceImpl implements EmailService {

    private static final Logger log = LoggerFactory.getLogger(EmailServiceImpl.class); // 로깅 객체 추가

    @Autowired  // JavaMailSender 의존성 주입 (Spring 방식)
    private JavaMailSender mailSender;

    //인증 이메일 전송 메서드
    @Override
    public void sendVerificationEmail(String toEmail, String verificationCode) {
        // 제목과 HTML 본문 정의
        String subject = "회원가입 이메일 인증 코드";
        String content = "<h3>안녕하세요!</h3>"
                + "<p>요청하신 이메일 인증 코드는 아래와 같습니다:</p>"
                + "<h2 style='color:blue'>" + verificationCode + "</h2>"
                + "<p>해당 코드를 회원가입 페이지에 입력해주세요.</p>";

        try {
            // MIME 메시지 생성 및 구성
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);           // 수신자 이메일
            helper.setSubject(subject);      // 메일 제목
            helper.setText(content, true);   // HTML 본문

            mailSender.send(message);        // 메일 전송
            log.info("이메일 전송 성공: {}", toEmail);
        } catch (MessagingException e) {
            log.error("❌ 이메일 전송 실패: {}", e.getMessage()); // 예외 로깅
            throw new RuntimeException("이메일 전송에 실패했습니다.");
        }
    }

    // 인증코드 생성 메서드 (6자리 랜덤 숫자)
    @Override
    public String generateCode() {
        int code = (int)(Math.random() * 900000) + 100000; // 100000 ~ 999999 사이의 정수
        return String.valueOf(code);
    }
}
