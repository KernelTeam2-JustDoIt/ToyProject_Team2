<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Q&A 상세보기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaDetail.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
</head>
<body>
<%-- ✅ 관리자/사용자 헤더 분기 출력 --%>
<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
  </c:when>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
  </c:otherwise>
</c:choose>
<!-- 상단 헤더 -->
<!-- Q&A 상단 헤더 -->
<div class="qna-header">
  <div class="qna-title">고객문의</div>
  <a href="${pageContext.request.contextPath}/qna/list" class="qna-back-btn">목록</a>
</div>
<!-- 문의 상세 -->
<div class="qna-container">
  <div class=qna-title">
    <c:if test="${qna.isSecret == 1}">🔒 </c:if>${qna.title}
  </div>

  <div class="qna-date">
    작성일: ${qna.formattedPostedDate} |
    작성자: ${qna.customerId} |
    상태:
    <c:choose>
      <c:when test="${qna.qnaStatus eq 'DONE'}">✅ 답변 완료</c:when>
      <c:otherwise>⌛ 대기 중</c:otherwise>
    </c:choose>
  </div>

  <hr class="divider" />
  <div class="qna-content">
    <c:out value="${qna.content}" escapeXml="true" />
  </div>

  <!-- 답변 영역 -->
  <hr class="divider" />
  <c:choose>
    <c:when test="${not empty qna.answerContent}">
      <div class="qna-title">📌 관리자 답변</div>
      <div class="qna-date">답변일: ${qna.formattedAnsweredDate}</div>
      <div class="qna-content">
        <c:out value="${qna.answerContent}" escapeXml="true" />
      </div>
    </c:when>
    <c:otherwise>
      <div class="qna-title">📌 아직 답변이 등록되지 않았습니다.</div>
    </c:otherwise>
  </c:choose>

  <!-- 관리자 답변 버튼 + 삭제 버튼 -->
  <c:if test="${not empty sessionScope.loginAdmin and sessionScope.loginAdmin.roleId == 1}">
    <div class="action-buttons">

      <!-- 답변 작성/수정 버튼 -->
      <a href="${pageContext.request.contextPath}/qna/answerForm/${qna.qnaId}" class="action-button">
        ✏️ <c:out value="${empty qna.answerContent ? '답변 작성' : '답변 수정'}" />
      </a>

      <!-- 삭제 버튼 추가 -->
      <form method="post"
            action="${pageContext.request.contextPath}/qna/delete/${qna.qnaId}"
            onsubmit="return confirm('정말 삭제하시겠습니까?');"
            style="display:inline;">
        <button type="submit" class="action-button">🗑️ 삭제</button>
      </form>
    </div>
  </c:if>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
