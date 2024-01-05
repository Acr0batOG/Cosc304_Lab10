<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Passowrd</title>
</head>

<body>
<h2> Please enter a new password </h2>

<tr>Customer Id: </tr>
<form method="post" action="forgotPassword.jsp">
<input type="text" name="customerId">

<br>

<tr>New Password</tr>
<form method="post" action="forgotPassword.jsp">
<input type="text" name="newPassword">

<input type="submit" value="Submit"><br>
<a href="login.jsp">Back to login page</a>

<%
    try{
       Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
       // Establish database connection
       String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
       String uid = "sa";
       String pw = "304#sa#pw";
       Connection connection = DriverManager.getConnection(url, uid, pw);
       String customerId = request.getParameter("customerId");
       String newPassword = request.getParameter("newPassword");
       String updatePassword = "UPDATE customer SET password = ? WHERE customerId = ?";
       PreparedStatement pstmt = connection.prepareStatement(updatePassword);
       pstmt.setString(1, newPassword);
       pstmt.setString(2, customerId);
       pstmt.executeUpdate();
    }catch (java.lang.ClassNotFoundException e){
        out.println("ClassNotFoundException: " +e);
    }
    
%>
</body>
</html>
