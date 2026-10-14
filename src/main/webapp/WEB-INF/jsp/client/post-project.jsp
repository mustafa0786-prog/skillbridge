<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Post Project — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/auth.css">
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="auth-section">
        <div class="auth-card" style="max-width: 700px;">
            <div class="auth-header">
                <h1>Post a New Project</h1>
                <p>Describe your project and start receiving bids from freelancers</p>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="/client/post-project" method="post" class="auth-form">

                <div class="form-group">
                    <label for="title">Project Title</label>
                    <input type="text" id="title" name="title"
                           placeholder="e.g., Build a Responsive Java Website"
                           required maxlength="200">
                </div>

                <div class="form-group">
                    <label for="description">Project Description</label>
                    <textarea id="description" name="description"
                              placeholder="Describe your project in detail..."
                              required rows="6"
                              style="padding: 12px 16px; border: 1.5px solid #e2e8f0; border-radius: 10px; font-family: inherit; font-size: 15px; resize: vertical;"></textarea>
                </div>

                <div class="form-group">
                    <label for="categoryId">Category</label>
                    <select id="categoryId" name="categoryId" required
                            style="padding: 12px 16px; border: 1.5px solid #e2e8f0; border-radius: 10px; font-size: 15px; background: white; font-family: inherit;">
                        <option value="">-- Select Category --</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.id}">${cat.image} ${cat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                    <div class="form-group">
                        <label for="budget">Budget (₹)</label>
                        <input type="number" id="budget" name="budget"
                               placeholder="15000" required min="100" step="100">
                    </div>

                    <div class="form-group">
                        <label for="deadline">Deadline</label>
                        <input type="date" id="deadline" name="deadline" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">
                    Post Project
                </button>

                <p class="auth-footer-text">
                    <a href="/client/dashboard">← Back to Dashboard</a>
                </p>
            </form>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>

    <script>
        // Deadline minimum today se 1 din aage
        const today = new Date();
        today.setDate(today.getDate() + 1);
        document.getElementById('deadline').min = today.toISOString().split('T')[0];
    </script>
</body>
</html>