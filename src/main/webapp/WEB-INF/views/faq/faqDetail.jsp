<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>FAQ 상세 보기</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faqDetail.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
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

<main class="faq-main">
  <div class="faq-detail-container">
    <!-- FAQ 제목 -->
    <h2 class="faq-title">${faq.faqTitle}</h2>

    <!-- FAQ 메타 데이터 -->
    <div class="faq-meta">
      <span>카테고리: ${faq.faqCategory}</span> |
      <span>조회수: ${faq.viewCount}</span> |
      <span>등록일: ${faq.formattedDate}</span>
      <c:if test="${not empty faq.formattedUpdatedDate}">
        | 수정일: ${faq.formattedUpdatedDate}
      </c:if>
    </div>

    <!-- FAQ 본문 -->
    <div class="faq-content">
      ${faq.faqContent}
    </div>

    <!-- 관리자 수정/삭제 버튼 -->
    <c:if test="${not empty sessionScope.loginAdmin}">
      <div class="faq-actions">
        <a href="${pageContext.request.contextPath}/faq/edit/${faq.faqId}" class="faq-edit-btn">수정</a>
        <form method="post" action="${pageContext.request.contextPath}/faq/delete/${faq.faqId}" style="display:inline;">
          <button type="submit" class="faq-delete-btn" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
        </form>
      </div>
    </c:if>

    <!-- 목록으로 돌아가기 -->
    <div class="back-link">
      <a href="${pageContext.request.contextPath}/faq/list">← 목록으로 돌아가기</a>
    </div>
  </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
