package com.team2.mapper;

import com.team2.model.CustomerVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper {
    void insertCustomer(CustomerVO customer);
}
