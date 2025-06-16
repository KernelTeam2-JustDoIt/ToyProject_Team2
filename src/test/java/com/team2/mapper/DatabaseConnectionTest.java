package com.team2.mapper;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import javax.sql.DataSource;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
class DatabaseConnectionTest {
    @Autowired
    private DataSource dataSource;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @Test
    void testDataSourceNotNull() {
        assertNotNull(dataSource, "DataSource 빈이 성공적으로 주입되어야 합니다.");
        System.out.println("DataSource 빈 주입 성공: " + dataSource);
    }

    @Test
    void testSqlSessionFactoryNotNull() {
        assertNotNull(sqlSessionFactory, "SqlSessionFactory 빈이 성공적으로 주입되어야 합니다.");
        System.out.println("SqlSessionFactory 빈 주입 성공: " + sqlSessionFactory);
    }

    @Test
    void testDatabaseConnection() {
        try (java.sql.Connection conn = dataSource.getConnection()) {
            assertNotNull(conn, "데이터베이스 연결에 성공해야 합니다.");
            System.out.println("데이터베이스 연결 성공!");
            System.out.println("DB URL: " + conn.getMetaData().getURL());
            System.out.println("DB User: " + conn.getMetaData().getUserName());
        } catch (Exception e) {
            fail("데이터베이스 연결 실패: " + e.getMessage());
        }
    }
}