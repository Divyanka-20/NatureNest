<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String bungalowName = request.getParameter("bungalowName");
    String name = request.getParameter("name");
    String contactNumber = request.getParameter("contactNumber");
    String address = request.getParameter("address");
    String numGuests = request.getParameter("numGuests");
    String checkInDate = request.getParameter("checkInDate");
    String checkOutDate = request.getParameter("checkOutDate");
    String totalDaysStr = request.getParameter("totalDays");

    String location = "", forestName = "", availability = "", price = "";
    double totalAmount = 0;

    if (bungalowName != null && !bungalowName.trim().equals("")) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife", "root", "divyanka123");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM forestbungalow WHERE name = ?");
            ps.setString(1, bungalowName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                location = rs.getString("location");
                forestName = rs.getString("forest_name");
                availability = rs.getString("availability");
                price = rs.getString("price");

                if (totalDaysStr != null && !totalDaysStr.equals("")) {
                    int totalDays = Integer.parseInt(totalDaysStr);
                    totalAmount = totalDays * Double.parseDouble(price);
                }
            }
            con.close();
        } catch (Exception e) {
            out.println("Error fetching bungalow details: " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Page</title>
    <link rel="stylesheet" href="payment.css">
</head>
<body>
    <div class="container">
        <h2>Confirm Your Booking and Proceed to Payment</h2>
        
        <h3>Bungalow Details</h3>
        <p><strong>Name:</strong> <%= bungalowName %></p>
        <p><strong>Location:</strong> <%= location %></p>
        <p><strong>Forest Name:</strong> <%= forestName %></p>
        <p><strong>Price per Night:</strong> ₹<%= price %></p>
        
        <h3>Your Details</h3>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Contact:</strong> <%= contactNumber %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>Number of Guests:</strong> <%= numGuests %></p>
        <p><strong>Check-in Date:</strong> <%= checkInDate %></p>
        <p><strong>Check-out Date:</strong> <%= checkOutDate %></p>
        <p><strong>Total Nights:</strong> <%= totalDaysStr %></p>
        
        <h3>Total Amount Payable: ₹<%= String.format("%.2f", totalAmount) %></h3>

        <!-- Payment Options as Buttons with Anchor Tags -->
        <form action="success.jsp" method="post">
            <input type="hidden" name="totalAmount" value="<%= totalAmount %>">
            <!-- Button for UPI Payment -->
            <button type="button" onclick="window.location.href='upi.jsp?totalAmount=<%= totalAmount %>&bungalowName=<%= bungalowName %>&name=<%= name %>&contactNumber=<%= contactNumber %>&address=<%= address %>&numGuests=<%= numGuests %>&checkInDate=<%= checkInDate %>&checkOutDate=<%= checkOutDate %>&totalDays=<%= totalDaysStr %>'">
                Pay with UPI
            </button>
            <!-- Button for Card Payment -->
            <button type="button" onclick="window.location.href='cardpay.jsp?totalAmount=<%= totalAmount %>&bungalowName=<%= bungalowName %>&name=<%= name %>&contactNumber=<%= contactNumber %>&address=<%= address %>&numGuests=<%= numGuests %>&checkInDate=<%= checkInDate %>&checkOutDate=<%= checkOutDate %>&totalDays=<%= totalDaysStr %>'">
                Pay with Card
            </button>
        </form>
    </div>
</body>
</html>
