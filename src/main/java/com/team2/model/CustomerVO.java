package com.team2.model;

import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Getter
@Setter
public class CustomerVO {
    private Integer customerId;
    private Integer customerStatusId; // 고객 상태 ID (추가됨)
    private String customerName; // 고객명
    private String customerTel; // 고객 전화번호
    private String customerEmail; // 고객 이메일
    private String customerLoginId; // 로그인 ID
    private String customerPassword; // 로그인 비밀번호
    private String customerGender; // 성별
    private Integer customerAge; // 나이
    private Integer isMarketingUseAgreed; // 마케팅 수신 동의 (이름 변경됨)
    private String customerJob; // 직업
    private Integer gradeId; // 고객 등급 ID
    private Timestamp joinedAt; // 가입일
    private Timestamp gradeExpireDate; // 등급 만료일
    private Integer point; //고객 포인트

    @Override
    public String toString() {
        return "CustomerVO{" +
                "customerId=" + customerId +
                ", customerStatusId=" + customerStatusId +
                ", customerName='" + customerName + '\'' +
                ", customerTel='" + customerTel + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerLoginId='" + customerLoginId + '\'' +
                ", customerPassword='" + customerPassword + '\'' +
                ", customerGender='" + customerGender + '\'' +
                ", customerAge=" + customerAge +
                ", isMarketingUseAgreed=" + isMarketingUseAgreed +
                ", customerJob='" + customerJob + '\'' +
                ", gradeId=" + gradeId +
                ", joinedAt=" + joinedAt +
                ", gradeExpireDate=" + gradeExpireDate +
                ", point=" + point +
                '}';
    }
}
