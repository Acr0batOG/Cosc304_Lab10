<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>
<h2> Customer Profile </h2>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
	// TODO: Print Customer information
	String sql = "SELECT userId, customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country FROM customer WHERE userid = ?";
	PreparedStatement pstmt = connection.prepareStatement(sql);
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();
	out.println("<table border='1'");
	while(rst.next()){
		int id = rst.getInt(2);
		String fName = rst.getString(3);
		String lName = rst.getString(4);
		String email = rst.getString(5);
		String phone = rst.getString(6);
		String address = rst.getString(7);
		String city = rst.getString(8);
		String state = rst.getString(9);
		String postalCode = rst.getString(10);
		String country = rst.getString(11);
		out.println("<tr><td><b>Id</b></td><td>"+id+"</td></tr>");
		out.println("<tr><td><b>First Name</b></td><td>"+fName+"</td></tr>");
		out.println("<tr><td><b>Last Name</b></td><td>"+lName+"</td></tr>");
		out.println("<tr><td><b>Email</b></td><td>"+email+"</td></tr>");
		out.println("<tr><td><b>Phone</b></td><td>"+phone+"</td></tr>");
		out.println("<tr><td><b>Address</b></td><td>"+address+"</td></tr>");
		out.println("<tr><td><b>City</b></td><td>"+city+"</td></tr>");
		out.println("<tr><td><b>State</b></td><td>"+state+"</td></tr>");
		out.println("<tr><td><b>Postal Code</b></td><td>"+postalCode+"</td></tr>");
		out.println("<tr><td><b>Country</b></td><td>"+country+"</td></tr>");
		out.println("<tr><td><b>User Name</b></td><td>"+userName+"</td></tr>");
	}
	out.println("</table>");
	out.println("<h2>Customer's Orders</h2>");
	String custOrder = "SELECT userId, orderId, orderSummary.customerId, totalAmount FROM orderSummary JOIN customer ON orderSummary.customerId = customer.customerId WHERE userId = ?";
	PreparedStatement pstmt2 = connection.prepareStatement(custOrder);
	pstmt2.setString(1, userName);
	ResultSet rst2 = pstmt2.executeQuery();
	while(rst2.next()){
		int orderId = rst2.getInt(2);
		String customerId = rst2.getString(3);
		String totalAmount = rst2.getString(4);
		out.println("<table border='1'>");
		out.println("<tr><th>Order Id</th><th>Customer Id</th><th>Total Amount</th></tr>");
		out.println("<tr><td>"+orderId+"</td><td>"+customerId+"</td><td>$"+totalAmount+"</td></tr>");
	}
}catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Make sure to close connection
%>

</body>
</html>

