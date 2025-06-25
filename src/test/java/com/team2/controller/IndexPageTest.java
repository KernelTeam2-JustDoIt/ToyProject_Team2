package com.team2.controller;

import org.junit.Test;
import static org.junit.Assert.*;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;

public class IndexPageTest {

    private static final String BASE_URL = "http://localhost:8080/yanupja";

    @Test
    public void indexPageSourceTest() {
        String htmlContent = null;

        // 1. HTTP GET 요청 보내기
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpGet request = new HttpGet(BASE_URL + "/"); // 메인 페이지 경로
            CloseableHttpResponse response = httpClient.execute(request);

            try {
                // 응답 본문(HTML)을 문자열로 가져오기
                htmlContent = EntityUtils.toString(response.getEntity());
                assertNotNull("HTML content should not be null", htmlContent); // HTML 내용이 null이 아닌지 확인
                assertTrue("HTML content should not be empty", !htmlContent.isEmpty()); // HTML 내용이 비어있지 않은지 확인

                // 2. Jsoup으로 HTML 파싱
                Document doc = Jsoup.parse(htmlContent);

                // 3. 다양한 HTML 요소 및 콘텐츠 검증
                // 3.1. 페이지 제목 확인
                assertEquals("야눕자 메인 페이지", doc.title());

                // 3.2. 주요 섹션 존재 여부 확인
                assertNotNull("Header section should exist", doc.selectFirst("header"));
                assertNotNull("Main section should exist", doc.selectFirst("main"));
                assertNotNull("Footer section should exist", doc.selectFirst("footer"));

                // 3.3. 슬라이더 요소 존재 여부 확인 (event-slider 예시)
                assertNotNull("Event slider should exist", doc.selectFirst(".event-slider"));
                assertNotNull("Event track should exist", doc.selectFirst(".event-track"));
                assertNotNull("Event slider previous button should exist", doc.selectFirst(".event-slider .prev"));
                assertNotNull("Event slider next button should exist", doc.selectFirst(".event-slider .next"));

                // 3.4. 특정 텍스트 존재 여부 확인 (공지사항 텍스트)
                assertTrue("Notice text '새로워진 NOL을 소개합니다!' should be present",
                        htmlContent.contains("새로워진 NOL을 소개합니다!"));

                // 3.5. JavaScript 코드 블록 확인 (일부 문자열 포함 여부)
                Elements scriptTags = doc.select("script");
                boolean foundInitSliderFunction = false;
                for (org.jsoup.nodes.Element script : scriptTags) {
                    if (script.html().contains("function initializeSlider")) {
                        foundInitSliderFunction = true;
                        break;
                    }
                }
                assertTrue("initializeSlider function should be present in script tags", foundInitSliderFunction);


            } finally {
                response.close(); // 응답 닫기
            }
        } catch (IOException e) {
            fail("Failed to fetch index page: " + e.getMessage()); // 네트워크 오류 등 예외 처리
        }
    }
}
