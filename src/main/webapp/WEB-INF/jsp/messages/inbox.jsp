<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inbox — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .inbox-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 24px;
        }
        .inbox-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }
        .inbox-header h1 {
            font-size: 32px;
            font-weight: 800;
            color: #0f172a;
        }
        .unread-badge {
            background: #2563eb;
            color: white;
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 700;
        }
        .conversation-list {
            background: white;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
        }
        .conversation-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 20px 24px;
            border-bottom: 1px solid #f1f5f9;
            text-decoration: none;
            color: inherit;
            transition: background 0.2s;
        }
        .conversation-item:last-child {
            border-bottom: none;
        }
        .conversation-item:hover {
            background: #f8fafc;
        }
        .conversation-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
            flex-shrink: 0;
        }
        .conversation-info {
            flex: 1;
        }
        .conversation-info h4 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }
        .conversation-info p {
            font-size: 13px;
            color: #64748b;
        }
        .conversation-arrow {
            color: #94a3b8;
            font-size: 20px;
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <div class="inbox-container">
        <div class="inbox-header">
            <h1>Inbox</h1>
            <c:if test="${unreadCount > 0}">
                <span class="unread-badge">${unreadCount} unread</span>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty partners}">
                <div class="empty-state">
                    <div style="font-size: 60px; margin-bottom: 16px;">💬</div>
                    <h3>No conversations yet</h3>
                    <p>Start a conversation from a project, bid, or freelancer profile.</p>
                    <a href="/projects" class="btn btn-primary btn-lg">Browse Projects</a>
                </div>
            </c:when>

            <c:otherwise>
                <div class="conversation-list">
                    <c:forEach var="p" items="${partners}">
                        <a href="/messages/${p.id}" class="conversation-item">
                            <div class="conversation-avatar">
                                ${p.name.substring(0,1).toUpperCase()}
                            </div>
                            <div class="conversation-info">
                                <h4>${p.name}</h4>
                                <p>${p.role} • ${p.email}</p>
                            </div>
                            <div class="conversation-arrow">→</div>
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file="../common/footer.jsp" %>

</body>
</html>