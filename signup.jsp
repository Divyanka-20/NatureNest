<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="signup.css">
        <title>Sign Up Page</title>
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
            <h2>Sign Up</h2>
            <form method="post">
                <label for="em">Email:</label>
                <input type="text" id="em" name="em" required>
                
                <label for="nm">Name:</label>
                <input type="text" id="nm" name="nm" required>
                
                <label for="ad">Address:</label>
                <input type="text" id="ad" name="ad" required>
                
                <label for="ct">City:</label>
                <input type="text" id="ct" name="ct" required>
                
                <label for="pn">Pincode:</label>
                <input type="text" id="pn" name="pn" required>
                
                <label for="cn">Contact:</label>
                <input type="text" id="cn" name="cn" required>
                
                <label for="pass">Password:</label>
                <input type="password" id="pass" name="pass" required>
                
                <!-- Security Question Dropdown -->
                <label for="secQ">Security Question:</label>
                <select id="secQ" name="secQ" required>
                    <option value="" disabled selected>Select a question</option>
                    <option value="Your Pet Name">What is the name of your first pet?</option>
                    <option value="Your Mother Maiden">What is your mother's maiden name?</option>
                    <option value="Your Birth City">What city were you born in?</option>
                </select>

                <!-- Security Answer Field -->
                <label for="secA">Security Answer:</label>
                <input type="text" id="secA" name="secA" required>
                
                <button type="submit">Signup</button>
            </form>
            <%
                String mail=request.getParameter("em");
                String name=request.getParameter("nm");
                String addr=request.getParameter("ad");
                String city=request.getParameter("ct");
                String pinc=request.getParameter("pn");
                String cont=request.getParameter("cn");
                String passw=request.getParameter("pass");
                String sq=request.getParameter("secQ");
                String sa=request.getParameter("secA");
                try
                {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife","root","divyanka123");
                String ins="insert into signup(email,name,address,city,pincode,contact,password,squestion,sanswer) values(?,?,?,?,?,?,?,?,?)";
                PreparedStatement p=con.prepareStatement(ins);
                p.setString(1, mail);
                p.setString(2, name);
                p.setString(3, addr);
                p.setString(4, city);
                long pin=Long.parseLong(pinc);
                p.setLong(5, pin);
                long conta=Long.parseLong(cont);
                p.setLong(6, conta);
                p.setString(7,passw);
                p.setString(8, sq);
                p.setString(9,sa);
                int r=p.executeUpdate();
                if(r>0)
                response.sendRedirect("login.jsp");
            }
            catch(Exception e)
{}%>
            <div class="links">
                <a href="login.jsp">Already Registered?</a>
            </div>
        </div>
    </body>
</html>