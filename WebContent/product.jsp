<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.sql.*,java.net.URLEncoder" %>

<html>
<head>
<title>Nolan and Rhys's Grocery - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("id");

String sql = "SELECT productId, productName, productImageURL, productImage, productPrice FROM product WHERE productId = ?";
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
    PreparedStatement pstmt = connection.prepareStatement(sql);
    String productId = request.getParameter("id");
    pstmt.setString(1, productId);

    ResultSet rst = pstmt.executeQuery();
    while(rst.next()){
        out.println("<tr><h2>"+rst.getString(2)+"</h2></tr>");
        out.println("<br>");
        if(!(rst.getString(3)==null)){
            out.println("<tr><th><img src = '" +rst.getString(3)+ "'></th></tr>");
        }
        if(!(rst.getString(4)==null)){
            out.println("<tr><th><img src = displayImage.jsp?id="+productId+"></th></tr>");
        }
        out.println("<br>");
        out.println("<tr><th><b>Id</b> " + rst.getInt(1)+"</th></tr>");
        out.println("<br>");
        out.println("<tr><th><b>Price</b> $"+ rst.getString(5)+"</th></tr>");
        out.println("<br>");
        out.println("<td><h2><a href='addcart.jsp?productId=" + URLEncoder.encode(String.valueOf(rst.getInt("productId")), "UTF-8") + "&name=" + URLEncoder.encode(rst.getString("productName"), "UTF-8") + "&price=" + URLEncoder.encode(String.valueOf(rst.getDouble("productPrice")), "UTF-8") + "'>Add to Cart</a></h2></td>");
    }
    rst.close();
    session.removeAttribute("addcart");
    
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>

