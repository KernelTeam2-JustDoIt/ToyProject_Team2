<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>숙소 등록</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/accommAdmin_Style.css" />
  <style>
    .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
    h2 { margin-bottom: 20px; font-size: 1.5rem; color: #333; }
    .form-wrapper { background: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 4px; }
    .form-group { display: flex; align-items: center; margin-bottom: 12px; }
    .form-group label { width: 120px; font-weight: 500; }
    .form-group input { flex: 1; padding: 6px 10px; border: 1px solid #ccc; border-radius: 4px; }
    .action-buttons { margin-top: 20px; }
    .action-buttons .btn { margin-right: 10px; }
  </style>
</head>
<body>
<div class="container">
  <h2>숙소 등록</h2>
  <form action="${pageContext.request.contextPath}/accommodations/create" method="post" class="form-wrapper">
    <div class="form-group">
      <label for="adminId">관리자 ID</label>
      <input type="text" id="adminId" name="adminId" class="input-field" />
    </div>
    <div class="form-group">
      <label for="categoryL1Id">카테고리 L1</label>
      <input type="text" id="categoryL1Id" name="categoryL1Id" class="input-field" />
    </div>
    <div class="form-group">
      <label for="categoryL2Id">카테고리 L2</label>
      <input type="text" id="categoryL2Id" name="categoryL2Id" class="input-field" />
    </div>
    <div class="form-group">
      <label for="categoryL3Id">카테고리 L3</label>
      <input type="text" id="categoryL3Id" name="categoryL3Id" class="input-field" />
    </div>
    <div class="form-group">
      <label for="name">숙소명</label>
      <input type="text" id="name" name="name" class="input-field" />
    </div>
    <div class="form-group">
      <label for="status">상태</label>
      <input type="text" id="status" name="status" class="input-field" />
    </div>
    <div class="form-group">
      <label for="clickViews">조회수</label>
      <input type="number" id="clickViews" name="clickViews" class="input-field" />
    </div>
    <div class="form-group">
      <label for="rating">호텔 성급</label>
      <input type="text" id="rating" name="rating" class="input-field" />
    </div>
    <div class="form-group">
      <label for="provinceName">시/도</label>
      <input type="text" id="provinceName" name="provinceName" class="input-field" />
    </div>
    <div class="form-group">
      <label for="districtName">시/군/구</label>
      <input type="text" id="districtName" name="districtName" class="input-field" />
    </div>
    <div class="form-group">
      <label for="roadName">도로명</label>
      <input type="text" id="roadName" name="roadName" class="input-field" />
    </div>
    <div class="form-group">
      <label for="buildingNumber">건물 번호</label>
      <input type="number" id="buildingNumber" name="buildingNumber" class="input-field" />
    </div>
    <div class="form-group">
      <label for="buildingSubNumber">건물 부번호</label>
      <input type="number" id="buildingSubNumber" name="buildingSubNumber" class="input-field" />
    </div>
    <div class="action-buttons">
      <button type="submit" class="btn">등록</button>
      <a href="${pageContext.request.contextPath}/accommodations" class="btn">취소</a>
    </div>
  </form>
</div>
</body>
</html>
