<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<head>
    <title>Register</title>
</head>
<body>

<h1>Please enter your information</h1>

<tr>First Name: </tr>
<form method="post" action="register.jsp">
<input type="text" name="fname">

<br>

<tr>Last Name: </tr>
<form method="post" action="register.jsp">
<input type="text" name="lname">

<br>

<tr>Email: </tr>
<form method="post" action="register.jsp">
<input type="text" name="email">

<br>

<tr>Phone Number: </tr>
<form method="post" action="register.jsp">
<input type="text" name="phone">

<br>

<tr>Address: </tr>
<form method="post" action="register.jsp">
<input type="text" name="address">

<br>

<tr>City: </tr>
<form method="post" aciton="register.jsp">
<input type="text" name="city">

<br>

<tr>Province: </tr>
<form method="post" action="order.jsp">
<select name="prov" id="prov">
    <option value="NL">NL</option>
    <option value="PE">PE</option>
    <option value="NS">NS</option>
    <option value="NB">NB</option>
    <option value="QC">QC</option>
    <option value="ON">ON</option>
    <option value="MB">MB</option>
    <option value="SK">SK</option>
    <option value="AB">AB</option>
    <option value="BC">BC</option>
    <option value="YT">YT</option>
    <option value="NT">NT</option>
    <option value="NU">NU</option>
</select>

<br>

<tr>Postal Code: </tr>
<form method="post" action="register.jsp">
<input type="text" name="postalCode">

<br>

<tr>Country: </tr>
<form method="post" action="register.jsp">
<input type="text" name="country">

<br>

<tr>User Name: </tr>
<form method="post" action="register.jsp">
<input type="text" name="userName">

<br>

<tr>Password: </tr>
<form method="post" action="register.jsp">
<input type="text" name="password">

<br>

<input type="submit" value="Submit" value="Order"><input type="reset" value="Reset">

<br>

<a href="shop.html">Click to go back to home page</a>

<br>

<a href="login.jsp">Click to go to login page</a>

<%
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String prov = request.getParameter("prov");
    String postalCode = request.getParameter("postalCode");
    String country = request.getParameter("country");
    String userName = request.getParameter("userName");
    String password = request.getParameter("password");

    try{
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Establish database connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw";
        Connection connection = DriverManager.getConnection(url, uid, pw);

        
        String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = connection.prepareStatement(sql);
        pstmt.setString(1, fname);
        pstmt.setString(2, lname);
        pstmt.setString(3, email);
        pstmt.setString(4, phone);
        pstmt.setString(5, address);
        pstmt.setString(6, city);
        pstmt.setString(7, prov);
        pstmt.setString(8, postalCode);
        pstmt.setString(9, country);
        pstmt.setString(10, userName);
        pstmt.setString(11, password);
        pstmt.executeUpdate();
    
    }catch (java.lang.ClassNotFoundException e)
    {
	    out.println("ClassNotFoundException: " +e);
    }
%>

</body>
</html>