package com.team2.service.myPage;

import com.team2.model.CustomerVO;
import org.springframework.beans.factory.annotation.Autowired;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.Optional;

public class MyPageServiceImpl implements MyPageService {

    private static final Logger logger = LoggerFactory.getLogger(MyPageServiceImpl.class);

//    @Autowired
//    CustomerService customerService;

    @Override
    public Optional<CustomerVO> getCustomerInfo(int customerId) {
//        logger.info("고객 정보 조회 시도: customerId = {}", customerId);
//        try {
//            // TODO: customerService.getCustomerById(customerId) 메서드가 실제로 구현될 예정
//            // 현재는 더미 데이터 또는 예외 처리를 위한 임시 구현
//            Optional<CustomerVO> customer = customerService.getCustomerById(customerId);
//            if (customer.isPresent()) {
//                logger.info("고객 정보 조회 성공: customerLoginId = {}", customer.get().getCustomerLoginId());
//            } else {
//                logger.warn("고객 ID {} 에 해당하는 정보를 찾을 수 없습니다.", customerId);
//            }
//            return customer;
//        } catch (Exception e) {
//            logger.error("고객 정보 조회 중 오류 발생: customerId = {}", customerId, e);
//            return Optional.empty();
//        }
        return Optional.empty();
    }

    @Override
    public boolean updateCustomerInfo(CustomerVO customerVO) {
//        logger.info("고객 정보 업데이트 시도: customerLoginId = {}", customerDTO.getCustomerLoginId());
//        try {
//            // TODO: customerService.updateCustomer(customerDTO) 메서드가 실제로 구현될 예정
//            // 임시 구현 (실제 로직은 다른 팀원의 CustomerService에 의존)
//            customerDTO.setUpdatedAt(LocalDateTime.now()); // 업데이트 시간 기록
//            boolean isUpdated = customerService.updateCustomer(customerDTO);
//            if (isUpdated) {
//                logger.info("고객 정보 업데이트 성공: customerLoginId = {}", customerDTO.getCustomerLoginId());
//            } else {
//                logger.warn("고객 정보 업데이트 실패: customerLoginId = {}", customerDTO.getCustomerLoginId());
//            }
//            return isUpdated;
//        } catch (Exception e) {
//            logger.error("고객 정보 업데이트 중 오류 발생: customerLoginId = {}", customerDTO.getCustomerLoginId(), e);
//            return false;
//        }
        return false;
    }

    @Override
    public boolean changePassword(int customerId, String oldPassword, String newPassword) {
//        logger.info("비밀번호 변경 시도: customerId = {}", customerId);
//        try {
//            // TODO: customerService.changeCustomerPassword(customerId, oldPassword, newPassword)가 구현될 예정
//            // 다른 팀원이 비밀번호 암호화 로직을 CustomerService 또는 SecurityConfig에서 처리할 것으로 가정
//            boolean isChanged = customerService.changeCustomerPassword(customerId, oldPassword, newPassword);
//            if (isChanged) {
//                logger.info("비밀번호 변경 성공: customerId = {}", customerId);
//            } else {
//                logger.warn("비밀번호 변경 실패 (현재 비밀번호 불일치 등): customerId = {}", customerId);
//            }
//            return isChanged;
//        } catch (Exception e) {
//            logger.error("비밀번호 변경 중 오류 발생: customerId = {}", customerId, e);
//            return false;
//        }
        return false;
    }
}
