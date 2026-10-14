<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Bids — SkillBridge Admin</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .admin-nav {
            background: white;
            border-bottom: 1px solid #e2e8f0;
            padding: 16px 0;
            margin-bottom: 40px;
        }
        .admin-nav-inner {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
            display: flex;
            gap: 24px;
            flex-wrap: wrap;
        }
        .admin-nav a {
            color: #64748b;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            padding: 8px 0;
        }
        .admin-nav a:hover, .admin-nav a.active {
            color: #2563eb;
        }
        .admin-nav a.active {
            border-bottom: 2px solid #2563eb;
        }
        .admin-table {
            width: 100%;
            background: white;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            border-collapse: collapse;
        }
        .admin-table th {
            background: #f8fafc;
            padding: 14px 20px;
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #64748b;
            font-weight: 700;
            border-bottom: 1px solid #e2e8f0;
        }
        .admin-table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
            color: #334155;
        }
        .admin-table tr:last-child td { border-bottom: none; }
        .admin-table tr:hover { background: #f8fafc; }
        .status-badge {
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 50px;
            text-transform: uppercase;
        }
        .status-PENDING { background: #fef3c7; color: #92400e; }
        .status-ACCEPTED { background: #dcfce7; color: #166534; }
        .status-REJECTED { background: #fee2e2; color: #b91c1c; }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <div class="admin-nav">
        <div class="admin-nav-inner">
            <a href="/admin/dashboard">Dashboard</a>
            <a href="/admin/users">Users</a>
            <a href="/admin/projects">Projects</a>
            <a href="/admin/bids" class="active">Bids</a>
        </div>
    </div>

    <section class="section" style="padding-top: 0;">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>All Bids</h1>
                    <p>Total: <strong>${bids.size()}</strong> bid${bids.size() != 1 ? 's' : ''}</p>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty bids}">
                    <div class="empty-state">
                        <div style="font-size: 60px; margin-bottom: 16px;">📭</div>
                        <h3>No bids yet</h3>
                        <p>No bids have been submitted yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Project</th>
                                <th>Freelancer</th>
                                <th>Amount</th>
                                <th>Delivery</th>
                                <th>Status</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${bids}">
                                <tr>
                                    <td>#${b.id}</td>
                                    <td><strong>${b.project.title}</strong></td>
                                    <td>${b.freelancer.name}</td>
                                    <td>₹<fmt:formatNumber value="${b.amount}" type="number" maxFractionDigits="0" /></td>
                                    <td>${b.deliveryDays} days</td>
                                    <td>
                                        <span class="status-badge status-${b.status}">${b.status}</span>
                                    </td>
                                    <td>${b.createdAt.toLocalDate()}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>