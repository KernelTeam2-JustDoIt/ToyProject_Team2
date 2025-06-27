<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객 문의</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaList.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
</head>
<body>


<!-- ✅ 헤더 분기 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
  </c:otherwise>
</c:choose>

<!-- 제목: 가운데 정렬 -->
<div class="qna-title-wrapper">
  <h2 class="qna-page-title">
    <a href="${pageContext.request.contextPath}/qna/list" class="qna-title-link">고객 문의 목록</a>
  </h2>
</div>

<!-- 검색창: 줄 아래 오른쪽 정렬 -->
<div class="qna-search-container">
  <form action="${pageContext.request.contextPath}/qna/list" method="get" class="qna-search-form">
    <input type="text" name="keyword" value="${keyword}" placeholder="제목 또는 내용을 검색하세요" />
    <button type="submit">검색</button>
  </form>
</div>




<!-- ✅ 문의 목록 테이블 -->
<table class="qna-table">
  <thead>
  <tr>
    <th>번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>조회수</th>
    <th>상태</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="qna" items="${qnaList}">
    <tr>
      <td>${qna.qnaId}</td>
      <td>
        <a href="${pageContext.request.contextPath}/qna/${qna.qnaId}">
          <c:if test="${qna.isSecret == 1}">
            <span class="lock-icon">🔒</span>
          </c:if>
            ${qna.title}
        </a>
      </td>
      <td>${qna.customerId}</td>
      <td>${qna.formattedPostedDate}</td>
      <td>${qna.viewCount}</td>
      <td>
        <c:choose>
          <c:when test="${qna.qnaStatus eq 'DONE'}">
            <span class="status-done">답변 완료</span>
          </c:when>
          <c:otherwise>
            <span class="status-wait">대기 중</span>
          </c:otherwise>
        </c:choose>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
  <!-- ✅ 문의 작성 버튼: 로그인 고객만 노출 (하단 버튼 위치) -->
  <c:if test="${not empty sessionScope.loginCustomer}">
  <div class="qna-write-btn-bottom">
    <a href="${pageContext.request.contextPath}/qna/form" class="write-btn">문의 작성</a>
  </div>
  </c:if>

<!-- ✅ 페이징 -->
<div class="pagination">
  <c:if test="${hasPrevPage}">
    <a href="?page=${startPage - 1}&keyword=${keyword}">&laquo;</a>
  </c:if>

  <c:forEach var="i" begin="${startPage}" end="${endPage}">
    <a href="?page=${i}&keyword=${keyword}" class="${i == currentPage ? 'active' : ''}">${i}</a>
  </c:forEach>

  <c:if test="${hasNextPage}">
    <a href="?page=${endPage + 1}&keyword=${keyword}">&raquo;</a>
  </c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
