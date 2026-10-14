<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .about-hero {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            color: white;
            padding: 80px 24px 60px;
            text-align: center;
        }
        .about-hero h1 {
            font-size: 44px;
            font-weight: 800;
            margin-bottom: 16px;
            letter-spacing: -1.5px;
        }
        .about-hero p {
            color: rgba(255,255,255,0.9);
            font-size: 18px;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }
        .about-container {
            max-width: 1000px;
            margin: 60px auto;
            padding: 0 24px;
        }
        .about-section {
            margin-bottom: 60px;
        }
        .about-section h2 {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 20px;
            letter-spacing: -0.5px;
        }
        .about-section p {
            font-size: 16px;
            color: #475569;
            line-height: 1.7;
            margin-bottom: 16px;
        }
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-top: 32px;
        }
        .value-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 28px 24px;
        }
        .value-icon {
            font-size: 36px;
            margin-bottom: 16px;
        }
        .value-card h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 8px;
        }
        .value-card p {
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
            margin: 0;
        }
        .stats-about {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 24px;
            background: #f8fafc;
            padding: 40px;
            border-radius: 16px;
            text-align: center;
            margin: 40px 0;
        }
        .stat-about h3 {
            font-size: 36px;
            font-weight: 800;
            color: #2563eb;
            margin-bottom: 4px;
        }
        .stat-about p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        .cta-about {
            text-align: center;
            padding: 40px 0;
        }
    </style>
</head>
<body>

    <%@ include file="common/navbar.jsp" %>

    <section class="about-hero">
        <h1>About SkillBridge</h1>
        <p>Connecting skilled freelancers with clients worldwide. We turn ideas into results.</p>
    </section>

    <div class="about-container">

        <div class="about-section">
            <h2>Our Story</h2>
            <p>
                SkillBridge was created with a simple vision — to make freelancing accessible, 
                transparent, and fair for everyone. Whether you're a client with a great idea 
                or a freelancer with exceptional skills, SkillBridge is the bridge that connects you both.
            </p>
            <p>
                We believe in the power of collaboration. Every project, every bid, every review — 
                is a step towards building a stronger community of creators and problem solvers.
            </p>
        </div>

        <div class="stats-about">
            <div class="stat-about">
                <h3>10K+</h3>
                <p>Active Freelancers</p>
            </div>
            <div class="stat-about">
                <h3>25K+</h3>
                <p>Projects Completed</p>
            </div>
            <div class="stat-about">
                <h3>4.9★</h3>
                <p>Average Rating</p>
            </div>
            <div class="stat-about">
                <h3>100+</h3>
                <p>Countries</p>
            </div>
        </div>

        <div class="about-section">
            <h2>Why Choose SkillBridge?</h2>
            <div class="values-grid">
                <div class="value-card">
                    <div class="value-icon">🎯</div>
                    <h3>Quality First</h3>
                    <p>Verified freelancers with ratings and reviews ensure you get the best talent.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">🔒</div>
                    <h3>Secure Platform</h3>
                    <p>Safe payments and protected communications for peace of mind.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">⚡</div>
                    <h3>Fast & Easy</h3>
                    <p>Post a project, receive bids, and hire talent in minutes.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon">🌍</div>
                    <h3>Global Reach</h3>
                    <p>Access talent from around the world, all in one place.</p>
                </div>
            </div>
        </div>

        <div class="about-section">
            <h2>Our Mission</h2>
            <p>
                To empower individuals and businesses to achieve their goals by providing a 
                trusted marketplace where skills meet opportunities. We're committed to 
                transparency, fairness, and excellence in everything we do.
            </p>
        </div>

        <div class="cta-about">
            <a href="/register" class="btn btn-primary btn-lg">Join SkillBridge Today</a>
            <a href="/projects" class="btn btn-outline btn-lg" style="margin-left: 12px;">Browse Projects</a>
        </div>

    </div>

    <%@ include file="common/footer.jsp" %>

</body>
</html>