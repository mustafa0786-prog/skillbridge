<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Projects — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="section">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>My Projects</h1>
                    <p>All projects you have posted</p>
                </div>
                <a href="/client/post-project" class="btn btn-primary btn-lg">
                    + Post New Project
                </a>
            </div>

            <%-- Success / Error messages --%>
            <c:if test="${param.error != null}">
                <div class="alert alert-error" style="margin-bottom: 24px;">
                    ${param.error}
                </div>
            </c:if>

            <c:if test="${param.success != null}">
                <div class="alert alert-success" style="margin-bottom: 24px;">
                    ${param.success}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty projects}">
                    <div class="empty-state">
                        <div style="font-size: 60px; margin-bottom: 16px;">📋</div>
                        <h3>No projects yet</h3>
                        <p>You haven't posted any projects. Start by posting your first project!</p>
                        <a href="/client/post-project" class="btn btn-primary btn-lg">
                            Post Your First Project
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="projects-grid">
                        <c:forEach var="project" items="${projects}">
                            <div class="project-card">
                                <div class="project-header">
                                    <span class="project-category">
                                        <c:choose>
                                            <c:when test="${project.category != null}">
                                                ${project.category.image} ${project.category.name}
                                            </c:when>
                                            <c:otherwise>Uncategorized</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <span class="badge badge-${project.status == 'OPEN' ? 'open' : (project.status == 'IN_PROGRESS' ? 'progress' : 'completed')}">
                                        ${project.status}
                                    </span>
                                </div>
                                <h3>${project.title}</h3>
                                <p class="description">${project.description}</p>
                                <div class="project-meta">
                                    <div class="project-meta-item">
                                        <span class="label">Budget</span>
                                        <span class="value budget">₹<fmt:formatNumber value="${project.budget}" type="number" maxFractionDigits="0" /></span>
                                    </div>
                                    <div class="project-meta-item">
                                        <span class="label">Deadline</span>
                                        <span class="value">${project.deadline}</span>
                                    </div>
                                </div>
                                <div style="display: flex; gap: 8px;">
                                    <a href="/projects/${project.id}" class="btn btn-outline" style="flex:1;">View Details</a>
                                    <a href="/client/project/${project.id}/bids" class="btn btn-primary" style="flex:1;">View Bids</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>