<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>숙소 관리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/accommAdmin_Style.css">
</head>
<body>
<h2>숙소 조회</h2>
<form method="get" action="" class="btn-group">
  <div class="filter-form">
    <div class="form-group">
      <label>숙소번호</label>
      <input type="text" name="accommodationId" value="${condition.accommodationId}" />
    </div>
    <div class="form-group">
      <label>관리자번호</label>
      <input type="text" name="adminId" value="${condition.adminId}" />
    </div>
    <div class="form-group">
      <label>카테고리 L1</label>
      <input type="text" name="categoryL1Id" value="${condition.categoryL1Id}" />
    </div>
    <div class="form-group">
      <label>카테고리 L2</label>
      <input type="text" name="categoryL2Id" value="${condition.categoryL2Id}" />
    </div>
    <div class="form-group">
      <label>카테고리 L3</label>
      <input type="text" name="categoryL3Id" value="${condition.categoryL3Id}" />
    </div>
    <div class="form-group">
      <label>숙소명</label>
      <input type="text" name="name" value="${condition.name}" />
    </div>
    <div class="form-group">
      <label>상태</label>
      <input type="text" name="status" value="${condition.status}" />
    </div>
    <div class="form-group">
      <label>호텔성급</label>
      <input type="text" name="rating" value="${condition.rating}" />
    </div>
  </div>
  <!-- 버튼 그룹: 조회하기 옆에 삽입하기 버튼 추가 -->
  <div class="action-buttons">
    <button type="submit" class="btn">조회하기</button>
    <a href="${pageContext.request.contextPath}/accommodations/create" class="btn">삽입하기</a>
  </div>
</form>

<div class="table-wrapper">
  <table>
    <thead>
    <tr>
      <th>숙소번호</th>
      <th>관리자번호</th>
      <th>카테고리 L1</th>
      <th>카테고리 L2</th>
      <th>카테고리 L3</th>
      <th>숙소명</th>
      <th>상태</th>
      <th>호텔성급</th>
      <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="vo" items="${list}">
      <tr>
        <td>${vo.accommodationId}</td>
        <td>${vo.adminId}</td>
        <td>${vo.categoryL1Id}</td>
        <td>${vo.categoryL2Id}</td>
        <td>${vo.categoryL3Id}</td>
        <td>${vo.name}</td>
        <td>${vo.status}</td>
        <td>${vo.rating}</td>
        <td>
          <a href="${pageContext.request.contextPath}/accommodations/${vo.accommodationId}/edit" class="btn">수정</a>
          <form action="${pageContext.request.contextPath}/accommodations/${vo.accommodationId}/delete" method="post" style="display:inline;">
            <button type="submit" class="btn" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
          </form>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty list}">
      <tr>
        <td colspan="9" style="text-align:center;">조회된 데이터가 없습니다.</td>
      </tr>
    </c:if>
    </tbody>
  </table>
</div>

</body>
</html>
