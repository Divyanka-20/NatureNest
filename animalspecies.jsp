<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Animal Species</title>
    <link rel="stylesheet" type="text/css" href="animalspecies.css">
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
            <li><a href="#">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </nav>

    <div class="content">
        <div class="summary">
            <h2>Animal Species</h2>
            <p>Explore information about various animal species and their categories.</p>
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
                    String sql = "SELECT name, category FROM animalspecies";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String category = rs.getString("category");

                        // Image path with animalspeciesimages folder
                        String baseName = name; // Replace spaces with underscores for the image file name
                        String imagePath = "animalspeciesimages/" + baseName + ".jpg";
                        File imageFile = new File(application.getRealPath("/") + imagePath);

                        // If .jpg doesn't exist, try .jpeg
                        if (!imageFile.exists()) {
                            imagePath = "animalspeciesimages/" + baseName + ".jpeg";
                            imageFile = new File(application.getRealPath("/") + imagePath);
                        }

                        // Fallback to default image if no image is found
                        if (!imageFile.exists()) {
                            imagePath = "animalspeciesimages/default.jpg";
                        }
            %>
                        <div class="grid-item">
                            <img src="<%= imagePath %>" alt="<%= name %>">
                            <p><strong><%= name %></strong></p>
                            <div class="info">
                                <p><strong>Category:</strong> <%= category %></p>
                            </div>
                        </div>
            <%
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException se) { se.printStackTrace(); }
                    try { if (stmt != null) stmt.close(); } catch (SQLException se) { se.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException se) { se.printStackTrace(); }
                }
            %>
        </div>
    </div>
</body>
</html>
