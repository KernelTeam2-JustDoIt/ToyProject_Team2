package com.team2.service;

import com.team2.mapper.CustomerMapper;
import com.team2.model.CustomerVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {

    // 로깅을 위한 Logger 객체
    private static final Logger log = LoggerFactory.getLogger(CustomerServiceImpl.class);

    // 의존성 주입: MyBatis 매퍼
    private final CustomerMapper customerMapper;

    // 의존성 주입: 비밀번호 암호화를 위한 PasswordEncoder
    private final PasswordEncoder passwordEncoder;

    // 생성자 기반 의존성 주입
    public CustomerServiceImpl(CustomerMapper customerMapper, PasswordEncoder passwordEncoder) {
        this.customerMapper = customerMapper;
        this.passwordEncoder = passwordEncoder;
    }

    // 회원가입 로직
    @Override
    public void registerCustomer(CustomerVO customer) {
        if (customer == null || customer.getCustomerLoginId() == null) {
            log.warn("잘못된 고객 정보: {}", customer); // 예외 상황 로그 출력
            throw new IllegalArgumentException("잘못된 고객 정보입니다.");
        }

        log.info("회원가입 요청: {}", customer.getCustomerLoginId());

        // 비밀번호 암호화
        String rawPassword = customer.getCustomerPassword();
        String encodedPassword = passwordEncoder.encode(rawPassword);
        customer.setCustomerPassword(encodedPassword);

        // DB에 고객 정보 저장
        customerMapper.insertCustomer(customer);
    }

    // 로그인 처리 로직
    @Override
    public CustomerVO login(String customerLoginId, String customerPassword) {
        // DB에서 고객 정보 조회 (비밀번호 암호화 비교를 위해 ID 기준 조회)
        CustomerVO foundCustomer = customerMapper.findByLoginId(customerLoginId);

        // 고객이 존재하지 않으면 예외 발생
        if (foundCustomer == null) {
            log.warn("로그인 실패 - 존재하지 않는 아이디: {}", customerLoginId);
            throw new IllegalStateException("UNKNOWN_ID");
        }

        // 계정이 잠긴 상태인 경우
        if (foundCustomer.getCustomerStatusId() == 2) {
            throw new IllegalStateException("LOCKED");
        }

        // 입력한 비밀번호가 일치하지 않는 경우
        if (isPasswordCorrect(customerPassword, foundCustomer.getCustomerPassword())) {
            log.warn("로그인 실패 - 비밀번호 불일치: {}", customerLoginId);

            // 로그인 실패 횟수 증가
            customerMapper.loginFail(foundCustomer.getCustomerId());

            // 실패 횟수가 3 이상이면 계정 잠금 처리
            int cnt = customerMapper.getLoginFailedCount(foundCustomer.getCustomerId());
            System.out.println(cnt + "실패횟수");
            if (cnt >= 3) {
                customerMapper.lockAccount(foundCustomer.getCustomerId());
            }

            throw new IllegalStateException("WRONG_PASSWORD");
        }

        // 로그인 성공 시
        log.info("로그인 성공: {}", customerLoginId);
        customerMapper.loginSuccess(foundCustomer.getCustomerId());
        return foundCustomer;
    }

    @Override
    public boolean isPasswordCorrect(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    // 아이디 중복 여부 확인
    @Override
    public boolean isLoginIdDuplicate(String customerLoginId) {
        log.info("아이디 중복 체크 요청: {}", customerLoginId);
        int count = customerMapper.countByLoginId(customerLoginId);
        return count > 0;
    }

    // 이메일 중복 여부 확인
    @Override
    public boolean isEmailDuplicate(String customerEmail) {
        log.info("이메일 중복 체크 요청: {}", customerEmail);
        int count = customerMapper.countByEmail(customerEmail);
        return count > 0;
    }

    // 로그인 ID로 고객 정보 조회
    @Override
    public CustomerVO findByLoginId(String customerLoginId) {
        return customerMapper.findByLoginId(customerLoginId);
    }

    // 로그인 ID + 이메일로 고객 조회 (비밀번호 찾기용)
    @Override
    public CustomerVO findCustomerByLoginIdAndEmail(String loginId, String email) {
        return customerMapper.selectByLoginIdAndEmail(loginId, email);
    }

    // 비밀번호 재설정 로직
    @Override
    public void updatePassword(String customerLoginId, String newPassword) {
        // 기존 고객 조회
        CustomerVO customer = customerMapper.findByLoginId(customerLoginId);
        if (customer == null) {
            throw new RuntimeException("사용자를 찾을 수 없습니다.");
        }

        // 새 비밀번호 암호화 후 저장
        String encoded = passwordEncoder.encode(newPassword);
        customerMapper.updatePassword(customer.getCustomerLoginId(), encoded);

        // 잠긴 계정이면 잠금 해제
        customerMapper.unlockAccount(customer.getCustomerId());
    }

    // 회원 탈퇴 처리 (고객 상태값 변경)
    @Override
    public void deactivateCustomer(int customerId) {
        customerMapper.deactivateCustomer(customerId);
    }

    @Override
    public CustomerVO updateCustomerInfo(CustomerVO loginCustomer, CustomerVO updatedCustomer) {
        // TODO updatedCustomer 를 확인해서 입력 안한 값들은 어떻게 값이 넘어오나 확인후 입력 안된 값은 loginCustomer 에서 꺼내서 체우기
        modifyInfo(updatedCustomer, loginCustomer);
        customerMapper.updateCustomerInfo(updatedCustomer);
        return updatedCustomer;
    }

    private void modifyInfo(CustomerVO updatedCustomer, CustomerVO loginCustomer) {
        updatedCustomer.setCustomerId(loginCustomer.getCustomerId());
        if (updatedCustomer.getCustomerName() == null) {
            updatedCustomer.setCustomerName(loginCustomer.getCustomerName());
        }
        if (updatedCustomer.getCustomerTel() == null) {
            updatedCustomer.setCustomerTel(loginCustomer.getCustomerTel());
        }
        if (updatedCustomer.getCustomerEmail() == null) {
            updatedCustomer.setCustomerEmail(loginCustomer.getCustomerEmail());
        }
        if (updatedCustomer.getCustomerLoginId() == null) {
            updatedCustomer.setCustomerLoginId(loginCustomer.getCustomerLoginId());
        }
        if (updatedCustomer.getCustomerJob() == null) {
            updatedCustomer.setCustomerJob(loginCustomer.getCustomerJob());
        }
        if (updatedCustomer.getCustomerAge() == 0) {
            updatedCustomer.setCustomerAge(loginCustomer.getCustomerAge());
        }
        if (updatedCustomer.getCustomerGender() == null) {
            updatedCustomer.setCustomerGender(loginCustomer.getCustomerGender());
        }
    }
}
