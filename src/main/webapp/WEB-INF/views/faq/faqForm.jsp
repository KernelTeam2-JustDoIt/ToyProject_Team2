<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FAQ 등록 / 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faqForm.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const checkbox = document.getElementById("statusCheck");
      const hiddenInput = document.getElementById("faqStatusHidden");

      checkbox.addEventListener("change", function () {
        hiddenInput.value = checkbox.checked ? 'ACT' : 'NOACT';
      });
    });
  </script>
</head>



<body>
<jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />
<!-- 폼 -->
<div class="faq-form-container">
  <h2>${empty faq.faqId ? 'FAQ 등록' : 'FAQ 수정'}</h2>

  <form method="post" action="${pageContext.request.contextPath}/faq/${empty faq.faqId ? 'add' : 'update'}">
    <input type="hidden" name="faqId" value="${faq.faqId}" />
    <input type="hidden" name="writerAdminId" value="${sessionScope.loginAdmin.adminId}" />

    <!-- 카테고리 -->
    <div class="form-group">
      <label for="category">카테고리</label>
      <select name="faqCategory" id="category" required>
        <c:forEach var="cat" items="${['국내숙소','해외숙소','교통','회원','포인트','쿠폰','결제','취소/환불']}">
          <option value="${cat}" ${faq.faqCategory == cat ? 'selected' : ''}>${cat}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 제목 -->
    <div class="form-group">
      <label for="title">제목</label>
      <input type="text" id="title" name="faqTitle" value="${faq.faqTitle}" required />
    </div>

    <!-- 내용 -->
    <div class="form-group">
      <label for="content">내용</label>
      <textarea id="content" name="faqContent" rows="5" required>${faq.faqContent}</textarea>
    </div>

    <!-- 토글 -->
    <div class="form-group">
      <label class="toggle-label" for="statusCheck">
        활성화 여부
        <label class="toggle-switch">
          <input type="checkbox" id="statusCheck" ${faq.faqStatus == 'ACT' ? 'checked' : ''}>
          <span class="slider"></span>
        </label>
      </label>
      <input type="hidden" name="faqStatus" id="faqStatusHidden" value="${faq.faqStatus == 'ACT' ? 'ACT' : 'NOACT'}" />
    </div>

    <!-- 버튼 -->
    <div class="form-actions">
      <button type="submit" class="submit-btn">${empty faq.faqId ? '등록' : '수정'}</button>
      <a href="${pageContext.request.contextPath}/faq/list" class="cancel-btn">취소</a>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>



</body>
</html>
