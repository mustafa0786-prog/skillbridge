<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Client Dashboard — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="section">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>Welcome, ${sessionScope.userName}! 👋</h1>
                    <p>Manage your projects and find the perfect freelancer</p>
                </div>
                <a href="/client/post-project" class="btn btn-primary btn-lg">
                    + Post New Project
                </a>
            </div>

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
                    <div class="stat-value stat-orange">${inProgressProjects}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Completed</div>
                    <div class="stat-value stat-blue">${completedProjects}</div>
                </div>
            </div>

            <div class="dashboard-actions">
                <a href="/client/my-projects" class="btn btn-outline btn-lg">
                    View My Projects
                </a>
            </div>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>