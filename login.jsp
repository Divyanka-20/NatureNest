<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String loginError = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String mail = request.getParameter("email");
        String pass = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
            String sql = "SELECT * FROM signup WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, mail);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                session.setAttribute("user_name", rs.getString("name"));
                response.sendRedirect("explore.jsp");
                return;
            } else {
                loginError = "Invalid email or password!";
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            loginError = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login Page</title>

    <style>
        body {
            background-image: url('back.jpg');
            background-size: cover;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        nav {
            background-color: rgba(0, 0, 0, 0.5); /* Transparent light black */
            color: white;
            padding: 10px 20px;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            display: flex;
            justify-content: space-between; /* Aligns items to the edges */
            align-items: center;
            z-index: 999;
        }

        nav .logo-container {
            display: flex;
            align-items: center;
        }

        nav .logo-container img {
            height: 40px;
            padding-right: 20px;
        }

        nav .site-info {
            display: flex;
            flex-direction: column;
        }

        nav .site-info .site-name {
            font-size: 16px;
            font-weight: bold;
        }

        nav .site-info .tagline {
            font-size: 12px;
            color: #ccc;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        nav ul li {
            margin: 0;
        }

        nav ul li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        nav ul li a:hover {
            background-color: rgba(255, 255, 255, 0.3);
        }

        .login-container {
            max-width: 400px;
            margin: 120px auto 40px; /* margin-top increased for fixed navbar */
            padding: 20px;
            background-color: rgba(0, 0, 0, 0.7); /* Transparent black background */
            color: white; /* Ensures text is readable on dark background */
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .login-container form {
            display: flex;
            flex-direction: column;
        }

        .login-container label {
            margin-bottom: 5px;
            font-weight: bold;
        }

        .login-container input[type="email"],
        .login-container input[type="password"] {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #555; /* Darker border for better contrast */
            border-radius: 4px;
            font-size: 16px;
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent white background for inputs */
        }

        .login-container button {
            padding: 10px;
            background-color: #007BFF;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .login-container button:hover {
            background-color: #0056b3;
        }

        .links {
            text-align: center;
            margin-top: 20px;
        }

        .links a {
            color: #007BFF;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff6b6b;
            margin-top: 10px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <%@ include file="navbar.jsp" %>

    <div class="login-container">
        <h2>Login</h2>
        <form method="post" action="login.jsp">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required />

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required />

            <button type="submit">Login</button>
        </form>

        <% if (loginError != null) { %>
            <div class="error-message"><%= loginError %></div>
        <% } %>

        <div class="links">
            <a href="signup.jsp">New User</a> |
            <a href="forgetpass.jsp">Forgot Password?</a>
        </div>
    </div>

</body>
</html>
