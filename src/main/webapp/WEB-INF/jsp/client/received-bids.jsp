<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Received Bids — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .bid-item {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 16px;
        }
        .bid-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }
        .freelancer-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .freelancer-avatar-sm {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
        }
        .freelancer-info h4 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }
        .freelancer-info p {
            font-size: 13px;
            color: #64748b;
        }
        .bid-stats {
            display: flex;
            gap: 24px;
            padding: 16px 0;
            border-top: 1px solid #e2e8f0;
            border-bottom: 1px solid #e2e8f0;
            margin: 16px 0;
        }
        .bid-stat .label {
            font-size: 11px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 2px;
        }
        .bid-stat .value {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
        }
        .bid-stat .value.amount { color: #10b981; }
        .proposal-text {
            font-size: 14px;
            color: #475569;
            line-height: 1.6;
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
            <a href="/client/my-projects" style="color:#2563eb; font-weight:600; font-size:14px; display:inline-block; margin-bottom:16px;">
                ← Back to My Projects
            </a>

            <div class="dashboard-header">
                <div>
                    <h1>Received Bids</h1>
                    <p>Bids for: <strong>${project.title}</strong></p>
                    <p style="font-size:14px; color:#64748b; margin-top:4px;">
                        Total Bids: <strong>${bids.size()}</strong>
                    </p>
                </div>
            </div>
            
            <%-- Actions based on project status --%>
<div style="margin-top: 32px; padding: 24px; background: white; border-radius: 12px; border: 1px solid #e2e8f0;">
    <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 12px;">
        Project Actions
    </h3>

    <c:choose>
        <%-- Project is IN_PROGRESS --%>
        <c:when test="${project.status == 'IN_PROGRESS'}">
            <p style="color:#64748b; margin-bottom: 16px;">
                Work is in progress. Once the freelancer completes the work, mark this project as completed.
            </p>
            <form action="/client/project/${project.id}/complete" method="post">
                <button type="submit" class="btn btn-primary btn-lg"
                        onclick="return confirm('Mark this project as COMPLETED? This will allow you to leave a review.');">
                    ✓ Mark as Completed
                </button>
            </form>
        </c:when>

        <%-- Project is COMPLETED --%>
        <c:when test="${project.status == 'COMPLETED'}">
            <p style="color:#10b981; font-weight: 600; margin-bottom: 16px;">
                ✓ Project completed!
            </p>
            <a href="/client/project/${project.id}/review" class="btn btn-primary btn-lg">
                ⭐ Give Review
            </a>
        </c:when>

        <%-- Project is OPEN --%>
        <c:when test="${project.status == 'OPEN'}">
            <p style="color:#64748b;">
                Waiting for you to accept a bid.
            </p>
        </c:when>
    </c:choose>
</div>
               <%-- Success / Error messages --%>
      
             <c:if test="${param.completed == 'true'}">
    <div class="alert alert-success" style="margin-bottom: 24px;">
        ✓ Project marked as COMPLETED! You can now leave a review for the freelancer.
    </div>
</c:if>

<c:if test="${param.reviewed == 'true'}">
    <div class="alert alert-success" style="margin-bottom: 24px;">
        ✓ Thank you! Your review has been submitted successfully.
    </div>
</c:if>

<c:if test="${param.alreadyReviewed == 'true'}">
    <div class="alert alert-error" style="margin-bottom: 24px;">
        You have already reviewed this project.
    </div>
</c:if>

<c:if test="${param.accepted == 'true'}">
    <div class="alert alert-success" style="margin-bottom: 24px;">
        ✓ Bid accepted! Project is now IN PROGRESS. Other bids have been rejected automatically.
    </div>
</c:if>

<c:if test="${param.rejected == 'true'}">
    <div class="alert alert-success" style="margin-bottom: 24px;">
        ✓ Bid rejected successfully.
    </div>
</c:if>

            <c:choose>
                <c:when test="${empty bids}">
                    <div class="empty-state">
                        <div style="font-size: 60px; margin-bottom: 16px;">📭</div>
                        <h3>No bids yet</h3>
                        <p>No freelancers have bid on this project yet. They will see it soon!</p>
                        <a href="/client/my-projects" class="btn btn-primary btn-lg">Back to Projects</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="bid" items="${bids}">
                        <div class="bid-item">
                            <div class="bid-item-header">
                                <div class="freelancer-info">
                                    <div class="freelancer-avatar-sm">
                                        ${bid.freelancer.name.substring(0,1).toUpperCase()}
                                    </div>
                                    <div>
                                        <h4>${bid.freelancer.name}</h4>
                                        <p>${bid.freelancer.email}</p>
                                    </div>
                                </div>
                                <span class="badge badge-${bid.status == 'PENDING' ? 'pending' : (bid.status == 'ACCEPTED' ? 'accepted' : 'rejected')}">
                                    ${bid.status}
                                </span>
                            </div>

                            <div class="bid-stats">
                                <div class="bid-stat">
                                    <div class="label">Bid Amount</div>
                                    <div class="value amount">₹<fmt:formatNumber value="${bid.amount}" type="number" maxFractionDigits="0" /></div>
                                </div>
                                <div class="bid-stat">
                                    <div class="label">Delivery</div>
                                    <div class="value">${bid.deliveryDays} days</div>
                                </div>
                                <div class="bid-stat">
                                    <div class="label">Submitted</div>
                                    <div class="value" style="font-size:14px;">${bid.createdAt.toLocalDate()}</div>
                                </div>
                            </div>

                            <div class="proposal-text">
                                <strong>Proposal:</strong><br>
                                ${bid.proposal}
                            </div>

                            <div style="margin-top: 20px; display:flex; gap:12px; flex-wrap:wrap;">
                                <c:if test="${bid.status == 'PENDING' && project.status == 'OPEN'}">
    <form action="/client/bid/${bid.id}/accept" method="post" style="display:inline;">
        <button type="submit" class="btn btn-primary" 
                onclick="return confirm('Accept this bid? All other bids will be rejected and the project will move to IN PROGRESS.');">
            ✓ Accept Bid
        </button>
    </form>
    <form action="/client/bid/${bid.id}/reject" method="post" style="display:inline;">
        <button type="submit" class="btn btn-outline" 
                onclick="return confirm('Reject this bid?');">
            ✗ Reject Bid
        </button>
    </form>
</c:if>


<c:if test="${bid.status == 'ACCEPTED'}">
    <div class="alert alert-success" style="margin-top:12px; width:100%;">
        ✓ You accepted this bid. Project is now <strong>IN PROGRESS</strong>.
    </div>
</c:if>
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