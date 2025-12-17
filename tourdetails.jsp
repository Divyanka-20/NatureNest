<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String tourName = request.getParameter("tourName");
    String destination = "", area = "", price = "", description = "", duration = "", difficulty_level = "", guide_name = "", formattedDuration = "";

    if (tourName != null && !tourName.trim().equals("")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");

            PreparedStatement ps = con.prepareStatement("SELECT location, area, price, description, duration, difficulty_level, guide_name FROM tours WHERE tour_name = ?");
            ps.setString(1, tourName);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                destination = rs.getString("location");
                area = rs.getString("area"); // fixed the undeclared variable
                price = rs.getString("price");
                description = rs.getString("description");
                duration = rs.getString("duration");
                difficulty_level = rs.getString("difficulty_level");
                guide_name = rs.getString("guide_name");

                if (duration != null && duration.contains("/")) {
                    String[] parts = duration.split("/");
                    if (parts.length == 2) {
                        formattedDuration = parts[0] + " Days / " + parts[1] + " Nights";
                    } else {
                        formattedDuration = duration;
                    }
                } else {
                    formattedDuration = duration;
                }
            }

            con.close();
        } catch (Exception e) {
            out.println("Error fetching tour details: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="tours.css">
    <style>
        .tour-box {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            border: 2px solid #2a5d3d;
            border-radius: 10px;
            background-color: #f2fdf5;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .tour-box h3 {
            color: #1e4d2b;
            margin-bottom: 15px;
        }
        .tour-box p {
            font-size: 16px;
            margin: 8px 0;
            line-height: 1.6;
        }
        .btn {
            background-color: #2e7d32;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 15px;
        }
        .btn:hover {
            background-color: #1b5e20;
        }
    </style>
</head>
<body>
    <nav>
        <div class="logo-container">
            <img src="logo.jpg" alt="Logo">
            <div class="site-info">
                <div class="site-name">www.wildlifeindia.com</div>
                <div class="tagline">Explore India’s Wildlife Tours</div>
            </div>
        </div>
        <ul>
            <li><a href="explore.jsp">Home</a></li>
            <li><a href="#">About</a></li>
            <li><a href="#">Contact</a></li>
        </ul>
    </nav>

    <div class="content">
        <% if (tourName != null && !tourName.trim().equals("")) { %>
            <div class="tour-box">
                <h3 style="text-align:center;"><%= tourName %> - Tour Details</h3><br>
                <p><strong>Destination:</strong> <%= destination %></p>
                <p><strong>Location of Destination:</strong> <%= area %></p>
                <p><strong>Description:</strong> <%= description %></p>
                <p><strong>Price per Person:</strong> ₹<%= price %> per Person</p>
                <p><strong>Duration:</strong> <%= formattedDuration %></p>
                <p><strong>Difficulty Level:</strong> <%= difficulty_level %></p>
                <p><strong>Local Guide Name:</strong> <%= guide_name %></p>

                <div style="text-align: center; margin-top: 20px;">
                    <form action="bookTour.jsp" method="GET">
                        <input type="hidden" name="tourName" value="<%= tourName %>" />
                        <button type="submit" class="btn">Book Now</button>
                    </form>
                </div>

            </div>
        <% } else { %>
            <p style="color:red; text-align:center;">No tour selected.</p>
        <% } %>
    </div>
</body>
</html>
