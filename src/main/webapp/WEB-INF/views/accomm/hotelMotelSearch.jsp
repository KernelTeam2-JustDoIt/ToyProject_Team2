<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>호텔/리조트 통합 검색</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pension_style.css">
</head>
<body>

<%@ include file="searchHeader.jsp" %>

<form id="searchForm" action="${pageContext.request.contextPath}/domestic/hotel" method="get">

    <input type="hidden" name="district" id="districtInput" value="${district}">
    <input type="hidden" name="checkIn" id="checkInInput" value="${checkIn}">
    <input type="hidden" name="checkOut" id="checkOutInput" value="${checkOut}">
    <input type="hidden" name="adultCnt" id="adultInput" value="${adultCnt}">
    <input type="hidden" name="babyCnt" id="babyInput" value="${babyCnt}">

    <%@ include file="searchBar.jsp"%>
    <%@ include file="searchPopup.jsp"%>
    <%@ include file="accommList.jsp"%>

</form>

    <%@include file="accommPaging.jsp"%>

</body>
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/resources/js/searchBar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/searchCalendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/searchHeader.js"></script>
</html>
