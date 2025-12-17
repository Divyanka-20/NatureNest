<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.net.URLEncoder" %> <!-- Import URLEncoder -->
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="forgetpass.css">
    <title>Forgot Password</title>
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
        <h2>Forgot Password</h2>
        <form method="post">
            <%
                String mail = request.getParameter("email");
                boolean emailValid = false;

                // Check if email was submitted and fetch the security question
                if (mail != null && !mail.isEmpty()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
                        String query = "SELECT COUNT(*) FROM signup WHERE email = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, mail);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next() && rs.getInt(1) > 0) {
                            emailValid = true;
                        }
                        rs.close();
                        pstmt.close();
                        con.close();

                        if (emailValid) {
                            // Redirect to question.jsp with the email parameter
                            response.sendRedirect("question.jsp?email=" + URLEncoder.encode(mail, "UTF-8"));
                            return; // Ensure no further code is executed
                        } else {
                            out.println("<p style='color:red;'>Email not found. Please try again.</p>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>

            <!-- Email Form -->
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Submit</button>
        </form>
    </div>
</body>
</html>
