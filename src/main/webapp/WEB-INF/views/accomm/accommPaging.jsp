<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="pagination">
  <ul class="page-list">

    <c:choose>
      <c:when test="${condition.page > 1}">
        <li>
          <a href="<c:url value='/domestic/hotel'>
              <c:param name='page' value='${condition.page - 1}'/>
              <c:if test='${not empty condition.district}'><c:param name='district' value='${condition.district}'/></c:if>
              <c:if test='${not empty condition.checkIn}'><c:param name='checkIn' value='${condition.checkIn}'/></c:if>
              <c:if test='${not empty condition.checkOut}'><c:param name='checkOut' value='${condition.checkOut}'/></c:if>
              <c:if test='${not empty condition.adultCnt}'><c:param name='adultCnt' value='${condition.adultCnt}'/></c:if>
              <c:if test='${not empty condition.babyCnt}'><c:param name='babyCnt' value='${condition.babyCnt}'/></c:if>
              <c:if test='${not empty condition.keyword}'><c:param name='keyword' value='${condition.keyword}'/></c:if>
          </c:url>">❮</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="disabled">❮</li>
      </c:otherwise>
    </c:choose>

    <c:forEach var="i" begin="1" end="${totalPages}">
      <li>
        <a href="<c:url value='/domestic/hotel'>
              <c:param name='page' value='${i}'/>
              <c:if test='${not empty condition.district}'><c:param name='district' value='${condition.district}'/></c:if>
              <c:if test='${not empty condition.checkIn}'><c:param name='checkIn' value='${condition.checkIn}'/></c:if>
              <c:if test='${not empty condition.checkOut}'><c:param name='checkOut' value='${condition.checkOut}'/></c:if>
              <c:if test='${not empty condition.adultCnt}'><c:param name='adultCnt' value='${condition.adultCnt}'/></c:if>
              <c:if test='${not empty condition.babyCnt}'><c:param name='babyCnt' value='${condition.babyCnt}'/></c:if>
              <c:if test='${not empty condition.keyword}'><c:param name='keyword' value='${condition.keyword}'/></c:if>
          </c:url>"
           class="${condition.page == i ? 'active' : ''}">
            ${i}
        </a>
      </li>
    </c:forEach>

    <c:choose>
      <c:when test="${condition.page < totalPages}">
        <li>
          <a href="<c:url value='/domestic/hotel'>
              <c:param name='page' value='${condition.page + 1}'/>
              <c:if test='${not empty condition.district}'><c:param name='district' value='${condition.district}'/></c:if>
              <c:if test='${not empty condition.checkIn}'><c:param name='checkIn' value='${condition.checkIn}'/></c:if>
              <c:if test='${not empty condition.checkOut}'><c:param name='checkOut' value='${condition.checkOut}'/></c:if>
              <c:if test='${not empty condition.adultCnt}'><c:param name='adultCnt' value='${condition.adultCnt}'/></c:if>
              <c:if test='${not empty condition.babyCnt}'><c:param name='babyCnt' value='${condition.babyCnt}'/></c:if>
              <c:if test='${not empty condition.keyword}'><c:param name='keyword' value='${condition.keyword}'/></c:if>
          </c:url>">❯</a>
        </li>
      </c:when>
      <c:otherwise>
        <li class="disabled">❯</li>
      </c:otherwise>
    </c:choose>

  </ul>
</div>
