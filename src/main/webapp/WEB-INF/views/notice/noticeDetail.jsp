<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeDetail.css" />
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
  <div class="notice-date">작성일: ${formattedPostedAt} | 조회수: ${notice.viewCount}</div>
  <hr class="divider" />
  <div class="notice-content">
    <c:out value="${notice.content}" escapeXml="true"/>
  </div>
  <!-- 관리자 전용 수정/삭제 버튼 -->
  <c:if test="${not empty sessionScope.loginAdmin}">
    <div class="action-buttons">
      <a href="${pageContext.request.contextPath}/notice/updateForm/${notice.noticeId}" class="action-button">
        수정
      </a>

      <form action="${pageContext.request.contextPath}/notice/delete/${notice.noticeId}" method="post" style="display:inline;">
        <button type="submit"
                onclick="return confirm('정말 삭제하시겠습니까?');"
                class="action-button delete-button">
          삭제
        </button>
      </form>
    </div>
  </c:if>


</div>

</body>
</html>
