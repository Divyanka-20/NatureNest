<%-- 
    Document   : addnationalpark
    Created on : Aug 7, 2024, 5:18:16 PM
    Author     : divya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add birds</title>
    </head>
    <body>
        <h1 align="center">Birds</h1>
        <form method="post">
        <table align="center">
            <tr>
                <td>
                    <input type="text" id="nm" name="nm" placeholder="Enter the Bird Name" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="st" name="st" placeholder="Enter Category" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="ar" name="ar" placeholder="Enter The Area Found" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="an" name="an" placeholder="Enter the Details" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="ADD" />
                </td>
            </tr>
        </table>
        </form>
        <%
            String name=request.getParameter("nm");
            String category=request.getParameter("st");
            String areafound=request.getParameter("ar");
            String details=request.getParameter("an");
            try
            {                                                                   
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife","root","divyanka123");
            String ins="insert into birds(name,category,areafound,details) values(?,?,?,?)";
            PreparedStatement p=con.prepareStatement(ins);
            p.setString(1, name);
            p.setString(2, category);
            p.setString(3, areafound);
            p.setString(4, details);
            int i=p.executeUpdate();
            if(i>0)
            out.println("one record added");
        }
        catch(Exception e)
        {}
            %>
    </body>
</html>
                                                                                                                                                                                                                                                                                                                                                                            