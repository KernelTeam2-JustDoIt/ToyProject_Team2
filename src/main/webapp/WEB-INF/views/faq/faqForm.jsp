<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FAQ 등록 / 수정</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faqForm.css" />
</head>
<body>

<!-- ✅ 헤더 분기 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
  </c:otherwise>
</c:choose>

<div class="faq-form-container">
  <c:choose>
    <c:when test="${empty faq.faqId}">
      <h2>FAQ 등록</h2>
    </c:when>
    <c:otherwise>
      <h2>FAQ 수정</h2>
    </c:otherwise>
  </c:choose>
  <!-- 제목 변경 -->

  <!-- FAQ 등록/수정 폼 -->
  <c:choose>
  <c:when test="${empty faq.faqId}">
  <form method="post" action="${pageContext.request.contextPath}/faq/add">
    </c:when>
    <c:otherwise>
    <form method="post" action="${pageContext.request.contextPath}/faq/update">
      </c:otherwise>
      </c:choose>

      <input type="hidden" name="faqId" value="${faq.faqId}"/> <!-- 수정 시 faqId 전달 -->
      <input type="hidden" name="writerAdminId" value="${sessionScope.loginAdmin.adminId}"/>

    <!-- 카테고리 선택 -->
    <div class="form-group">
      <label for="category">카테고리</label>
      <select name="faqCategory" id="category" required>
        <option value="국내숙소" ${faq.faqCategory == '국내숙소' ? 'selected' : ''}>국내숙소</option>
        <option value="해외숙소" ${faq.faqCategory == '해외숙소' ? 'selected' : ''}>해외숙소</option>
        <option value="교통" ${faq.faqCategory == '교통' ? 'selected' : ''}>교통</option>
        <option value="회원" ${faq.faqCategory == '회원' ? 'selected' : ''}>회원</option>
        <option value="포인트" ${faq.faqCategory == '포인트' ? 'selected' : ''}>포인트</option>
        <option value="쿠폰" ${faq.faqCategory == '쿠폰' ? 'selected' : ''}>쿠폰</option>
        <option value="결제" ${faq.faqCategory == '결제' ? 'selected' : ''}>결제</option>
        <option value="취소/환불" ${faq.faqCategory == '취소/환불' ? 'selected' : ''}>취소/환불</option>
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
        <!-- 토글 스위치 UI -->
        <div class="form-group">
          <label for="statusCheck">활성화 여부</label>
          <label class="toggle-switch">
            <input type="checkbox" id="statusCheck" ${faq.faqStatus == 'ACT' ? 'checked' : ''}>
            <span class="slider"></span>
          </label>
          <input type="hidden" name="faqStatus" id="faqStatusHidden" value="${faq.faqStatus == 'ACT' ? 'ACT' : 'NOACT'}" />
        </div>

        <script>
          document.addEventListener("DOMContentLoaded", function () {
            const checkbox = document.getElementById("statusCheck");
            const hiddenInput = document.getElementById("faqStatusHidden");

            checkbox.addEventListener("change", function () {
              hiddenInput.value = checkbox.checked ? 'ACT' : 'NOACT';
            });
          });
        </script>

    <!-- 제출 버튼 -->
    <div class="form-group">
      <button type="submit" class="submit-btn">${(empty faq.faqId) ? '등록' : '수정'}</button> <!-- 버튼 내용 변경 -->
    </div>
  </form>

  <!-- 취소 버튼 -->
  <div class="form-group">
    <a href="${pageContext.request.contextPath}/faq/list" class="cancel-btn">취소</a>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
