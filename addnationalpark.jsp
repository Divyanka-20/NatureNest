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
        <title>Add national park</title>
    </head>
    <body>
        <h1 align="center">National Park</h1>
        <form method="post">
        <table align="center">
            <tr>
                <td>
                    <input type="text" id="nm" name="nm" placeholder="Enter the National Park Name" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="st" name="st" placeholder="Enter State" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="ar" name="ar" placeholder="Enter The Area of the park" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="an" name="an" placeholder="Enter the Animals Found" required />
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
            String state=request.getParameter("st");
            String area=request.getParameter("ar");
            String animal=request.getParameter("an");
            try
            {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife","root","divyanka123");
            String ins="insert into nationalpark(name,state,area,animals) values(?,?,?,?)";
            PreparedStatement p=con.prepareStatement(ins);
            p.setString(1, name);
            p.setString(2, state);
            p.setString(3, area);
            p.setString(4, animal);
            int i=p.executeUpdate();
            if(i>0)
            out.println("one record added");
        }
        catch(Exception e)
        {}
            %>
    </body>
</html>
