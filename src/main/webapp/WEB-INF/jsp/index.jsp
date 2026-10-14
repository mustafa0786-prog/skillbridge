<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkillBridge — Find the Right Talent for Your Next Project</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>

    <%@ include file="common/navbar.jsp" %>

    <!-- ========== HERO SECTION ========== -->
    <section class="hero">
        <div class="hero-content">
            <div class="hero-badge">✨ Trusted by 10,000+ businesses worldwide</div>
            <h1>Find the right talent for your <span class="highlight">next project</span>.</h1>
            <p>Connect with skilled freelancers, discover exciting projects, and turn ideas into results.</p>

            <form class="hero-search" action="/projects" method="get">
                <input type="text" name="q" placeholder="Try 'Java developer', 'logo design', 'content writer'...">
                <button type="submit">Search</button>
            </form>

            <div class="hero-buttons">
                <a href="/freelancers" class="btn btn-white btn-lg">Find Freelancers</a>
                <a href="/post-project" class="btn btn-outline btn-lg" style="color:white; border-color:rgba(255,255,255,0.4);">Post a Project</a>
            </div>

            <div class="hero-stats">
                <div class="hero-stat">
                    <h3>10K+</h3>
                    <p>Active Freelancers</p>
                </div>
                <div class="hero-stat">
                    <h3>25K+</h3>
                    <p>Projects Completed</p>
                </div>
                <div class="hero-stat">
                    <h3>4.9★</h3>
                    <p>Average Rating</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ========== POPULAR CATEGORIES ========== -->
    <section class="section">
        <div class="container">
            <div class="section-header">
                <h2>Popular Categories</h2>
                <p>Explore projects and services across the most in-demand skills</p>
            </div>

            <div class="categories-grid">
                <div class="category-card">
                    <div class="category-icon">💻</div>
                    <h3>Web Development</h3>
                    <p>850+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">📱</div>
                    <h3>Mobile Development</h3>
                    <p>620+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">🎨</div>
                    <h3>Graphic Design</h3>
                    <p>1,200+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">✨</div>
                    <h3>UI/UX Design</h3>
                    <p>540+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">📊</div>
                    <h3>Digital Marketing</h3>
                    <p>780+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">✍️</div>
                    <h3>Content Writing</h3>
                    <p>950+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">🎬</div>
                    <h3>Video Editing</h3>
                    <p>410+ projects</p>
                </div>
                <div class="category-card">
                    <div class="category-icon">🧠</div>
                    <h3>Data Science</h3>
                    <p>320+ projects</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ========== FEATURED PROJECTS ========== -->
    <section class="section" style="background: white;">
        <div class="container">
            <div class="section-header">
                <h2>Featured Projects</h2>
                <p>Fresh opportunities posted by clients looking for talented freelancers</p>
            </div>

            <div class="projects-grid">
                <div class="project-card">
                    <div class="project-header">
                        <span class="project-category">Web Development</span>
                        <span class="badge badge-open">OPEN</span>
                    </div>
                    <h3>Build a Responsive E-Commerce Website</h3>
                    <p class="description">Looking for an experienced Java developer to build a modern e-commerce platform with payment integration.</p>
                    <div class="project-meta">
                        <div class="project-meta-item">
                            <span class="label">Budget</span>
                            <span class="value budget">₹15,000</span>
                        </div>
                        <div class="project-meta-item">
                            <span class="label">Deadline</span>
                            <span class="value">15 days</span>
                        </div>
                    </div>
                    <a href="/projects/1" class="btn btn-primary">View Project</a>
                </div>

                <div class="project-card">
                    <div class="project-header">
                        <span class="project-category">UI/UX Design</span>
                        <span class="badge badge-open">OPEN</span>
                    </div>
                    <h3>Mobile App UI Design for Fitness App</h3>
                    <p class="description">Need a creative designer to design a modern fitness tracking app with clean, minimal interface.</p>
                    <div class="project-meta">
                        <div class="project-meta-item">
                            <span class="label">Budget</span>
                            <span class="value budget">₹8,000</span>
                        </div>
                        <div class="project-meta-item">
                            <span class="label">Deadline</span>
                            <span class="value">7 days</span>
                        </div>
                    </div>
                    <a href="/projects/2" class="btn btn-primary">View Project</a>
                </div>

                <div class="project-card">
                    <div class="project-header">
                        <span class="project-category">Content Writing</span>
                        <span class="badge badge-open">OPEN</span>
                    </div>
                    <h3>SEO Blog Articles for Tech Startup</h3>
                    <p class="description">Seeking an experienced writer to create 10 high-quality SEO blog posts about AI and machine learning.</p>
                    <div class="project-meta">
                        <div class="project-meta-item">
                            <span class="label">Budget</span>
                            <span class="value budget">₹5,000</span>
                        </div>
                        <div class="project-meta-item">
                            <span class="label">Deadline</span>
                            <span class="value">10 days</span>
                        </div>
                    </div>
                    <a href="/projects/3" class="btn btn-primary">View Project</a>
                </div>
            </div>
        </div>
    </section>

    <!-- ========== TOP FREELANCERS ========== -->
    <section class="section">
        <div class="container">
            <div class="section-header">
                <h2>Top Freelancers</h2>
                <p>Meet our highly-rated professionals ready to bring your ideas to life</p>
            </div>

            <div class="freelancers-grid">
                <div class="freelancer-card">
                    <div class="freelancer-avatar">RS</div>
                    <h3>Rahul Sharma</h3>
                    <div class="freelancer-skills">
                        <span class="skill-tag">Java</span>
                        <span class="skill-tag">Spring Boot</span>
                        <span class="skill-tag">MySQL</span>
                    </div>
                    <div class="freelancer-rating">
                        <span class="stars">★★★★★</span>
                        <span class="rating-text">4.9 (127)</span>
                    </div>
                    <p class="freelancer-rate">Hourly Rate: <strong>₹800/hr</strong></p>
                    <a href="/freelancers/1" class="btn btn-outline">View Profile</a>
                </div>

                <div class="freelancer-card">
                    <div class="freelancer-avatar">PK</div>
                    <h3>Priya Kapoor</h3>
                    <div class="freelancer-skills">
                        <span class="skill-tag">UI/UX</span>
                        <span class="skill-tag">Figma</span>
                        <span class="skill-tag">Web Design</span>
                    </div>
                    <div class="freelancer-rating">
                        <span class="stars">★★★★★</span>
                        <span class="rating-text">5.0 (89)</span>
                    </div>
                    <p class="freelancer-rate">Hourly Rate: <strong>₹950/hr</strong></p>
                    <a href="/freelancers/2" class="btn btn-outline">View Profile</a>
                </div>

                <div class="freelancer-card">
                    <div class="freelancer-avatar">AM</div>
                    <h3>Amit Mehta</h3>
                    <div class="freelancer-skills">
                        <span class="skill-tag">React</span>
                        <span class="skill-tag">Node.js</span>
                        <span class="skill-tag">MongoDB</span>
                    </div>
                    <div class="freelancer-rating">
                        <span class="stars">★★★★☆</span>
                        <span class="rating-text">4.7 (156)</span>
                    </div>
                    <p class="freelancer-rate">Hourly Rate: <strong>₹700/hr</strong></p>
                    <a href="/freelancers/3" class="btn btn-outline">View Profile</a>
                </div>

                <div class="freelancer-card">
                    <div class="freelancer-avatar">SG</div>
                    <h3>Sneha Gupta</h3>
                    <div class="freelancer-skills">
                        <span class="skill-tag">Content</span>
                        <span class="skill-tag">SEO</span>
                        <span class="skill-tag">Copywriting</span>
                    </div>
                    <div class="freelancer-rating">
                        <span class="stars">★★★★★</span>
                        <span class="rating-text">4.8 (203)</span>
                    </div>
                    <p class="freelancer-rate">Hourly Rate: <strong>₹500/hr</strong></p>
                    <a href="/freelancers/4" class="btn btn-outline">View Profile</a>
                </div>
            </div>
        </div>
    </section>

    <!-- ========== HOW IT WORKS ========== -->
    <section class="section how-it-works">
        <div class="container">
            <div class="section-header">
                <h2>How It Works</h2>
                <p>Simple, transparent, and efficient — for both clients and freelancers</p>
            </div>

            <div class="steps-container">
                <div class="steps-column">
                    <h3>For Clients <span class="role-badge">Hire</span></h3>
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h4>Post a Project</h4>
                            <p>Describe your project, budget, and deadline in minutes.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h4>Receive Bids</h4>
                            <p>Get proposals from qualified freelancers around the world.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h4>Hire Freelancer</h4>
                            <p>Review profiles, ratings, and hire the best fit for your project.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">4</div>
                        <div class="step-content">
                            <h4>Complete Project</h4>
                            <p>Collaborate, review work, and pay only when satisfied.</p>
                        </div>
                    </div>
                </div>

                <div class="steps-column freelancer">
                    <h3>For Freelancers <span class="role-badge">Work</span></h3>
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h4>Create Profile</h4>
                            <p>Showcase your skills, experience, and portfolio.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h4>Find Projects</h4>
                            <p>Browse thousands of projects matching your skills.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h4>Submit Proposal</h4>
                            <p>Send personalized bids with your best offer.</p>
                        </div>
                    </div>
                    <div class="step-item">
                        <div class="step-number">4</div>
                        <div class="step-content">
                            <h4>Get Hired</h4>
                            <p>Win projects, deliver quality work, and grow your career.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ========== CTA SECTION ========== -->
    <section class="cta-section">
        <h2>Ready to turn your next idea into reality?</h2>
        <p>Join thousands of clients and freelancers already building together on SkillBridge.</p>
        <div class="cta-buttons">
            <a href="/freelancers" class="btn btn-white btn-lg">Find Talent</a>
            <a href="/projects" class="btn btn-outline btn-lg" style="color:white; border-color:rgba(255,255,255,0.4);">Find Projects</a>
        </div>
    </section>

    <%@ include file="common/footer.jsp" %>

</body>

</html>