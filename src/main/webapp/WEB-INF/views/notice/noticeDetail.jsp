<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeDetail.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
</head>
<body>

<!-- ✅ 관리자/고객 헤더 분기 처리 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
  </c:otherwise>
</c:choose>


<!-- 제목 + 목록 버튼 정렬 -->
<div class="notice-top-bar">
  <h2 class="notice-page-title">공지사항</h2>
  <a href="${pageContext.request.contextPath}/notice/list" class="back-to-list">목록</a>
</div>

<!-- 공지 본문 -->
<div class="notice-container">
  <div class="notice-title-text">${notice.title}</div>

  <!-- ✅ 작성일 + 조회수 -->
  <div class="notice-meta">
    <span>작성일: ${formattedPostedAt}</span>
    <span class="view-count">조회수: ${notice.viewCount}</span>
  </div>


  <div class="notice-content">${notice.content}</div>

  <!-- 관리자 전용 수정/삭제 버튼 -->
  <c:if test="${not empty sessionScope.loginAdmin}">
    <div class="action-buttons">
      <a href="${pageContext.request.contextPath}/notice/updateForm/${notice.noticeId}" class="action-button">
        수정
      </a>

      <form action="${pageContext.request.contextPath}/notice/delete/${notice.noticeId}" method="post" class="inline-form">
        <button type="submit"
                onclick="return confirm('정말 삭제하시겠습니까?');"
                class="action-button delete-button">
          삭제
        </button>
      </form>
    </div>
  </c:if>
</div>
<!-- ✅ 이전글 / 다음글 -->
<div class="notice-nav">
  <div class="nav-item">
    <strong>이전글</strong> :
    <c:choose>
      <c:when test="${not empty prevNotice}">
        <a href="${pageContext.request.contextPath}/notice/${prevNotice.noticeId}">
            ${prevNotice.title}
        </a>
      </c:when>
      <c:otherwise>
        <span class="no-post">이전글이 없습니다.</span>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="nav-item">
    <strong>다음글</strong> :
    <c:choose>
      <c:when test="${not empty nextNotice}">
        <a href="${pageContext.request.contextPath}/notice/${nextNotice.noticeId}">
            ${nextNotice.title}
        </a>
      </c:when>
      <c:otherwise>
        <span class="no-post">다음글이 없습니다.</span>
      </c:otherwise>
    </c:choose>
  </div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
