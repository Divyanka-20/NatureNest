<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bungalowName = request.getParameter("bungalowName");
    String location = "", forestName = "", price = "";
    double totalAmount = 0;

    if (bungalowName != null && !bungalowName.trim().equals("")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");

            // Fetch bungalow details
            PreparedStatement ps = con.prepareStatement("SELECT * FROM forestbungalow WHERE name = ?");
            ps.setString(1, bungalowName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                location = rs.getString("location");
                forestName = rs.getString("forest_name");
                price = rs.getString("price");
            }

            // Calculate the total amount
            String checkInDate = request.getParameter("checkInDate");
            String checkOutDate = request.getParameter("checkOutDate");
            if (checkInDate != null && checkOutDate != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("DD-MM-YYYY");
                long checkInMillis = sdf.parse(checkInDate).getTime();
                long checkOutMillis = sdf.parse(checkOutDate).getTime();
                int totalDays = (int) ((checkOutMillis - checkInMillis) / (1000 * 60 * 60 * 24));
                if (totalDays < 1) totalDays = 0;
                totalAmount = totalDays * Double.parseDouble(price);
            }

            con.close();
        } catch (Exception e) {
            out.println("Error fetching bungalow details: " + e.getMessage());
        }
    }

    // Insert booking details into the database
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            String name = request.getParameter("name");
            String contactNumber = request.getParameter("contactNumber");
            String address = request.getParameter("address");
            int numGuests = Integer.parseInt(request.getParameter("numGuests"));
            int totalDays = Integer.parseInt(request.getParameter("totalDays"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");

            String insertQuery = "INSERT INTO booking (bungalow_name, location, forest_name, name, contact_number, address, num_guests, check_in_date, check_out_date, total_days, price, total_amount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);
            ps.setString(1, bungalowName);
            ps.setString(2, location);
            ps.setString(3, forestName);
            ps.setString(4, name);
            ps.setString(5, contactNumber);
            ps.setString(6, address);
            ps.setInt(7, numGuests);
            ps.setString(8, request.getParameter("checkInDate"));
            ps.setString(9, request.getParameter("checkOutDate"));
            ps.setInt(10, totalDays);
            ps.setDouble(11, Double.parseDouble(price));
            ps.setDouble(12, totalAmount);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<p>Booking successful!</p>");
            } else {
                out.println("<p>Error occurred while booking.</p>");
            }

            con.close();
        } catch (Exception e) {
            out.println("Error inserting booking details: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Forest Bungalow</title>
    <link rel="stylesheet" href="bookBungalow.css">
    <script>
        function calculateDays() {
            const checkInDate = new Date(document.getElementById('checkInDate').value);
            const checkOutDate = new Date(document.getElementById('checkOutDate').value);

            if (!isNaN(checkInDate) && !isNaN(checkOutDate)) {
                const diffTime = checkOutDate.getTime() - checkInDate.getTime();
                const diffDays = diffTime / (1000 * 60 * 60 * 24); // No +1 here

                if (diffDays > 0) {
                    document.getElementById('totalDays').value = diffDays;
                } else {
                    document.getElementById('totalDays').value = '';
                    alert("Check-out date must be after check-in date.");
                }
            }
        }
    </script>
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
        <h2>Book Your Forest Bungalow</h2>

        <% if (!bungalowName.equals("")) { %>
            <div class="bungalow-details">
                <h3>Bungalow Details</h3>
                <p><strong>Name:</strong> <%= bungalowName %></p>
                <p><strong>Location:</strong> <%= location %></p>
                <p><strong>Forest Name:</strong> <%= forestName %></p>
                <p><strong>Price per Night:</strong> ₹<%= price %></p>
            </div>
        <% } else { %>
            <p style="color:red;">No bungalow selected.</p>
        <% } %>

        <form action="payment.jsp" method="POST">
            <input type="hidden" name="bungalowName" value="<%= bungalowName %>" />

            <div class="form-group">
                <label for="name">Your Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label for="contactNumber">Your Contact Number:</label>
                <input type="text" id="contactNumber" name="contactNumber" placeholder="Enter your contact number" required />
            </div>

            <div class="form-group">
                <label for="address">Your Address:</label>
                <textarea id="address" name="address" rows="3" placeholder="Enter your address" required></textarea>
            </div>

            <div class="form-group">
                <label for="numGuests">Number of Guests:</label>
                <input type="number" id="numGuests" name="numGuests" placeholder="Enter the number of guests visiting" min="1" required />
            </div>

            <div class="form-group">
                <label for="checkInDate">Check-in Date:</label>
                <input type="date" id="checkInDate" name="checkInDate" onchange="calculateDays()" required />
            </div>

            <div class="form-group">
                <label for="checkOutDate">Check-out Date:</label>
                <input type="date" id="checkOutDate" name="checkOutDate" onchange="calculateDays()" required />
            </div>

            <div class="form-group">
                <label for="totalDays">Total Nights:</label>
                <input type="text" id="totalDays" name="totalDays" readonly />
            </div>

            <button type="submit" class="btn">Book Now</button>
        </form>
    </div>
</body>
</html>
