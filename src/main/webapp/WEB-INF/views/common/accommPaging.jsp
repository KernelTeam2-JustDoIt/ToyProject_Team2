<%--
  Created by IntelliJ IDEA.
  User: jihoon
  Date: 2025. 6. 22.
  Time: 오후 9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pagination">
  <ul class="page-list">

    <c:choose>
      <c:when test="${condition.page > 1}">
        <li><a href="?page=${condition.page - 1}&district=${condition.district}&checkIn=${condition.checkIn}&checkOut=${condition.checkOut}&adultCnt=${condition.adultCnt}&babyCnt=${condition.babyCnt}">❮</a></li>
      </c:when>
      <c:otherwise>
        <li class="disabled">❮</li>
      </c:otherwise>
    </c:choose>

    <c:forEach var="i" begin="1" end="${totalPages}">
      <li>
        <a href="?page=${i}&district=${condition.district}&checkIn=${condition.checkIn}&checkOut=${condition.checkOut}&adultCnt=${condition.adultCnt}&babyCnt=${condition.babyCnt}"
           class="${condition.page == i ? 'active' : ''}">
            ${i}
        </a>
      </li>
    </c:forEach>

    <c:choose>
      <c:when test="${condition.page < totalPages}">
        <li><a href="?page=${condition.page + 1}&district=${condition.district}&checkIn=${condition.checkIn}&checkOut=${condition.checkOut}&adultCnt=${condition.adultCnt}&babyCnt=${condition.babyCnt}">❯</a></li>
      </c:when>
      <c:otherwise>
        <li class="disabled">❯</li>
      </c:otherwise>
    </c:choose>

  </ul>
</div>
