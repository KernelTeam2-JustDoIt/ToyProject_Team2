package com.team2.service;

import com.team2.mapper.CustomerMapper;
import com.team2.mapper.CustomerModel;
import com.team2.model.CustomerVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class CustomerServiceImpl implements CustomerService {
    private static final Logger log = LoggerFactory.getLogger(CustomerServiceImpl.class);
    private final CustomerMapper customerMapper;
    public CustomerServiceImpl(CustomerModel customerModel) {
        this.customerModel = customerModel;
    }

    @Override
    public void registerCustomer(CustomerVO customer) {
        if (customer == null || customer.getCustomerLoginId() == null) {
            log.warn("잘못된 고객 정보: {}" , customer); //경고 로그
            throw new IllegalArgumentException("잘못된 고객 정보입니다.");
        }

        log.info("회원가입 요청: {}", customer.getCustomerLoginId()); // 정보 로그
        customerModel.insertCustomer(customer);
    }
}
