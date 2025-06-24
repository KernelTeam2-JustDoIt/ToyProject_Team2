<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeForm.css" />

    <meta charset="UTF-8">
    <title>공지사항 ${notice.noticeId == 0 ? '작성' : '수정'}</title>


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
                if (isMain) {
                    needPinCheckbox.checked = true;
                    needPinHidden.value = "true";
                    }
            });

            needPinCheckbox.addEventListener("change", () => {
                needPinHidden.value = needPinCheckbox.checked ? "true" : "false";
            });
        });
    </script>
</head>
<body>

<!-- 상단 헤더 -->
<div class="notice-header">
    <a href="<c:url value='/' />">
        <img src="${pageContext.request.contextPath}/resources/image/home_icon.png" alt="홈" style="width: 24px;" />
    </a>

    <div><strong>공지사항 ${notice.noticeId == 0 ? '작성' : '수정'}</strong></div>
    <a href="${pageContext.request.contextPath}/notice/list"> 목록</a>
</div>

<!-- 작성/수정 폼 -->
<div class="form-container">
    <h2>${notice.noticeId == 0 ? '공지사항 작성' : '공지사항 수정'}</h2>


    <c:set var="formAction" value="${notice.noticeId == 0 ? '/notice/add' : '/notice/update'}" />
    <form action="${pageContext.request.contextPath}${formAction}" method="post">
        <input type="hidden" name="noticeId" value="${notice.noticeId}" />

        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="${notice.title}" required />

        <label for="content">내용</label>
        <textarea id="content" name="content" rows="12" required>${notice.content}</textarea>

        <div class="checkbox-group">

            <!-- ✅ 상태 (ACT / NOACT) -->
            <input type="hidden" id="noticeStatusHidden" name="noticeStatus" value="${notice.noticeStatus eq 'ACT' ? 'ACT' : 'NOACT'}" />
            <label>
                <input type="checkbox" id="statusCheck"
                       <c:if test="${notice.noticeStatus eq 'ACT'}">checked</c:if> />
                활성 상태
            </label>

            <!-- ✅ 메인 공지 여부 -->
            <input type="hidden" id="mainHidden" name="main" value="${notice.main ? 'true' : 'false'}" />
            <label>
                <input type="checkbox" id="mainCheck"
                       <c:if test="${notice.main}">checked</c:if> />
                메인 공지
            </label>

            <!-- ✅ 상단 고정 여부 -->
            <input type="hidden" id="needPinHidden" name="needPin" value="${notice.needPin ? 'true' : 'false'}" />
            <label>
                <input type="checkbox" id="needPinCheck"
                       <c:if test="${notice.needPin}">checked</c:if> />
                상단 고정
            </label>

            <!-- ✅ 우선순위 -->
            <label for="priority">우선순위</label>
            <input type="number" id="priority" name="priority"
                   value="<c:out value='${notice.priority != null ? notice.priority : 0}' />" />
        </div>


        <button type="submit">${notice.noticeId == 0 ? '등록하기' : '수정하기'}</button>

    </form>
</div>

</body>
</html>
