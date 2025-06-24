package com.team2.dto.Admin;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class AdminDTO {

    private int adminId;                // 관리자 ID
    private Integer deptId;            // 부서 ID (nullable)
    private int roleId;                // 역할 ID (ADMIN 등 역할을 숫자로 표현)
    private LocalDateTime roleGrantDate; // 권한 부여일
    private String adminName;          // 이름
    private String adminTel;           // 전화번호
    private String adminEmail;         // 이메일
    private String adminPassword;      // 비밀번호

    private LocalDateTime createdAt;   // 생성일
    private LocalDateTime updatedAt;   // 수정일
    private Integer createdBy;         // 생성자
    private Integer updatedBy;         // 수정자

}
