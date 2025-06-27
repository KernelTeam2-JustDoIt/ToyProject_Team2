<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Q&A 답변 작성</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaAnswerForm.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />

  <!-- ✅ admin-header 구조 깨짐 방지용: 이 페이지에서만 보정 -->
  <style>
    .admin-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 40px;
    }
  </style>
</head>
<body>

<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
  </c:when>
</c:choose>

<div class="qna-answer-form-container">
  <h2>Q&A 답변 작성</h2>

  <form method="post" action="${pageContext.request.contextPath}/qna/answer">
    <input type="hidden" name="qnaId" value="${qna.qnaId}" />

    <div class="qna-section">
      <label>제목</label>
      <div class="readonly-box">${qna.title}</div>
    </div>

    <div class="qna-section">
      <label>문의 내용</label>
      <div class="readonly-box">${qna.content}</div>
    </div>

    <div class="qna-section">
      <label>답변 내용</label>
      <textarea name="answerContent" required placeholder="답변 내용을 입력하세요."></textarea>
    </div>

    <div class="qna-section">
      <button type="submit" class="submit-btn">답변 등록</button>
      <a href="${pageContext.request.contextPath}/qna/${qna.qnaId}" class="cancel-link">취소</a>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
