<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Leave a Review — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/auth.css">
    <style>
        .review-freelancer {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            margin-bottom: 24px;
        }
        .freelancer-avatar-lg {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            font-weight: 700;
        }
        .review-freelancer h4 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .review-freelancer p {
            font-size: 14px;
            color: #64748b;
        }

        /* Star Rating */
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 8px;
            margin-top: 8px;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 40px;
            color: #cbd5e1;
            cursor: pointer;
            transition: color 0.15s;
        }
        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input:checked ~ label {
            color: #f59e0b;
        }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="auth-section">
        <div class="auth-card" style="max-width: 600px;">
            <div class="auth-header">
                <h1>Leave a Review</h1>
                <p>How was your experience working with this freelancer?</p>
            </div>

            <%-- Freelancer info --%>
            <div class="review-freelancer">
                <div class="freelancer-avatar-lg">
                    ${freelancer.name.substring(0,1).toUpperCase()}
                </div>
                <div>
                    <h4>${freelancer.name}</h4>
                    <p>${freelancer.email}</p>
                </div>
            </div>

            <%-- Project info --%>
            <div style="margin-bottom: 24px; font-size: 14px; color: #64748b;">
                Project: <strong style="color:#0f172a;">${project.title}</strong>
            </div>

            <%-- Error --%>
            <c:if test="${errorMessage != null}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form action="/client/project/${project.id}/review" method="post" class="auth-form">

                <div class="form-group">
                    <label>Your Rating</label>
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rating" value="5" required>
                        <label for="star5">★</label>
                        <input type="radio" id="star4" name="rating" value="4">
                        <label for="star4">★</label>
                        <input type="radio" id="star3" name="rating" value="3">
                        <label for="star3">★</label>
                        <input type="radio" id="star2" name="rating" value="2">
                        <label for="star2">★</label>
                        <input type="radio" id="star1" name="rating" value="1">
                        <label for="star1">★</label>
                    </div>
                    <small style="color:#64748b; font-size:13px; margin-top:8px;">
                        Click a star — 5 = Excellent, 1 = Poor
                    </small>
                </div>

                <div class="form-group">
                    <label for="review">Your Review</label>
                    <textarea id="review" name="review"
                              placeholder="Share your experience working with this freelancer..."
                              required rows="5" minlength="10"
                              style="padding: 12px 16px; border: 1.5px solid #e2e8f0; border-radius: 10px; font-family: inherit; font-size: 15px; resize: vertical;"></textarea>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">
                    Submit Review
                </button>

                <p class="auth-footer-text">
                    <a href="/client/project/${project.id}/bids">← Back to Bids</a>
                </p>
            </form>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>