package com.team2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration // 스프링 설정 클래스임을 나타냄
public class MailConfig {

    @Bean // JavaMailSender 객체를 스프링 빈으로 등록
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

        // Gmail SMTP 서버 설정
        mailSender.setHost("smtp.gmail.com"); // Gmail SMTP 서버 주소
        mailSender.setPort(587); // TLS 포트 (STARTTLS)

        // 이메일 인증 정보 설정
        mailSender.setUsername("kernelteam2jdi@gmail.com"); // 보내는 이메일 주소
        mailSender.setPassword("svaieothjdtxtwyo"); // Gmail 계정의 앱 비밀번호 (일반 비번 아님)

        // 추가적인 SMTP 속성 설정
        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp"); // 이메일 전송 프로토콜
        props.put("mail.smtp.auth", "true"); // SMTP 인증 사용
        props.put("mail.smtp.starttls.enable", "true"); // TLS 보안 연결 사용
        props.put("mail.debug", "true"); // 디버깅 메시지 출력 (콘솔 로그에 이메일 전송 정보 표시됨)

        return mailSender; // 설정이 완료된 mailSender 반환
    }
}
