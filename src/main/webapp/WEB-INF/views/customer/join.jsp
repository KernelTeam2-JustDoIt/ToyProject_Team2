<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/join.css"> <%-- 외부 CSS 연결 --%>
</head>
<body>

<div class="container">
    <h2 class="form-title">회원가입</h2>

    <form action="/customer/join" method="post" class="join-form">
        <div class="form-group">
            <label for="customerName">이름</label>
            <input type="text" id="customerName" name="customerName" required>
        </div>

        <div class="form-group">
            <label for="customerTel">전화번호</label>
            <input type="text" id="customerTel" name="customerTel" required>
        </div>

        <div class="form-group">
            <label for="customerEmail">이메일</label>
            <input type="email" id="customerEmail" name="customerEmail" required>
        </div>

        <div class="form-group">
            <label for="customerLoginId">아이디</label>
            <input type="text" id="customerLoginId" name="customerLoginId" required>
        </div>

        <div class="form-group">
            <label for="customerPassword">비밀번호</label>
            <input type="password" id="customerPassword" name="customerPassword" required>
        </div>

        <div class="form-group">
            <label for="customerGender">성별</label>
            <select id="customerGender" name="customerGender">
                <option value="M">남성</option>
                <option value="F">여성</option>
            </select>
        </div>

        <div class="form-group">
            <label for="customerJob">직업</label>
            <input type="text" id="customerJob" name="customerJob">
        </div>

        <div class="form-group">
            <label for="customerAge">나이</label>
            <input type="number" id="customerAge" name="customerAge">
        </div>

        <div class="form-group checkbox-group">
            <input type="checkbox" name="isMarketingUseAgreed" value="1" id = "isMarketingUseAgreed"/>
            <label>
                마케팅 수신 동의
            </label>
            <input type="hidden" name="isMarketingUseAgreed" value="0" />
        </div>


        <!-- 숨겨진 값들 -->
        <input type="hidden" name="gradeId" value="1">
        <input type="hidden" name="joinedAt" value="<%= new java.sql.Timestamp(System.currentTimeMillis()) %>">
        <input type="hidden" name="gradeExpireDate" value="<%= new java.sql.Timestamp(System.currentTimeMillis() + 1000L*60*60*24*365) %>">

        <div class="form-group">
            <button type="submit" class="submit-button">가입하기</button>
        </div>
    </form>
</div>

</body>
</html>
