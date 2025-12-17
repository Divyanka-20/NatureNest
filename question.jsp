<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.net.URLEncoder" %> <!-- Import URLEncoder -->
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="question.css">
    <title>Security Question</title>
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
        <h2>Security Question</h2>
        <form method="post">
            <%
                String email = request.getParameter("email");
                String securityQuestion = null;
                String storedAnswer = null;
                boolean answerValid = false;
                
                // Check if the form was submitted
                String securityAnswer = request.getParameter("securityAnswer");
                if (email != null && securityAnswer != null) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
                        String query = "SELECT squestion, sanswer FROM signup WHERE email = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, email);
                        ResultSet rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            securityQuestion = rs.getString("squestion");
                            storedAnswer = rs.getString("sanswer");
                            
                            if (securityAnswer.equals(storedAnswer)) {
                                answerValid = true;
                                // Redirect to update password page with email parameter
                                response.sendRedirect("updatepass.jsp?email=" + URLEncoder.encode(email, "UTF-8"));
                                return; // Ensure no further code is executed
                            } else {
                                out.println("<p style='color:red;'>Incorrect security answer. Please try again.</p>");
                            }
                        } else {
                            out.println("<p style='color:red;'>Email not found. Please try again.</p>");
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                // Display the security question form
                if (securityQuestion == null) {
                    // Fetch security question if not already fetched
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
                        String query = "SELECT squestion FROM signup WHERE email = ?";
                        PreparedStatement pstmt = con.prepareStatement(query);
                        pstmt.setString(1, email);
                        ResultSet rs = pstmt.executeQuery();

                        if (rs.next()) {
                            securityQuestion = rs.getString("squestion");
                        }
                        rs.close();
                        pstmt.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>

            <!-- Security Question Form -->
            <form method="post">
                <input type="hidden" name="email" value="<%= email %>">
                <label for="securityAnswer"><%= securityQuestion %>:</label>
                <input type="text" id="securityAnswer" name="securityAnswer" required>
                <button type="submit">Submit</button>
            </form>
        </div>
    </body>
</html>
