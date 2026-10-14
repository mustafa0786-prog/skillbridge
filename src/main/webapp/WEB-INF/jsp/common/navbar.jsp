<nav class="navbar">
    <div class="navbar-container">
        <a href="/" class="navbar-logo">
            <div class="logo-icon">SB</div>
            <span>SkillBridge</span>
        </a>

        <ul class="navbar-links">
            <li><a href="/">Home</a></li>
            <li><a href="/projects">Find Projects</a></li>
            <li><a href="/freelancers">Find Freelancers</a></li>
            <li><a href="/categories">Categories</a></li>
            <li><a href="/about">About</a></li>
        </ul>

        <div class="navbar-actions">
            <% if (session.getAttribute("userId") == null) { %>
                <%-- Guest user --%>
                <a href="/login" class="btn btn-outline">Login</a>
                <a href="/register" class="btn btn-primary">Join Now</a>
            <% } else { %>
                <%-- Logged in user --%>
                <% String role = (String) session.getAttribute("userRole"); %>
                <% if ("CLIENT".equals(role)) { %>
                    <a href="/client/dashboard" class="btn btn-outline">Dashboard</a>
                <% } else if ("FREELANCER".equals(role)) { %>
                    <a href="/freelancer/dashboard" class="btn btn-outline">Dashboard</a>
                <% } else if ("ADMIN".equals(role)) { %>
                    <a href="/admin/dashboard" class="btn btn-outline">Admin</a>
                <% } %>

                <a href="/messages" class="btn btn-outline"> Inbox</a>

                <span class="navbar-user-name">
                     ${sessionScope.userName}
                </span>

                <a href="/logout" class="btn btn-primary">Logout</a>
            <% } %>
        </div>
    </div>
</nav>