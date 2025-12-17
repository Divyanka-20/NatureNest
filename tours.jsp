<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wildlife Tours</title>
    <link rel="stylesheet" type="text/css" href="tours.css">
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
            <h2>Available Wildlife Tours</h2>
            <p>Explore our guided wildlife tours for an unforgettable adventure in nature.</p>
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
                    String sql = "SELECT tour_name, location, duration, price FROM tours";
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        String tourName = rs.getString("tour_name");
                        String location = rs.getString("location");
                        String duration = rs.getString("duration");
                        String price = rs.getString("price");
                        
                        // Split duration into days and nights
                        String[] durationParts = duration.split("/");
                        String days = durationParts[0];
                        String nights = durationParts.length > 1 ? durationParts[1] : "";

                        // Use the tourimages folder
                        String baseImageName = tourName;
                        String imagePath = "tourimages/" + baseImageName + ".jpg";
                        File imageFile = new File(application.getRealPath("/") + imagePath);

                        if (!imageFile.exists()) {
                            imagePath = "tourimages/" + baseImageName + ".jpeg";
                            imageFile = new File(application.getRealPath("/") + imagePath);
                        }

                        if (!imageFile.exists()) {
                            imagePath = "tourimages/default.jpg";
                        }
            %>
                        <div class="grid-item">
                            <img src="<%= imagePath %>" alt="<%= tourName %>">
                            <p><strong><%= tourName %></strong></p>
                            
                            <div class="info">
                                <p><strong>Location:</strong> <%= location %></p>
                            </div>
                            
                            <div class="info">
                                <p><strong>Duration:</strong> <%= days %> Days / <%= nights %> Nights</p>
                            </div>
                            
                            <div class="info">
                                <p><strong>Price:</strong> ₹<%= price %> per Person</p>
                            </div>

                            <!-- Book Now Button -->
                            <form action="tourdetails.jsp" method="get">
                                <input type="hidden" name="tourName" value="<%= tourName %>">
                                <input type="hidden" name="location" value="<%= location %>">
                                <input type="hidden" name="duration" value="<%= duration %>">
                                <input type="hidden" name="price" value="<%= price %>">
                                <button type="submit" class="book-now-btn">View More Details</button>
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