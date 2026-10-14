<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Find Freelancers — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .browse-header {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            color: white;
            padding: 60px 24px 40px;
            text-align: center;
        }
        .browse-header h1 {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -1px;
        }
        .browse-header p {
            color: rgba(255,255,255,0.85);
            font-size: 16px;
            margin-bottom: 24px;
        }
        .browse-search {
            display: flex;
            background: white;
            border-radius: 50px;
            padding: 6px;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        .browse-search input {
            flex: 1;
            border: none;
            outline: none;
            padding: 12px 20px;
            font-size: 15px;
            background: transparent;
            font-family: inherit;
        }
        .browse-search button {
            padding: 12px 28px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            font-size: 14px;
        }
        .browse-search button:hover { background: #1d4ed8; }

        .browse-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 24px;
        }
        .result-count {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }
        .result-count strong {
            color: #0f172a;
            font-weight: 700;
        }

        .freelancer-rating-line {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-bottom: 12px;
        }
        .freelancer-rating-line .stars {
            color: #f59e0b;
            font-size: 15px;
            letter-spacing: 1px;
        }
        .freelancer-rating-line .rating-text {
            font-size: 14px;
            font-weight: 600;
            color: #1e293b;
        }
        .freelancer-rating-line .no-rating {
            font-size: 13px;
            color: #94a3b8;
            font-style: italic;
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <!-- Hero -->
    <section class="browse-header">
        <h1>Find Top Freelancers</h1>
        <p>Connect with skilled professionals ready to work on your project</p>

        <form action="/freelancers" method="get" class="browse-search">
            <input type="text" name="q"
                   placeholder="Search freelancers by name..."
                   value="${keyword}">
            <button type="submit">Search</button>
        </form>
    </section>

    <div class="browse-container">

        <!-- Result count -->
        <div class="result-count">
            Found <strong>${freelancers.size()}</strong> freelancer${freelancers.size() != 1 ? 's' : ''}
        </div>

        <!-- Freelancers Grid -->
        <c:choose>
            <c:when test="${empty freelancers}">
                <div class="empty-state">
                    <div style="font-size: 60px; margin-bottom: 16px;">👥</div>
                    <h3>No freelancers found</h3>
                    <p>Try different search keywords</p>
                    <a href="/freelancers" class="btn btn-primary btn-lg">View All Freelancers</a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="freelancers-grid">
                    <c:forEach var="f" items="${freelancers}">
                        <div class="freelancer-card">
                            <div class="freelancer-avatar">
                                ${f.name.substring(0,1).toUpperCase()}
                            </div>
                            <h3>${f.name}</h3>

                            <div class="freelancer-rating-line">
                                <c:choose>
                                    <c:when test="${countsMap[f.id] > 0}">
                                        <span class="stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <c:choose>
                                                    <c:when test="${i <= ratingsMap[f.id]}">★</c:when>
                                                    <c:otherwise>☆</c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </span>
                                        <span class="rating-text">
                                            <fmt:formatNumber value="${ratingsMap[f.id]}" maxFractionDigits="1" />
                                            (${countsMap[f.id]})
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-rating">No reviews yet</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <p class="freelancer-rate" style="font-size:13px; color:#64748b; margin-bottom:20px;">
                                ${f.email}
                            </p>

                            <a href="/freelancers/${f.id}" class="btn btn-outline">View Profile</a>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <%@ include file="../common/footer.jsp" %>

</body>
</html>