<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>숙소 관리</title>
    <style>
        .container { max-width: 1200px; margin: 40px auto; padding: 0 20px; }
        h2 { margin-bottom: 20px; }
        .alert { padding: 12px 20px; margin-bottom: 20px; border-radius: 4px; font-size: 0.95rem; }
        .alert.success { background-color: #e0f7e9; color: #2d7a2a; border: 1px solid #2d7a2a; }
        .table-wrapper { overflow-x: auto; margin-top: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; vertical-align: middle; }
        th { background-color: #f4f4f4; text-align: center; }
        .btn { display: inline-block; padding: 6px 12px; margin: 0 4px; background-color: #3498db; color: #fff; text-decoration: none; border-radius: 4px; font-size: 0.9rem; }
        .btn:hover { background-color: #2980b9; }
        .input-field { width: 100%; padding: 4px; border: 1px solid #ccc; border-radius: 4px; }
        .inline-form { display: flex; flex-wrap: wrap; align-items: center; }
        .inline-form td { padding: 4px; }
        .inline-form button { margin-left: 8px; }
    </style>
</head>
<body>
<div class="container">
    <!-- 성공 메시지 표시 -->
    <c:if test="${not empty message}">
        <div class="alert success">${message}</div>
    </c:if>
    <h2>숙소 목록</h2>
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
                <th>평점</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="vo" items="${list}">
                <form action="${pageContext.request.contextPath}/accommodations/${vo.accommodationId}/edit" method="post" class="inline-form">
                    <tr>
                        <td>
                                ${vo.accommodationId}
                            <input type="hidden" name="accommodationId" value="${vo.accommodationId}" />
                        </td>
                        <td><input type="text" name="adminId" value="${vo.adminId}" class="input-field"/></td>
                        <td><input type="text" name="categoryL1Id" value="${vo.categoryL1Id}" class="input-field"/></td>
                        <td><input type="text" name="categoryL2Id" value="${vo.categoryL2Id}" class="input-field"/></td>
                        <td><input type="text" name="categoryL3Id" value="${vo.categoryL3Id}" class="input-field"/></td>
                        <td><input type="text" name="name" value="${vo.name}" class="input-field"/></td>
                        <td><input type="text" name="status" value="${vo.status}" class="input-field"/></td>
                        <td><input type="text" name="rating" value="${vo.rating}" class="input-field"/></td>
                        <td>
                            <button type="submit" class="btn">저장</button>
                            <a href="${pageContext.request.contextPath}/accommodations" class="btn">취소</a>
                        </td>
                    </tr>
                </form>
            </c:forEach>
            <c:if test="${empty list}">
                <tr>
                    <td colspan="9" style="text-align:center; padding: 20px;">조회된 데이터가 없습니다.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
