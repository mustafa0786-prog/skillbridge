<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users — SkillBridge Admin</title>
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
            transition: color 0.2s;
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
            align-items: center;
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
            transition: all 0.2s;
        }
        .filter-chip:hover {
            border-color: #2563eb;
            color: #2563eb;
        }
        .filter-chip.active {
            background: #2563eb;
            color: white;
            border-color: #2563eb;
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
        .admin-table tr:last-child td {
            border-bottom: none;
        }
        .admin-table tr:hover {
            background: #f8fafc;
        }
        .role-badge {
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .role-badge-CLIENT { background: #dbeafe; color: #1e40af; }
        .role-badge-FREELANCER { background: #dcfce7; color: #166534; }
        .role-badge-ADMIN { background: #fef3c7; color: #92400e; }
        .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }
        .btn-danger {
            background: #fee2e2;
            color: #b91c1c;
        }
        .btn-danger:hover {
            background: #fecaca;
        }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <div class="admin-nav">
        <div class="admin-nav-inner">
            <a href="/admin/dashboard">Dashboard</a>
            <a href="/admin/users" class="active">Users</a>
            <a href="/admin/projects">Projects</a>
            <a href="/admin/bids">Bids</a>
        </div>
    </div>

    <section class="section" style="padding-top: 0;">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>Manage Users</h1>
                    <p>Total: <strong>${users.size()}</strong> user${users.size() != 1 ? 's' : ''}</p>
                </div>
            </div>

            <c:if test="${param.deleted == 'true'}">
                <div class="alert alert-success" style="margin-bottom: 24px;">✓ User deleted successfully.</div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-error" style="margin-bottom: 24px;">${param.error}</div>
            </c:if>

            <div class="filter-row">
                <a href="/admin/users" class="filter-chip ${empty roleFilter ? 'active' : ''}">All</a>
                <a href="/admin/users?role=CLIENT" class="filter-chip ${roleFilter == 'CLIENT' ? 'active' : ''}">Clients</a>
                <a href="/admin/users?role=FREELANCER" class="filter-chip ${roleFilter == 'FREELANCER' ? 'active' : ''}">Freelancers</a>
                <a href="/admin/users?role=ADMIN" class="filter-chip ${roleFilter == 'ADMIN' ? 'active' : ''}">Admins</a>
            </div>

            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                        <tr>
                            <td>#${u.id}</td>
                            <td><strong>${u.name}</strong></td>
                            <td>${u.email}</td>
                            <td>${u.phone != null ? u.phone : '-'}</td>
                            <td>
                                <span class="role-badge role-badge-${u.role}">${u.role}</span>
                            </td>
                            <td>
                                <c:if test="${u.role != 'ADMIN'}">
                                    <form action="/admin/users/${u.id}/delete" method="post" style="display:inline;"
                                          onsubmit="return confirm('Delete user ${u.name}? This action cannot be undone.');">
                                        <button type="submit" class="btn-sm btn-danger">Delete</button>
                                    </form>
                                </c:if>
                                <c:if test="${u.role == 'ADMIN'}">
                                    <span style="color:#94a3b8; font-size:12px;">Protected</span>
                                </c:if>
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