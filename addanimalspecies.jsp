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
        <title>Add animal species</title>
    </head>
    <body>
        <h1 align="center">Animal Species</h1>
        <form method="post">
        <table align="center">
            <tr>
                <td>
                    <input type="text" id="nm" name="nm" placeholder="Enter the Animal Species Name" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="st" name="st" placeholder="Enter Current Population" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="ar" name="ar" placeholder="Enter The Area Found" required />
                </td>
            </tr>
            <tr>
                <td>
                    <input type="text" id="an" name="an" placeholder="Enter the Category" required />
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
            String current_population=request.getParameter("st");
            String area_found=request.getParameter("ar");
            String category=request.getParameter("an");
            try
            {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/wildlife","root","divyanka123");
            String ins="insert into animalspecies(name,current_population,area_found,category) values(?,?,?,?)";
            PreparedStatement p=con.prepareStatement(ins);
            p.setString(1, name);
            p.setString(2, current_population);
            p.setString(3, area_found);
            p.setString(4, category);
            int i=p.executeUpdate();
            if(i>0)
            out.println("one record added");
        }
        catch(Exception e)
        {}
            %>
    </body>
</html>
