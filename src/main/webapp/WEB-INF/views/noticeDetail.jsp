<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <style>
    body {
      margin: 0;
      background-color: #f5f5f5;
      font-family: 'Segoe UI', sans-serif;
    }

    .notice-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      background: white;
      border-bottom: 1px solid #ddd;
    }

    .notice-header a {
      text-decoration: none;
      font-size: 18px;
      color: black;
    }

    .notice-container {
      max-width: 800px;
      margin: 40px auto;
      padding: 30px;
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .notice-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }

    .notice-date {
      font-size: 14px;
      color: gray;
      margin-bottom: 10px;
    }

    .divider {
      border: none;
      border-top: 1px solid #eee;
      margin: 20px 0;
    }

    .notice-content {
      font-size: 16px;
      line-height: 1.8;
      white-space: pre-line;
    }

  </style>
</head>
<body>

<!-- 상단 헤더 -->
<div class="notice-header">
  <a href="<c:url value='/' />">
    <img src="${pageContext.request.contextPath}/resources/image/home_icon.png" alt="홈" style="width: 24px;" />
  </a>

  <div><strong>공지사항</strong></div>
  <a href="${pageContext.request.contextPath}/notice/list"> 목록</a>
</div>

<!-- 공지 본문 -->
<div class="notice-container">
  <div class="notice-title">${notice.title}</div>
  <div class="notice-date">작성일: ${formattedPostedAt}</div>
  <hr class="divider" />
  <div class="notice-content">${notice.content}</div>
</div>

</body>
</html>
