<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>테스트 로그인</title>
</head>
<body>
<h2>테스트 로그인</h2>
<form action="/test/login" method="post">
    <label>고객 ID (임시):
        <input type="text" name="customerId" placeholder="예: 1"/>
    </label>
    <button type="submit">로그인</button>
</form>
</body>
</html> 