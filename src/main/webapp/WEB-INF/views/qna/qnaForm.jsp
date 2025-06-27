<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>고객 문의 작성</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/qnaForm.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
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

<div class="qna-form-container">
  <h2><c:out value="${qna.qnaId == 0 || qna.qnaId == null ? '고객 문의 작성' : '고객 문의 수정'}" /></h2>

  <c:choose>
  <c:when test="${qna.qnaId == 0 || qna.qnaId == null}">
  <form method="post" action="${pageContext.request.contextPath}/qna/add">
    </c:when>
    <c:otherwise>
    <form method="post" action="${pageContext.request.contextPath}/qna/update">
      <input type="hidden" name="qnaId" value="${qna.qnaId}" />
      </c:otherwise>
      </c:choose>

      <div class="qna-section">
        <label for="title">제목</label>
        <input type="text" name="title" id="title" value="${qna.title}" required />
      </div>

      <div class="qna-section">
        <label for="content">내용</label>
        <textarea name="content" id="content" required>${qna.content}</textarea>
      </div>

      <div class="qna-section secret-checkbox">
        <label>
          <input type="checkbox" name="isSecret" value="1"
                 <c:if test="${qna.isSecret == 1}">checked</c:if> />
          비밀글
        </label>
      </div>

      <div class="qna-section">
        <button type="submit" class="submit-btn">
          <c:out value="${qna.qnaId == 0 || qna.qnaId == null ? '등록' : '수정'}" />
        </button>
        <a href="${pageContext.request.contextPath}/qna/list" class="cancel-link">취소</a>
      </div>
    </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
