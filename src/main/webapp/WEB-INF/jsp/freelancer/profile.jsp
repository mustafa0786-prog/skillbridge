<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${freelancer.name} — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .profile-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px;
        }
        .profile-header {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 40px;
            text-align: center;
            margin-bottom: 24px;
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            font-weight: 700;
            margin: 0 auto 20px;
            box-shadow: 0 10px 30px rgba(37, 99, 235, 0.3);
        }
        .profile-header h1 {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .profile-header .email {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 16px;
        }
        .profile-rating {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-size: 16px;
            margin-bottom: 24px;
        }
        .profile-rating .stars {
            color: #f59e0b;
            font-size: 22px;
            letter-spacing: 2px;
        }
        .profile-rating .number {
            font-weight: 700;
            font-size: 20px;
            color: #0f172a;
        }
        .profile-rating .count {
            color: #64748b;
            font-size: 14px;
        }
        .profile-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 8px;
        }

        .reviews-list {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 32px;
        }
        .reviews-list h2 {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 24px;
            padding-bottom: 16px;
            border-bottom: 1px solid #e2e8f0;
        }
        .review-item {
            padding: 20px 0;
            border-bottom: 1px solid #f1f5f9;
        }
        .review-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }
        .reviewer-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .reviewer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #dbeafe;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
        }
        .reviewer-info strong {
            display: block;
            font-size: 15px;
            color: #0f172a;
        }
        .reviewer-info small {
            color: #64748b;
            font-size: 12px;
        }
        .review-stars {
            color: #f59e0b;
            font-size: 16px;
            letter-spacing: 2px;
        }
        .review-text {
            font-size: 15px;
            color: #334155;
            line-height: 1.6;
            margin-left: 52px;
        }
        .empty-reviews {
            text-align: center;
            padding: 40px 20px;
            color: #94a3b8;
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <div class="profile-container">

        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar">
                ${freelancer.name.substring(0,1).toUpperCase()}
            </div>
            <h1>${freelancer.name}</h1>
            <p class="email">${freelancer.email}</p>

            <div class="profile-rating">
                <c:choose>
                    <c:when test="${reviewCount > 0}">
                        <span class="stars">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= avgRating}">★</c:when>
                                    <c:otherwise>☆</c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </span>
                        <span class="number">${avgRating}</span>
                        <span class="count">(${reviewCount} review${reviewCount != 1 ? 's' : ''})</span>
                    </c:when>
                    <c:otherwise>
                        <span class="count">No reviews yet</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Action Buttons: Send Message --%>
            <div class="profile-actions">
                <c:if test="${sessionScope.userId == null}">
                    <%-- Guest user --%>
                    <a href="/login" class="btn btn-primary btn-lg">💬 Login to Message</a>
                </c:if>
                <c:if test="${sessionScope.userId != null && sessionScope.userId != freelancer.id}">
                    <%-- Logged in user, viewing another freelancer --%>
                    <a href="/messages/${freelancer.id}" class="btn btn-primary btn-lg">
                        💬 Send Message
                    </a>
                </c:if>
                <c:if test="${sessionScope.userId == freelancer.id}">
                    <%-- Viewing own profile --%>
                    <span style="color:#64748b; font-size:14px; padding:12px 0;">
                        This is your public profile
                    </span>
                </c:if>
            </div>
        </div>

        <!-- Reviews List -->
        <div class="reviews-list">
            <h2>Reviews (${reviewCount})</h2>

            <c:choose>
                <c:when test="${empty reviews}">
                    <div class="empty-reviews">
                        <div style="font-size: 48px; margin-bottom: 12px;">💬</div>
                        <p>No reviews yet. This freelancer is new to SkillBridge.</p>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-item">
                            <div class="review-header">
                                <div class="reviewer-info">
                                    <div class="reviewer-avatar">
                                        ${review.reviewer.name.substring(0,1).toUpperCase()}
                                    </div>
                                    <div>
                                        <strong>${review.reviewer.name}</strong>
                                        <small>${review.createdAt.toLocalDate()}</small>
                                    </div>
                                </div>
                                <div class="review-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= review.rating}">★</c:when>
                                            <c:otherwise>☆</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="review-text">${review.review}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

    <%@ include file="../common/footer.jsp" %>

</body>
</html>