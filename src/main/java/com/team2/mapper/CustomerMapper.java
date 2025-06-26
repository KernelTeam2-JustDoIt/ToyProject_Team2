package com.team2.mapper;

import com.team2.model.CustomerVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper // MyBatis 매퍼 인터페이스임을 나타냄
public interface CustomerMapper {

    // 회원가입 시 고객 정보를 DB에 저장
    void insertCustomer(CustomerVO customer);

    // 로그인 처리용: 로그인 ID와 암호화된 비밀번호로 고객 정보 조회 (단, 사용하지 않는 경우도 있음)
    CustomerVO findByLoginIdAndPassword(
            @Param("customerLoginId") String customerLoginId,
            @Param("customerPassword") String customerPassword
    );

    // 로그인 처리용: 로그인 ID로 고객 조회 (비밀번호는 서비스에서 검증)
    CustomerVO findByLoginId(@Param("customerLoginId") String customerLoginId);

    // 아이디 중복 체크용: 같은 ID를 가진 고객 수 조회
    int countByLoginId(@Param("customerLoginId") String customerLoginId);

    // 이메일 중복 체크용: 같은 이메일을 가진 고객 수 조회
    int countByEmail(@Param("customerEmail") String customerEmail);

    // 로그인 성공 시 호출: 로그인 실패 횟수 초기화 등 처리
    void loginSuccess(int customerId);

    // 로그인 실패 시 호출: 실패 횟수 증가 등 처리
    void loginFail(int customerId);

    // 로그인 실패 횟수 조회
    int getLoginFailedCount(int customerId);

    // 계정 잠금 처리 (지정된 실패 횟수 초과 시)
    void lockAccount(int customerId);

    // 계정 잠금 해제 (예: 관리자 또는 본인 확인 등으로 해제 시)
    void unlockAccount(int customerId);

    // 회원 탈퇴 처리 (일반적으로 활성 상태 값을 false 처리)
    void deactivateCustomer(int customerId);

    // 비밀번호 재설정 시: 로그인 ID와 이메일이 일치하는 고객 정보 조회
    CustomerVO selectByLoginIdAndEmail(@Param("customerLoginId") String customerLoginId,
                                       @Param("email") String email);

    // 비밀번호 변경 처리 (새 비밀번호는 암호화된 상태로 전달됨)
    void updatePassword(@Param("customerLoginId") String customerLoginId,
                        @Param("encoded") String encoded);

    //Customer DB 날림
    void deleteAllCustomers();


    CustomerVO findCustomerById(int customerId);


    void insertNonMember(CustomerVO nonMember);

    // 고객 정보 수정
    void updateCustomerInfo(CustomerVO updatedCustomer);
}
