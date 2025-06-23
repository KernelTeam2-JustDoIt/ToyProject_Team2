package com.team2.controller;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.Assert.assertTrue;
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
public class ErrorPageTest {

    private final String BASE_URL = "http://localhost:8080/yanupja";

    @Test
    public void 요청_없는_URL_접속시_404반환() throws Exception {
        URL url = new URL(BASE_URL + "/no_resource");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        int responseCode = con.getResponseCode();
        System.out.println("responseCode = " + responseCode);
        assertTrue("404 에러코드가 나와야 함", responseCode == 404);

        // 에러 페이지 내용 읽기 (선택사항)
        try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"))) {
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            System.out.println("에러 페이지 내용: " + response.toString());
            // 필요시 뷰에 포함된 텍스트 검증 가능
        }
    }

    @Test
    public void 예외_발생시_500반환() throws Exception {
        URL url = new URL(BASE_URL + "/force_error");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        int responseCode = con.getResponseCode();
        System.out.println("responseCode = " + responseCode);
        assertTrue("500 에러코드가 나와야 함", responseCode == 500);

        try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"))) {
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            System.out.println("에러 페이지 내용: " + response.toString());
        }
    }
}
