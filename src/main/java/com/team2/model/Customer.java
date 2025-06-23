package com.team2.model;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Customer {
    private String customerId;
    private String password;

    public Customer() {}
    public Customer(String customerId, String password) {
        this.customerId = customerId;
        this.password = password;
    }
}
