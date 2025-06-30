# Yanupja - 숙박 예약 플랫폼 🏨

> **야눕자**는 국내 숙박시설 예약을 위한 종합 플랫폼입니다.  
> 호텔, 모텔, 펜션, 캠핑장 등 다양한 숙박시설을 검색하고 예약할 수 있습니다.

## 📋 목차
- [주요 기능](#주요-기능)
- [기술 스택](#기술-스택)
- [프로젝트 구조](#프로젝트-구조)
- [설치 및 실행](#설치-및-실행)
- [데이터베이스 설정](#데이터베이스-설정)
- [API 엔드포인트](#api-엔드포인트)
- [개발팀](#개발팀)

## 🎯 주요 기능

### 🔍 숙박시설 검색 및 예약
- **지역별 숙박시설 검색**: 전국 숙박시설을 지역별로 검색
- **다양한 숙박 타입**: 호텔, 모텔, 펜션, 캠핑장 카테고리별 조회
- **상세 정보 제공**: 시설 정보, 객실 정보, 이용 후기, 이미지 갤러리
- **실시간 예약**: 체크인/체크아웃 날짜 선택 및 실시간 예약 처리

### 👤 사용자 관리
- **회원가입/로그인**: 일반 회원가입 및 로그인 기능
- **비회원 예약**: 회원가입 없이도 예약 가능
- **마이페이지**: 예약 내역 조회, 개인정보 수정
- **비밀번호 찾기**: 이메일을 통한 비밀번호 재설정

### 🛒 예약 및 결제
- **장바구니 기능**: 여러 숙박시설을 장바구니에 담아 한 번에 예약
- **직접 예약**: 숙소 상세페이지에서 바로 예약
- **예약 관리**: 예약 내역 조회 및 관리

### 💬 고객 지원
- **리뷰 시스템**: 숙박 후기 작성 및 평점 관리
- **QnA**: 1:1 문의 및 답변 시스템
- **FAQ**: 자주 묻는 질문 관리
- **공지사항**: 서비스 관련 공지사항 제공

### 🔧 관리자 기능
- **숙박시설 관리**: 숙소 정보 등록, 수정, 삭제
- **예약 관리**: 전체 예약 현황 모니터링
- **사용자 관리**: 회원 정보 및 문의사항 관리
- **콘텐츠 관리**: 공지사항, FAQ 관리

## 🛠 기술 스택

### Backend
- **Java 11**: 메인 개발 언어
- **Spring Framework 5.3.32**: 의존성 주입 및 MVC 패턴
- **Spring MVC**: 웹 애플리케이션 프레임워크
- **Spring Security**: 비밀번호 암호화
- **MyBatis 3.5.15**: 데이터베이스 ORM

### Frontend
- **JSP**: 서버 사이드 렌더링
- **JSTL**: JSP 표준 태그 라이브러리
- **HTML5 / CSS3**: 마크업 및 스타일링
- **JavaScript**: 클라이언트 사이드 스크립팅

### Database
- **MySQL 8.0**: 메인 데이터베이스
- **HikariCP**: 커넥션 풀 관리

### Build & Tools
- **Maven**: 프로젝트 빌드 도구
- **Lombok**: 코드 간소화
- **Logback**: 로깅 프레임워크
- **Jackson**: JSON 데이터 처리

### Email Service
- **JavaMail API**: 이메일 전송 기능
- **Gmail SMTP**: 이메일 서비스 제공

## 📁 프로젝트 구조

```
ToyProject_Team2/
├── src/main/java/com/team2/
│   ├── controller/          # 컨트롤러 계층
│   │   ├── accomm/         # 숙박시설 관련
│   │   ├── cart/           # 장바구니 관련  
│   │   ├── order/          # 주문/예약 관련
│   │   ├── myPage/         # 마이페이지 관련
│   │   └── admin/          # 관리자 관련
│   ├── service/            # 서비스 계층
│   ├── mapper/             # MyBatis 매퍼 인터페이스
│   ├── dto/                # 데이터 전송 객체
│   ├── model/              # 도메인 모델
│   └── config/             # 설정 클래스
├── src/main/resources/
│   ├── mapper/             # MyBatis XML 매퍼
│   ├── applicationContext.xml
│   └── mybatis-config.xml
├── src/main/webapp/
│   ├── WEB-INF/views/      # JSP 뷰 파일
│   └── resources/          # 정적 리소스 (CSS, JS, 이미지)
└── db_src/                 # 데이터베이스 스크립트
```

## 🚀 설치 및 실행

### 필요 조건
- **Java 11** 이상
- **Maven 3.6** 이상  
- **MySQL 8.0** 이상
- **Apache Tomcat 9.0** 이상

### 1. 프로젝트 클론
```bash
git clone https://github.com/your-username/ToyProject_Team2.git
cd ToyProject_Team2
```

### 2. 데이터베이스 설정
MySQL에서 다음 스크립트를 순서대로 실행:

```sql
-- 1. 데이터베이스 생성
CREATE DATABASE JDI;
USE JDI;

-- 2. 테스트용 DDL 실행
SOURCE db_src/JDI_DDL_TEST.sql;

-- 3. 숙박시설 테이블 생성
SOURCE db_src/ACCOMM_CREATE_YNL.sql;

-- 4. 숙박시설 샘플 데이터 삽입
SOURCE db_src/ACCOMM_INSERT_INTO_YNL.sql;
```

### 3. 데이터베이스 연결 설정
`src/main/resources/applicationContext.xml` 파일에서 데이터베이스 연결 정보를 수정:

```xml
<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource">
    <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
    <property name="jdbcUrl" value="jdbc:mysql://localhost:3306/JDI?serverTimezone=Asia/Seoul"/>
    <property name="username" value="your_username"/>
    <property name="password" value="your_password"/>
    <property name="maximumPoolSize" value="10"/>
</bean>
```

### 4. 이메일 설정 (선택사항)
비밀번호 찾기 기능을 사용하려면 `applicationContext.xml`에서 Gmail 설정을 수정:

```xml
<bean id="mailSender" class="org.springframework.mail.javamail.JavaMailSenderImpl">
    <property name="username" value="your-email@gmail.com"/>
    <property name="password" value="your-app-password"/>
</bean>
```

### 5. 프로젝트 빌드 및 실행
```bash
# Maven 빌드
mvn clean compile

# WAR 파일 생성
mvn package

# Tomcat에 배포 후 서버 시작
# 브라우저에서 http://localhost:8080/yanupja 접속
```

## 🗄 데이터베이스 설정

### 주요 테이블 구조
- **CUSTOMER**: 고객 정보
- **ACCOMMODATION**: 숙박시설 정보  
- **ROOM**: 객실 정보
- **RESERVATION**: 예약 정보
- **REVIEW**: 리뷰 정보
- **CART**: 장바구니 정보
- **NOTICE**: 공지사항
- **QNA**: 문의사항

### ERD
데이터베이스 상세 구조는 `db_src/JDI_DDL.sql` 파일을 참조하세요.

## 🌐 API 엔드포인트

### 메인 페이지
- `GET /` - 메인 페이지

### 숙박시설 관련
- `GET /domestic` - 국내 숙박시설 메인
- `GET /accomm/detail` - 숙박시설 상세 정보
- `GET /room` - 객실 정보

### 사용자 관련  
- `GET /customer/login` - 로그인 페이지
- `POST /customer/login` - 로그인 처리
- `GET /customer/join` - 회원가입 페이지
- `POST /customer/join` - 회원가입 처리

### 예약 관련
- `GET /cart` - 장바구니 조회
- `POST /cart/add` - 장바구니 추가
- `GET /reservation` - 예약 페이지
- `POST /reservation/complete` - 예약 완료

### 고객 지원
- `GET /notice` - 공지사항 목록
- `GET /faq` - FAQ 목록  
- `GET /qna` - QnA 목록

### 관리자
- `GET /accommodations` - 숙박시설 관리
- `GET /admin` - 관리자 페이지

## 👥 개발팀

이 프로젝트는 **Team2_일단 해**에서 개발되었습니다.

---

## 📝 라이선스

이 프로젝트는 교육 목적으로 개발되었습니다.

---

**📞 문의사항이 있으시면 언제든 연락해 주세요!**
