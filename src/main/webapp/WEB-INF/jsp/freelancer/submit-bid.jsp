<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Bid — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/auth.css">
    <style>
        .project-preview {
            background: #f8fafc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 24px;
            border: 1px solid #e2e8f0;
        }
        .project-preview h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .project-preview p {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 12px;
        }
        .preview-meta {
            display: flex;
            gap: 24px;
            font-size: 13px;
        }
        .preview-meta span {
            color: #64748b;
        }
        .preview-meta strong {
            color: #0f172a;
        }
        .preview-meta .budget {
            color: #10b981;
        }
    </style>
</head>
<body>
    <%@ include file="../common/navbar.jsp" %>

    <section class="auth-section">
        <div class="auth-card" style="max-width: 700px;">
            <div class="auth-header">
                <h1>Submit Your Bid</h1>
                <p>Send your proposal to the client</p>
            </div>

            <%-- Project preview --%>
            <div class="project-preview">
                <h3>${project.title}</h3>
                <p>${project.description.length() > 150 ? project.description.substring(0, 150).concat('...') : project.description}</p>
                <div class="preview-meta">
                    <span>Budget: <strong class="budget">₹<fmt:formatNumber value="${project.budget}" type="number" maxFractionDigits="0" /></strong></span>
                    <span>Deadline: <strong>${project.deadline}</strong></span>
                </div>
            </div>

            <%-- Error message --%>
            <c:if test="${errorMessage != null}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <form action="/freelancer/submit-bid/${project.id}" method="post" class="auth-form">

                <div class="form-group">
                    <label for="amount">Your Bid Amount (₹)</label>
                    <input type="number" id="amount" name="amount"
                           placeholder="e.g., 12000" required min="1" step="100">
                    <small style="color:#64748b; font-size:13px; margin-top:4px;">
                        Client's budget: ₹<fmt:formatNumber value="${project.budget}" type="number" maxFractionDigits="0" />
                    </small>
                </div>

                <div class="form-group">
                    <label for="deliveryDays">Delivery Time (Days)</label>
                    <input type="number" id="deliveryDays" name="deliveryDays"
                           placeholder="e.g., 10" required min="1" max="365">
                </div>

                <div class="form-group">
                    <label for="proposal">Your Proposal</label>
                    <textarea id="proposal" name="proposal"
                              placeholder="Explain why you are the best fit for this project. Mention your relevant experience and approach..."
                              required rows="6" minlength="20"
                              style="padding: 12px 16px; border: 1.5px solid #e2e8f0; border-radius: 10px; font-family: inherit; font-size: 15px; resize: vertical;"></textarea>
                    <small style="color:#64748b; font-size:13px; margin-top:4px;">
                        Minimum 20 characters. Be specific about your approach.
                    </small>
                </div>

                <button type="submit" class="btn btn-primary btn-lg btn-full">
                    Submit Bid
                </button>

                <p class="auth-footer-text">
                    <a href="/projects/${project.id}">← Back to Project</a>
                </p>
            </form>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>