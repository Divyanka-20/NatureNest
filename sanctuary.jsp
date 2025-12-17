<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sanctuaries</title>
    <link rel="stylesheet" type="text/css" href="sanctuary.css">
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
            <li><a href=explore.jsp>Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </nav>

    <div class="content">
        <div class="summary">
            <h2>Wildlife Sanctuaries</h2>
            <p>Explore the information about various wildlife sanctuaries, their locations, and areas covered.</p>
        </div>

        <div class="grid-container">
            <%
                String url = "jdbc:mysql://localhost:3306/wildlife";
                String user = "root";
                String password = "divyanka123";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);
                    stmt = conn.createStatement();
                    String sql = "SELECT name, state FROM sanctuary";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String state = rs.getString("state");
                        

                        String baseName = name;
                        String imagePath = "sanctuaryimages/" + baseName + ".jpg";
                        File imageFile = new File(application.getRealPath("/") + imagePath);

                        if (!imageFile.exists()) {
                            imagePath = "sanctuaryimages/" + baseName + ".jpeg";
                            imageFile = new File(application.getRealPath("/") + imagePath);
                        }

                        if (!imageFile.exists()) {
                            imagePath = "sanctuaryimages/default.jpg";
                        }
            %>
                        <div class="grid-item">
                            <img src="<%= imagePath %>" alt="<%= name %>">
                            <p><strong><%= name %></strong></p>
                            <div class="info">
                                <p><strong>State:</strong> <%= state %></p>
                                
                            </div>
                        </div>
            <%
                    }
                } catch (SQLException se) {
                    out.println("<p>Error: " + se.getMessage() + "</p>");
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException se) {}
                    try { if (stmt != null) stmt.close(); } catch (SQLException se) {}
                    try { if (conn != null) conn.close(); } catch (SQLException se) {}
                }
            %>
        </div>
    </div>
</body>
</html>
