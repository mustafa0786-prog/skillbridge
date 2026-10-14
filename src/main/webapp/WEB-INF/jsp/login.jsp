<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/auth.css">
</head>
<body>

    <%@ include file="common/navbar.jsp" %>

    <section class="auth-section">
        <div class="auth-card">
            <div class="auth-header">
                <h1>Welcome back</h1>
                <p>Login to your SkillBridge account</p>
            </div>

            <%-- Success message (from registration) --%>
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>

            <%-- Error message (from failed login) --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="/login" method="post" class="auth-form">

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" 
                           placeholder="you@example.com" required autofocus>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" 
                           placeholder="Your password" required>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">
                    Login
                </button>

                <p class="auth-footer-text">
                    Don't have an account? <a href="/register">Register here</a>
                </p>
            </form>
        </div>
    </section>

    <%@ include file="common/footer.jsp" %>

</body>
</html>