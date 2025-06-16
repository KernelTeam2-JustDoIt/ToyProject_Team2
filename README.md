# 🏨 야눕자 (YANUPJA)
야놀자를 벤치마킹하여 구현한 Spring 기반 숙박 예약 플랫폼입니다.

---

## 📌 프로젝트 개요

| 항목 | 내용 |
|------|------|
| **프로젝트명** | 야눕자 (YANUPJA) |
| **목표** | Spring Framework 기반 예약 플랫폼 구축 |
| **사용 언어** | Java 11 |
| **프레임워크** | Spring Framework 5.3.32 (MVC) |
| **DBMS** | MySQL 8.0.36 이상 |
| **ORM** | MyBatis 3.5.15 |
| **빌드 도구** | Maven |
| **배포 방식** | WAR (Tomcat 9.0.106) |

---

## ⚙️ 프로젝트 설정 요약

| 설정 항목 | 값 |
|-----------|----|
| **DB 이름** | `yanupja` |
| **DB 사용자** | `yanupja` |
| **비밀번호** | `2222` |
| **JDBC URL** | `jdbc:mysql://localhost:3306/yanupja?serverTimezone=Asia/Seoul` |
| **JDBC 드라이버** | `com.mysql.cj.jdbc.Driver` |
| **인코딩** | UTF-8 |
| **JSP 경로 prefix** | `/WEB-INF/views/` |
| **JSP 확장자 suffix** | `.jsp` |
| **MyBatis 설정파일** | `src/main/resources/mybatis-config.xml` |
| **Mapper 스캔 위치** | `com.team2.mapper` |

---

## 📁 디렉토리 구조

```
src/
 └── main/
     ├── java/
     │    └── com.team2/
     │         ├── controller/
     │         ├── service/
     │         ├── mapper/
     │         └── model/
     ├── resources/
     │    ├── mybatis-config.xml
     │    └── mapper/
     └── webapp/
          ├── WEB-INF/
          │    ├── views/
          │    └── spring/
          │         ├── root-context.xml
          │         └── appServlet/
          │              └── servlet-context.xml
          └── web.xml
```

---

## 🧪 실행 방법

1. MySQL에서 `yanupja` DB 생성 및 사용자 생성 (`yanupja / 2222`)
2. 프로젝트를 IntelliJ에서 import (Maven 프로젝트로 인식)
3. 톰캣 서버 설정 및 프로젝트 배포 설정
4. `http://localhost:8080/` 접속 테스트
5. JSP 출력 정상 여부 확인 후 기능 개발 진행

---

## 🚧 향후 작업 예정

- [ ] DB 테이블 생성 및 DDL 정리
- [ ] 회원가입/로그인 기능 개발
- [ ] 숙소 목록 및 예약/결제 로직 설계
- [ ] 관리자 기능 (추후)
- [ ] 후기 요약 기능 (GPT 연동 검토)

---

## 📚 참고

- Spring Framework 공식 문서: https://spring.io/projects/spring-framework
- MyBatis 공식 문서: https://mybatis.org
- Jakarta EE 문서: https://jakarta.ee
