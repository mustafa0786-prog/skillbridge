<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Browse Projects — SkillBridge</title>
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

        .filter-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 32px;
            flex-wrap: wrap;
            align-items: center;
        }
        .filter-label {
            font-weight: 600;
            font-size: 14px;
            color: #64748b;
            margin-right: 8px;
        }
        .filter-chip {
            padding: 8px 16px;
            border-radius: 50px;
            border: 1px solid #e2e8f0;
            background: white;
            font-size: 13px;
            font-weight: 500;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
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

        .result-count {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 20px;
        }
        .result-count strong {
            color: #0f172a;
            font-weight: 700;
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <!-- Hero -->
    <section class="browse-header">
        <h1>Find Your Next Project</h1>
        <p>Browse thousands of projects posted by clients worldwide</p>

        <form action="/projects" method="get" class="browse-search">
            <input type="text" name="q" 
                   placeholder="Search projects by title..."
                   value="${keyword}">
            <c:if test="${not empty selectedCategory}">
                <input type="hidden" name="category" value="${selectedCategory}">
            </c:if>
            <button type="submit">Search</button>
        </form>
    </section>

    <div class="browse-container">

        <!-- Category Filter -->
        <div class="filter-bar">
            <span class="filter-label">Filter:</span>
            <a href="/projects${not empty keyword ? '?q='.concat(keyword) : ''}" 
               class="filter-chip ${empty selectedCategory ? 'active' : ''}">
                All Categories
            </a>
            <c:forEach var="cat" items="${categories}">
                <a href="/projects?category=${cat.id}${not empty keyword ? '&q='.concat(keyword) : ''}"
                   class="filter-chip ${selectedCategory == cat.id ? 'active' : ''}">
                    ${cat.image} ${cat.name}
                </a>
            </c:forEach>
        </div>

        <!-- Result count -->
        <div class="result-count">
            Found <strong>${projects.size()}</strong> project${projects.size() != 1 ? 's' : ''}
        </div>

        <!-- Projects Grid -->
        <c:choose>
            <c:when test="${empty projects}">
                <div class="empty-state">
                    <div style="font-size: 60px; margin-bottom: 16px;">🔍</div>
                    <h3>No projects found</h3>
                    <p>Try different keywords or remove filters</p>
                    <a href="/projects" class="btn btn-primary btn-lg">View All Projects</a>
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
                                <span class="badge badge-open">OPEN</span>
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
                            <a href="/projects/${project.id}" class="btn btn-primary">View Details</a>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <%@ include file="../common/footer.jsp" %>

</body>
</html>