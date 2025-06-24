package com.team2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration // 이 클래스는 설정 클래스임을 명시 (스프링 컨테이너가 읽어서 Bean으로 등록)
public class PasswordEncoderConfig {

    @Bean // 해당 메서드의 반환 객체를 스프링 빈으로 등록 (DI 대상이 됨)
    public PasswordEncoder passwordEncoder() {
        // BCrypt 암호화 알고리즘을 사용하는 PasswordEncoder Bean 생성
        // 회원가입, 로그인 등에서 비밀번호를 암호화/비교할 때 사용됨
        return new BCryptPasswordEncoder();
    }
}
