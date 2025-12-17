<%@ page session="true" %>
<%
    String userName = (String) session.getAttribute("user_name");
%>
<style>
    nav {
        background-color: rgba(0, 0, 0, 0.5);
        color: white;
        padding: 10px 20px;
        position: fixed;
        width: 100%;
        top: 0;
        left: 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        z-index: 999;
        font-family: Arial, sans-serif;
    }

    nav .logo-container {
        display: flex;
        align-items: center;
    }

    nav .logo-container a.logo-link {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: inherit;
    }

    nav .logo-container img {
        height: 50px;
        padding-right: 12px;
    }

    nav .site-info {
        display: flex;
        flex-direction: column;
    }

    nav .site-info .site-name {
        font-size: 20px;
        font-family: 'Times New Roman', Times, serif;
        font-weight: bold;
        color: white;
        text-decoration: none;
        margin-bottom: 2px
    }

    nav .site-info .tagline {
        font-size: 13px;
        font-weight: bold;
        font-family: 'Times New Roman', Times, serif;
        color: #eee;
        margin-top: 2px;
    }

    nav ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
        display: flex;
        margin-right: 30px;
        align-items: center;
    }

    nav ul li {
        margin: 0 8px;
        color: white;
        font-weight: normal;
        display: flex;
        align-items: center;
    }

    nav ul li.welcome-msg {
        font-weight: bold;
    }

    nav ul li a {
        color: white;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        display: block;
    }

    nav ul li a:hover {
        background-color: rgba(255, 255, 255, 0.3);
        border-radius: 4px;
    }
</style>

<nav>
    <div class="logo-container">
        <a href="index.html" class="logo-link" title="Home">
            <img src="logo.jpg" alt="Logo">
            <div class="site-info">
                <div class="site-name">NatureNest</div>
                <div class="tagline">Your gateway to wildlife wonders</div>
            </div>
        </a>
    </div>

    <ul>
        <%
            if (userName != null) {
        %>
            <li class="welcome-msg">Welcome, <%= userName %></li>
            <li><a href="logout.jsp">Logout</a></li>
        <%
            } else {
        %>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="login.jsp">Explore</a></li>
        <%
            }
        %>
        <li><a href="#services">Review</a></li>
        <li><a href="#contact">Contact Us</a></li>
    </ul>
</nav>
