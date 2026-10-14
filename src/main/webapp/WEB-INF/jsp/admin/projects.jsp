<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Projects — SkillBridge Admin</title>
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
        .filter-row {
            display: flex;
            gap: 12px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        .filter-chip {
            padding: 8px 16px;
            border-radius: 50px;
            border: 1px solid #e2e8f0;
            background: white;
            font-size: 13px;
            font-weight: 500;
            color: #64748b;
            text-decoration: none;
        }
        .filter-chip:hover { border-color: #2563eb; color: #2563eb; }
        .filter-chip.active { background: #2563eb; color: white; border-color: #2563eb; }
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
        .status-OPEN { background: #dcfce7; color: #166534; }
        .status-IN_PROGRESS { background: #fef3c7; color: #92400e; }
        .status-COMPLETED { background: #e0e7ff; color: #3730a3; }
        .status-CANCELLED { background: #fee2e2; color: #b91c1c; }
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }
        .btn-danger { background: #fee2e2; color: #b91c1c; }
        .btn-danger:hover { background: #fecaca; }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <div class="admin-nav">
        <div class="admin-nav-inner">
            <a href="/admin/dashboard">Dashboard</a>
            <a href="/admin/users">Users</a>
            <a href="/admin/projects" class="active">Projects</a>
            <a href="/admin/bids">Bids</a>
        </div>
    </div>

    <section class="section" style="padding-top: 0;">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>Manage Projects</h1>
                    <p>Total: <strong>${projects.size()}</strong> project${projects.size() != 1 ? 's' : ''}</p>
                </div>
            </div>

            <c:if test="${param.deleted == 'true'}">
                <div class="alert alert-success" style="margin-bottom: 24px;">✓ Project deleted.</div>
            </c:if>

            <div class="filter-row">
                <a href="/admin/projects" class="filter-chip ${empty statusFilter ? 'active' : ''}">All</a>
                <a href="/admin/projects?status=OPEN" class="filter-chip ${statusFilter == 'OPEN' ? 'active' : ''}">Open</a>
                <a href="/admin/projects?status=IN_PROGRESS" class="filter-chip ${statusFilter == 'IN_PROGRESS' ? 'active' : ''}">In Progress</a>
                <a href="/admin/projects?status=COMPLETED" class="filter-chip ${statusFilter == 'COMPLETED' ? 'active' : ''}">Completed</a>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Client</th>
                        <th>Budget</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${projects}">
                        <tr>
                            <td>#${p.id}</td>
                            <td><strong>${p.title}</strong></td>
                            <td>${p.client.name}</td>
                            <td>₹<fmt:formatNumber value="${p.budget}" type="number" maxFractionDigits="0" /></td>
                            <td>
                                <span class="status-badge status-${p.status}">${p.status}</span>
                            </td>
                            <td>
                                <a href="/projects/${p.id}" class="btn-sm" 
                                   style="background:#dbeafe; color:#1e40af; text-decoration:none; display:inline-block;">View</a>
                                <form action="/admin/projects/${p.id}/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Delete this project? This will also delete all bids.');">
                                    <button type="submit" class="btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>