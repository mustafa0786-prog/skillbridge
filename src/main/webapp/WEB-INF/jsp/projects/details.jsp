<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${project.title} — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .details-container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 24px;
        }
        .details-card {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 40px;
            margin-bottom: 24px;
        }
        .details-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        .details-title {
            font-size: 32px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.2;
            letter-spacing: -1px;
        }
        .details-meta {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 24px 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
            margin: 24px 0;
        }
        .details-meta-item .label {
            font-size: 12px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .details-meta-item .value {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
        }
        .details-meta-item .value.budget {
            color: #10b981;
        }
        .details-description {
            font-size: 16px;
            line-height: 1.7;
            color: #334155;
            white-space: pre-wrap;
        }
        .details-client {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            margin-top: 24px;
        }
        .client-avatar {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            font-weight: 700;
        }
        .client-info h4 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 2px;
        }
        .client-info p {
            font-size: 14px;
            color: #64748b;
        }
        .action-bar {
            display: flex;
            gap: 12px;
            margin-top: 24px;
            flex-wrap: wrap;
        }
        .badge-open { background: #dcfce7; color: #166534; padding: 6px 16px; border-radius: 50px; font-size: 12px; font-weight: 700; }
        .badge-progress { background: #fef3c7; color: #92400e; padding: 6px 16px; border-radius: 50px; font-size: 12px; font-weight: 700; }
        .badge-completed { background: #e0e7ff; color: #3730a3; padding: 6px 16px; border-radius: 50px; font-size: 12px; font-weight: 700; }

        @media (max-width: 600px) {
            .details-card { padding: 24px; }
            .details-title { font-size: 24px; }
            .details-meta { grid-template-columns: 1fr; gap: 12px; }
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <div class="details-container">

        <a href="/projects" style="color:#2563eb; font-weight:600; font-size:14px; display:inline-block; margin-bottom:16px;">
            ← Back to Projects
        </a>

        <div class="details-card">
            <div class="details-header">
                <div>
                    <div style="margin-bottom: 8px;">
                        <span class="project-category" style="font-size:12px; padding:4px 12px; background:#dbeafe; color:#2563eb; border-radius:50px; font-weight:600;">
                            <c:choose>
                                <c:when test="${project.category != null}">
                                    ${project.category.image} ${project.category.name}
                                </c:when>
                                <c:otherwise>Uncategorized</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <h1 class="details-title">${project.title}</h1>
                </div>
                <span class="badge-${project.status == 'OPEN' ? 'open' : (project.status == 'IN_PROGRESS' ? 'progress' : 'completed')}">
                    ${project.status}
                </span>
            </div>

            <div class="details-meta">
                <div class="details-meta-item">
                    <div class="label">Budget</div>
                    <div class="value budget">₹<fmt:formatNumber value="${project.budget}" type="number" maxFractionDigits="0" /></div>
                </div>
                <div class="details-meta-item">
                    <div class="label">Deadline</div>
                    <div class="value">${project.deadline}</div>
                </div>
                <div class="details-meta-item">
                    <div class="label">Posted On</div>
                    <div class="value" style="font-size:16px;">${project.createdAt.toLocalDate()}</div>
                </div>
            </div>

            <h3 style="font-size:18px; font-weight:700; color:#0f172a; margin-bottom:12px;">Project Description</h3>
            <div class="details-description">${project.description}</div>

            <div class="details-client">
                <div class="client-avatar">
                    ${project.client.name.substring(0,1).toUpperCase()}
                </div>
                <div class="client-info">
                    <h4>${project.client.name}</h4>
                    <p>Project Owner</p>
                </div>
            </div>

            <%-- Action buttons - login state ke hisaab se --%>
            <div class="action-bar">
                <c:choose>
                    <%-- Guest user --%>
                    <c:when test="${sessionScope.userId == null}">
                        <a href="/login" class="btn btn-primary btn-lg">Login to Submit Bid</a>
                        <a href="/register" class="btn btn-outline btn-lg">Create Account</a>
                    </c:when>

                    <%-- Logged in freelancer --%>
                    <c:when test="${sessionScope.userRole == 'FREELANCER'}">
                        <c:if test="${project.status == 'OPEN'}">
                            <a href="/freelancer/submit-bid/${project.id}" class="btn btn-primary btn-lg">
                                Submit a Bid
                            </a>
                        </c:if>
                        <a href="/messages/${project.client.id}" class="btn btn-outline btn-lg">
                            💬 Message Client
                        </a>
                    </c:when>

                    <%-- Logged in client --%>
                    <c:when test="${sessionScope.userRole == 'CLIENT'}">
                        <c:if test="${project.client.id == sessionScope.userId}">
                            <div class="alert alert-success" style="width: 100%; text-align: center;">
                                ✓ This is your project
                            </div>
                        </c:if>
                        <c:if test="${project.client.id != sessionScope.userId}">
                            <p style="color:#64748b; padding:12px 0;">You are logged in as a Client. Only freelancers can submit bids.</p>
                        </c:if>
                    </c:when>

                    <%-- Admin --%>
                    <c:when test="${sessionScope.userRole == 'ADMIN'}">
                        <p style="color:#64748b; padding:12px 0;">Admin view — no actions available</p>
                    </c:when>
                </c:choose>
            </div>

        </div>

    </div>

    <%@ include file="../common/footer.jsp" %>

</body>
</html>