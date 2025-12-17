<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forest Bungalows</title>
    <link rel="stylesheet" type="text/css" href="forestbungalows.css">
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
            <li><a href="explore.jsp">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </nav>

    <div class="content">
        <div class="summary">
            <h2>Available Forest Bungalows</h2>
            <p>Explore the various forest bungalows available for your next wildlife adventure.</p>
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
                    String sql = "SELECT name, forest_name, price FROM forestbungalow";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String name = rs.getString("name");
                        String forest_name = rs.getString("forest_name");
                        String price = rs.getString("price");

                        // Use the endangeredspeciesimages folder
                        String baseImageName = name;
                        String imagePath = "forestbungalowimages/" + baseImageName + ".jpg";
                        File imageFile = new File(application.getRealPath("/") + imagePath);

                        if (!imageFile.exists()) {
                            imagePath = "forestbungalowimages/" + baseImageName + ".jpeg";
                            imageFile = new File(application.getRealPath("/") + imagePath);
                        }

                        if (!imageFile.exists()) {
                            imagePath = "forestbungalowimages/default.jpg";
                        }
            %>
                        <div class="grid-item">
                            <img src="<%= imagePath %>" alt="<%= name %>">
                            <p><strong><%= name %></strong></p>
                            
                            <div class="info">
                                <p><strong>Forest Name:</strong> <%= forest_name %></p>
                            </div>
                            
                            <div class="info">
                                <p><strong>Price per Night:</strong> <%= price %></p>
                            </div>

                            <!-- Book Now Button -->
                            <form action="bookBungalow.jsp" method="get">
                                <input type="hidden" name="bungalowName" value="<%= name %>">
                                <input type="hidden" name="forestName" value="<%= forest_name %>">
                                <input type="hidden" name="price" value="<%= price %>">
                                <button type="submit" class="book-now-btn">Book Now</button>
                            </form>
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
