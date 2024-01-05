<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Username?</title>
</head>

<body>
<h2>Please enter a new username: </h2>

<tr>Customer Id: </tr>
<form method="post" action="forgotUsername.jsp">
<input type="text" name="customerId">

<br>

<tr>New Username: </tr>
<form method="post" action="forgotUsename.jsp">
<input type="text" name="newUsername">

<br>

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
       String newUsername = request.getParameter("newUsername");
       String customerId = request.getParameter("customerId");
       String updateUsername = "UPDATE customer SET userid = ? WHERE customerId = ?";
       PreparedStatement pstmt = connection.prepareStatement(updateUsername);
       pstmt.setString(1, newUsername);
       pstmt.setString(2, customerId);
       pstmt.executeUpdate();
    }catch (java.lang.ClassNotFoundException e){
        out.println("ClassNotFoundException: " +e);
    }
    
%>
