<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Categories — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .categories-hero {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            color: white;
            padding: 60px 24px 40px;
            text-align: center;
        }
        .categories-hero h1 {
            font-size: 38px;
            font-weight: 800;
            margin-bottom: 8px;
            letter-spacing: -1px;
        }
        .categories-hero p {
            color: rgba(255,255,255,0.85);
            font-size: 16px;
        }
        .categories-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 24px;
        }
        .categories-grid-lg {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
        }
        .category-card-lg {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 32px 24px;
            text-align: center;
            text-decoration: none;
            color: inherit;
            transition: all 0.25s;
            display: block;
        }
        .category-card-lg:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
            border-color: #2563eb;
        }
        .category-icon-lg {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }
        .category-card-lg h3 {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .category-card-lg p {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 16px;
            line-height: 1.5;
        }
        .category-card-lg .view-link {
            color: #2563eb;
            font-weight: 600;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <%@ include file="common/navbar.jsp" %>

    <section class="categories-hero">
        <h1>Browse Categories</h1>
        <p>Explore projects and services across the most in-demand skills</p>
    </section>

    <div class="categories-container">
        <div class="categories-grid-lg">
            <c:forEach var="cat" items="${categories}">
                <a href="/projects?category=${cat.id}" class="category-card-lg">
                    <div class="category-icon-lg">${cat.image}</div>
                    <h3>${cat.name}</h3>
                    <p>${cat.description}</p>
                    <span class="view-link">View Projects →</span>
                </a>
            </c:forEach>
        </div>
    </div>

    <%@ include file="common/footer.jsp" %>

</body>
</html>