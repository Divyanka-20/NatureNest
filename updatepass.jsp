<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="updatepass.css">
    <title>Update Password</title>
</head>
<body>
    <nav>
        <div class="logo-container">
            <img src="logo.jpg" alt="Logo">
            <div class="site-info">
                <div class="site-name">www.wildlifeindia.com</div>
                <div class="tagline">Discover and Protect Wildlife</div>
            </div>
        </div>
        <ul>
            <li><a href="index.html">Home</a></li>
            <li><a href="#services">Review</a></li>
            <li><a href="#contact">Contact Us</a></li>
        </ul>
    </nav>

    <div class="login-container">
        <h2>Update Password</h2>
        <form method="post">
            <%
                String email = request.getParameter("email");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");

                if (newPassword != null && confirmPassword != null) {
                    if (newPassword.equals(confirmPassword)) {
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
                            String updateQuery = "UPDATE signup SET password = ? WHERE email = ?";
                            PreparedStatement pstmt = con.prepareStatement(updateQuery);
                            pstmt.setString(1, newPassword);
                            pstmt.setString(2, email);
                            int rowsAffected = pstmt.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p style='color:green;'>Password updated successfully!</p>");
                                response.sendRedirect("login.jsp");
                            } else {
                                out.println("<p style='color:red;'>Failed to update password. Please try again.</p>");
                            }
                            pstmt.close();
                            con.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else {
                        out.println("<p style='color:red;'>Passwords do not match. Please try again.</p>");
                    }
                }
            %>

            <!-- Update Password Form -->
            <form method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required>
                <label for="confirmPassword">Confirm New Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
                <button type="submit">Update Password</button>
            </form>
        </div>
    </body>
</html>
