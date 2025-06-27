<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>자주 묻는 질문</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/faqList.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
</head>
<body>

<!-- ✅ 헤더 분기 처리 -->
<c:choose>
  <c:when test="${not empty sessionScope.loginAdmin}">
    <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />
  </c:when>
  <c:otherwise>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
  </c:otherwise>
</c:choose>

<!-- ✅ FAQ 목록 렌더링 -->
<div class="faq-container">
  <h2>자주 묻는 질문 (FAQ)</h2>
  <!-- ✅ FAQ 검색창 -->
  <div class="faq-search">
    <form method="get" action="${pageContext.request.contextPath}/faq/list">
      <input type="text" name="search" value="${search}" placeholder="FAQ 검색" />
      <button type="submit">검색</button>
    </form>
  </div>

  <!-- 카테고리 필터 -->
  <div class="faq-category-filter">
    <a href="${pageContext.request.contextPath}/faq/list">전체</a>
    <a href="?category=국내숙소" class="${selectedCategory == '국내숙소' ? 'selected' : ''}">국내숙소</a>
    <a href="?category=해외숙소" class="${selectedCategory == '해외숙소' ? 'selected' : ''}">해외숙소</a>
    <a href="?category=교통" class="${selectedCategory == '교통' ? 'selected' : ''}">교통</a>
    <a href="?category=회원" class="${selectedCategory == '회원' ? 'selected' : ''}">회원</a>
    <a href="?category=포인트" class="${selectedCategory == '포인트' ? 'selected' : ''}">포인트</a>
    <a href="?category=쿠폰" class="${selectedCategory == '쿠폰' ? 'selected' : ''}">쿠폰</a>
    <a href="?category=결제" class="${selectedCategory == '결제' ? 'selected' : ''}">결제</a>
    <a href="?category=취소/환불" class="${selectedCategory == '취소/환불' ? 'selected' : ''}">취소/환불</a>
  </div>

  <div class="faq-list">
    <c:forEach var="faq" items="${faqList}">
      <div class="faq-item ${faq.faqStatus == 'NOACT' ? 'inactive' : ''}">

      <a href="${pageContext.request.contextPath}/faq/${faq.faqId}" class="faq-link">
          <strong>[${faq.faqCategory}]</strong> ${faq.faqTitle}
        </a>
        <div class="faq-meta">
          조회수: ${faq.viewCount} |
          등록일: ${faq.formattedDate}
          <c:if test="${not empty faq.formattedUpdatedDate}">
            | 수정일: ${faq.formattedUpdatedDate}
          </c:if>
        </div>

        <c:if test="${not empty sessionScope.loginAdmin}">
          <div class="faq-actions">
            <a href="${pageContext.request.contextPath}/faq/form/${faq.faqId}" class="faq-edit-btn">수정</a>
            <form method="post" action="${pageContext.request.contextPath}/faq/delete/${faq.faqId}" style="display:inline;">
              <button type="submit" class="faq-delete-btn">삭제</button>
            </form>
          </div>
        </c:if>
      </div>
    </c:forEach>
  </div>

  <!-- 페이지네이션 -->
  <div class="pagination">
    <c:if test="${currentPage > 1}">
      <a href="?page=${currentPage - 1}&category=${selectedCategory}" class="page-prev">◀ 이전</a>
    </c:if>

    <c:forEach begin="${startPage}" end="${endPage}" var="i">
      <c:choose>
        <c:when test="${i == currentPage}">
          <span class="current-page">${i}</span>
        </c:when>
        <c:otherwise>
          <a href="?page=${i}&category=${selectedCategory}" class="page-number">${i}</a>
        </c:otherwise>
      </c:choose>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
      <a href="?page=${currentPage + 1}&category=${selectedCategory}" class="page-next">다음 ▶</a>
    </c:if>
  </div>
</div>

<!-- 관리자만 등록 버튼 노출 -->
<c:if test="${not empty sessionScope.loginAdmin }">
  <div class="faq-admin-actions">
    <a href="${pageContext.request.contextPath}/faq/form" class="faq-register-btn">FAQ 등록</a>
  </div>
</c:if>

<!-- ✅ 푸터 포함 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
