<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
  <title>500 - 서버 오류</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/error.css">
</head>
<body>
<div class="error-container">
  <div class="error-code">500</div>
  <div class="error-message">서버 내부 오류가 발생했습니다</div>
  <div class="error-description">
    일시적인 문제일 수 있습니다. 잠시 후 다시 시도해주세요.
  </div>
  <a class="error-button" href="<%= request.getContextPath() %>/">홈으로 이동</a>
</div>
</body>
</html>
