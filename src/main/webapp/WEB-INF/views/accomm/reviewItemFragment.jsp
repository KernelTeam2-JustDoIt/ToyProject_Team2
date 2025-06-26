<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:forEach var="review" items="${reviewList}">
  <div class="review-item">
    <div class="review-header">
      <div class="review-stars">
        <c:forEach begin="1" end="5" var="i">
          <c:choose>
            <c:when test="${i <= review.reviewScore}">
              <i class="star filled">★</i>
            </c:when>
            <c:otherwise>
              <i class="star">★</i>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </div>
      <div class="review-meta">
        <span class="review-writer">고객1</span>
        <span class="review-type">${review.accommodationName} | ${review.rating}</span>
      </div>
      <div class="review-date">${review.createdAt}</div>
    </div>

    <div class="review-content">
      <p>${review.reviewDetail}</p>
    </div>

    <div class="review-reply">
      <strong>숙소 답변</strong>
      <div class="reply-content short" id="reply_${review.reviewId}">
        <p>고객님의 소중한 의견 감사합니다. 더욱 노력하겠습니다.</p>
        <div class="reply-date">2025-06-24</div>
      </div>
      <button class="btn-toggle" onclick="toggleReply('reply_${review.reviewId}', this)">더보기 ▼</button>
    </div>

  </div>
</c:forEach>
