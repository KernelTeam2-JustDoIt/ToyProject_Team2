<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>404 - 페이지를 찾을 수 없습니다</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/error.css">
</head>
<body>
<div class="error-container">
    <div class="error-code">404</div>
    <div class="error-message">페이지를 찾을 수 없습니다</div>
    <div class="error-description">
        요청하신 주소가 잘못되었거나, 더 이상 존재하지 않습니다.
    </div>
    <a class="error-button" href="<%= request.getContextPath() %>/">홈으로 이동</a>
</div>
</body>
</html>
