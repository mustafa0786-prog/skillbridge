<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard — SkillBridge</title>
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
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <div class="admin-nav">
        <div class="admin-nav-inner">
            <a href="/admin/dashboard" class="active">Dashboard</a>
            <a href="/admin/users">Users</a>
            <a href="/admin/projects">Projects</a>
            <a href="/admin/bids">Bids</a>
        </div>
    </div>

    <section class="section" style="padding-top: 0;">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>Admin Dashboard 🔐</h1>
                    <p>Platform-wide statistics and management</p>
                </div>
            </div>

            <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin-bottom: 20px;">Overview</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Total Users</div>
                    <div class="stat-value">${totalUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Clients</div>
                    <div class="stat-value stat-blue">${totalClients}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Freelancers</div>
                    <div class="stat-value stat-green">${totalFreelancers}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Bids</div>
                    <div class="stat-value stat-orange">${totalBids}</div>
                </div>
            </div>

            <h3 style="font-size: 20px; font-weight: 700; color: #0f172a; margin: 40px 0 20px 0;">Projects</h3>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Total Projects</div>
                    <div class="stat-value">${totalProjects}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Open</div>
                    <div class="stat-value stat-green">${openProjects}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">In Progress</div>
                    <div class="stat-value stat-orange">${inProgress}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Completed</div>
                    <div class="stat-value stat-blue">${completed}</div>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>