<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Freelancer Dashboard — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="section">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>Welcome, ${sessionScope.userName}! 💼</h1>
                    <p>Find projects, submit bids, and grow your freelance career</p>
                </div>
                <a href="/projects" class="btn btn-primary btn-lg">
                    Browse Projects
                </a>
            </div>

            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-label">Available Projects</div>
                    <div class="stat-value">${availableProjects}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">My Bids</div>
                    <div class="stat-value stat-orange">${totalBids}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Pending</div>
                    <div class="stat-value stat-orange">${pendingBids}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Accepted</div>
                    <div class="stat-value stat-green">${acceptedBids}</div>
                </div>
            </div>

            <div class="dashboard-actions">
                <a href="/freelancer/my-bids" class="btn btn-outline btn-lg">
                    View My Bids
                </a>
            </div>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>