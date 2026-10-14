<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bids — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .bid-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 16px;
            transition: all 0.2s;
        }
        .bid-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }
        .bid-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }
        .bid-title {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 6px;
        }
        .bid-category {
            font-size: 12px;
            color: #64748b;
        }
        .bid-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            padding: 16px 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
            margin: 16px 0;
        }
        .bid-detail-item .label {
            font-size: 11px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 4px;
        }
        .bid-detail-item .value {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }
        .bid-detail-item .value.amount { color: #10b981; }

        .bid-proposal {
            font-size: 14px;
            color: #475569;
            line-height: 1.6;
            margin-top: 12px;
        }

        .badge-pending { background: #fef3c7; color: #92400e; }
        .badge-accepted { background: #dcfce7; color: #166534; }
        .badge-rejected { background: #fee2e2; color: #b91c1c; }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <section class="section">
        <div class="container">
            <div class="dashboard-header">
                <div>
                    <h1>My Bids</h1>
                    <p>All bids you have submitted</p>
                </div>
                <a href="/projects" class="btn btn-primary btn-lg">
                    Browse More Projects
                </a>
            </div>

            <%-- Success message --%>
            <c:if test="${param.success == 'true'}">
                <div class="alert alert-success" style="margin-bottom: 24px;">
                    ✓ Your bid has been submitted successfully! The client will review it soon.
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty bids}">
                    <div class="empty-state">
                        <div style="font-size: 60px; margin-bottom: 16px;">📬</div>
                        <h3>No bids yet</h3>
                        <p>You haven't submitted any bids. Start by browsing projects!</p>
                        <a href="/projects" class="btn btn-primary btn-lg">Browse Projects</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="bid" items="${bids}">
                        <div class="bid-card">
                            <div class="bid-header">
                                <div>
                                    <div class="bid-title">${bid.project.title}</div>
                                    <div class="bid-category">
                                        <c:if test="${bid.project.category != null}">
                                            ${bid.project.category.image} ${bid.project.category.name}
                                        </c:if>
                                        • Project Budget: ₹<fmt:formatNumber value="${bid.project.budget}" type="number" maxFractionDigits="0" />
                                    </div>
                                </div>
                                <span class="badge badge-${bid.status == 'PENDING' ? 'pending' : (bid.status == 'ACCEPTED' ? 'accepted' : 'rejected')}">
                                    ${bid.status}
                                </span>
                            </div>

                            <div class="bid-details">
                                <div class="bid-detail-item">
                                    <div class="label">Your Bid</div>
                                    <div class="value amount">₹<fmt:formatNumber value="${bid.amount}" type="number" maxFractionDigits="0" /></div>
                                </div>
                                <div class="bid-detail-item">
                                    <div class="label">Delivery</div>
                                    <div class="value">${bid.deliveryDays} days</div>
                                </div>
                                <div class="bid-detail-item">
                                    <div class="label">Submitted</div>
                                    <div class="value" style="font-size:14px;">${bid.createdAt.toLocalDate()}</div>
                                </div>
                            </div>

                            <div class="bid-proposal">
                                <strong>Your Proposal:</strong> ${bid.proposal}
                            </div>

                            <div style="margin-top: 16px;">
                                <a href="/projects/${bid.project.id}" class="btn btn-outline">View Project</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>