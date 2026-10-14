<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/auth.css">
</head>
<body>

    <%@ include file="common/navbar.jsp" %>

    <section class="auth-section">
        <div class="auth-card">
            <div class="auth-header">
                <h1>Create your account</h1>
                <p>Join thousands of clients and freelancers on SkillBridge</p>
            </div>

            <%-- Error message --%>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="/register" method="post" class="auth-form" id="registerForm">

                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" required>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="+91 9876543210" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password"
                           placeholder="Minimum 6 characters" minlength="6" required>
                </div>

                <div class="form-group">
                    <label>I want to join as</label>
                    <div class="role-selector">
                        <label class="role-option">
                            <input type="radio" name="role" value="CLIENT" checked>
                            <span class="role-box">
                                <strong>Client</strong>
                                <small>I want to hire freelancers</small>
                            </span>
                        </label>
                        <label class="role-option">
                            <input type="radio" name="role" value="FREELANCER">
                            <span class="role-box">
                                <strong>Freelancer</strong>
                                <small>I want to offer services</small>
                            </span>
                        </label>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">
                    Create Account
                </button>

                <p class="auth-footer-text">
                    Already have an account? <a href="/login">Login here</a>
                </p>
            </form>
        </div>
    </section>

    <%@ include file="common/footer.jsp" %>

</body>
</html>