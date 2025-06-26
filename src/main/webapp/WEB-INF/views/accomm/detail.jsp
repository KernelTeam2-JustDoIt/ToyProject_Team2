<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>숙소 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }
        h2 {
            margin-bottom: 20px;
            font-size: 1.6rem;
            color: #333;
        }
        .detail-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .detail-table th,
        .detail-table td {
            border: 1px solid #ddd;
            padding: 12px;
            vertical-align: top;
        }
        .detail-table th {
            background-color: #f4f4f4;
            width: 30%;
            text-align: left;
        }
        .detail-table td {
            background-color: #fff;
        }
        .btn {
            display: inline-block;
            padding: 8px 16px;
            margin-right: 8px;
            background-color: #3498db;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 0.9rem;
        }
        .btn:hover {
            background-color: #2980b9;
        }
        .btn-group {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>숙소 상세 정보</h2>
    <c:forEach var="vo" items="${vo}">
        <table>
            <tr><th>숙소번호</th><td>${vo.accommodationId}</td></tr>
            <tr><th>관리자번호</th><td>${vo.adminId}</td></tr>
            <tr><th>카테고리 L1</th><td>${vo.categoryL1Id}</td></tr>
            <tr><th>카테고리 L2</th><td>${vo.categoryL2Id}</td></tr>
            <tr><th>카테고리 L3</th><td>${vo.categoryL3Id}</td></tr>
            <tr><th>숙소명</th><td>${vo.name}</td></tr>
            <tr><th>상태</th><td>${vo.status}</td></tr>
            <tr><th>평점</th><td>${vo.rating}</td></tr>
            <!-- 필요시 나머지 컬럼도 추가 -->
        </table>
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/accommodations/${vo.accommodationId}/edit" class="btn">수정</a>
            <a href="${pageContext.request.contextPath}/accommodations" class="btn">목록</a>
        </div>
    </c:forEach>
</div>
</body>
</html>
