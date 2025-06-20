// src/main/java/com/team2/service/CustomerServiceImpl.java

package com.team2.service;

import com.team2.mapper.CustomerMapper;
import com.team2.model.CustomerVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {

    private static final Logger log = LoggerFactory.getLogger(CustomerServiceImpl.class);
    private final CustomerMapper customerMapper;

    public CustomerServiceImpl(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }

    @Override
    public void registerCustomer(CustomerVO customer) {
        if (customer == null || customer.getCustomerLoginId() == null) {
            log.warn("잘못된 고객 정보: {}", customer);
            throw new IllegalArgumentException("잘못된 고객 정보입니다.");
        }

        log.info("회원가입 요청: {}", customer.getCustomerLoginId());
        customerMapper.insertCustomer(customer);  // 여기서 MyBatis SQL 실행됨
    }
}
