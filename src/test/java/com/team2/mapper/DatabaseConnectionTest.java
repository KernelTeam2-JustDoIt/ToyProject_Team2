package com.team2.mapper;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DatabaseConnectionTest {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private SqlSessionFactory sqlSessionFactory;

    @Test
    public void testDataSourceNotNull() {
        Assert.assertNotNull("DataSource 빈이 성공적으로 주입되어야 합니다.", dataSource);
        System.out.println("DataSource 빈 주입 성공: " + dataSource);
    }

    @Test
    public void testSqlSessionFactoryNotNull() {
        Assert.assertNotNull("SqlSessionFactory 빈이 성공적으로 주입되어야 합니다.", sqlSessionFactory);
        System.out.println("SqlSessionFactory 빈 주입 성공: " + sqlSessionFactory);
    }

    @Test
    public void testDatabaseConnection() {
        try (java.sql.Connection conn = dataSource.getConnection()) {
            Assert.assertNotNull("데이터베이스 연결에 성공해야 합니다.", conn);
            System.out.println("데이터베이스 연결 성공!");
            System.out.println("DB URL: " + conn.getMetaData().getURL());
            System.out.println("DB User: " + conn.getMetaData().getUserName());
        } catch (Exception e) {
            Assert.fail("데이터베이스 연결 실패: " + e.getMessage());
        }
    }
}
