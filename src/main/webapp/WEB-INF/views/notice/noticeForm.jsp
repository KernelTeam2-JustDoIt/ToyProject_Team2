<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 ${notice.noticeId == 0 ? '작성' : '수정'}</title>

    <!-- 스타일시트 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeForm.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />

    <!-- 체크박스 처리 스크립트 -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const statusCheckbox = document.getElementById("statusCheck");
            const statusHidden = document.getElementById("noticeStatusHidden");

            const mainCheckbox = document.getElementById("mainCheck");
            const mainHidden = document.getElementById("mainHidden");

            const needPinCheckbox = document.getElementById("needPinCheck");
            const needPinHidden = document.getElementById("needPinHidden");

            statusCheckbox.addEventListener("change", () => {
                statusHidden.value = statusCheckbox.checked ? "ACT" : "NOACT";
            });

            mainCheckbox.addEventListener("change", () => {
                mainHidden.value = mainCheckbox.checked ? "true" : "false";
                if (mainCheckbox.checked) {
                    statusCheckbox.checked = true;
                    statusHidden.value = "ACT";
                }
            });

            needPinCheckbox.addEventListener("change", () => {
                needPinHidden.value = needPinCheckbox.checked ? "true" : "false";
                if (needPinCheckbox.checked) {
                    statusCheckbox.checked = true;
                    statusHidden.value = "ACT";
                }
            });
        });
    </script>
</head>
<body>

<!-- ✅ 관리자/고객 헤더 분기 처리 -->
<c:choose>
    <c:when test="${not empty sessionScope.loginAdmin}">
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>
    </c:when>
</c:choose>


<!-- 공지사항 제목 + 목록 버튼 -->
<div class="notice-top-bar">
    <h2 class="notice-page-title">공지사항 ${notice.noticeId == 0 ? '작성' : '수정'}</h2>
    <a href="${pageContext.request.contextPath}/notice/list" class="back-to-list">목록</a>
</div>
<!-- 구분선 추가 -->

</div>
<!-- ✅ 작성/수정 폼 -->
<div class="form-container">
    <c:set var="formAction" value="${notice.noticeId == 0 ? '/notice/add' : '/notice/update'}" />
    <form action="${pageContext.request.contextPath}${formAction}" method="post">
        <input type="hidden" name="noticeId" value="${notice.noticeId}" />

        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="${notice.title}" required />

        <label for="content">내용</label>
        <textarea id="content" name="content" rows="12" required>${notice.content}</textarea>

        <div class="checkbox-group">
            <!-- 활성 상태 -->
            <input type="hidden" id="noticeStatusHidden" name="noticeStatus" value="${notice.noticeStatus eq 'ACT' ? 'ACT' : 'NOACT'}" />
            <label>
                <input type="checkbox" id="statusCheck" <c:if test="${notice.noticeStatus eq 'ACT'}">checked</c:if> />
                활성 상태
            </label>

            <!-- 메인 공지 -->
            <input type="hidden" id="mainHidden" name="main" value="${notice.main ? 'true' : 'false'}" />
            <label>
                <input type="checkbox" id="mainCheck" <c:if test="${notice.main}">checked</c:if> />
                메인 공지
            </label>

            <!-- 상단 고정 -->
            <input type="hidden" id="needPinHidden" name="needPin" value="${notice.needPin ? 'true' : 'false'}" />
            <label>
                <input type="checkbox" id="needPinCheck" <c:if test="${notice.needPin}">checked</c:if> />
                상단 고정
            </label>

            <!-- 우선순위 -->
            <label for="priority">우선순위</label>
            <input type="number" id="priority" name="priority" value="<c:out value='${notice.priority != null ? notice.priority : 0}' />" />
        </div>

        <button type="submit">${notice.noticeId == 0 ? '등록하기' : '수정하기'}</button>
    </form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
