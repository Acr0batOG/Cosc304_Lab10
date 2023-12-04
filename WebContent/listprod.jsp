<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Nolan and Rhys Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);

    String sql;
    if (name != null && !name.isEmpty()) {
        sql = "SELECT * FROM product WHERE productName LIKE ?";
    } else {
        sql = "SELECT * FROM product";
    }

    
    PreparedStatement preparedStatement = connection.prepareStatement(sql);

    if (name != null && !name.isEmpty()) {
        preparedStatement.setString(1, "%" + name + "%");
    }
	ResultSet rs = preparedStatement.executeQuery();
	out.println("<header><h2>All Products</h2>");
	out.println("<table>");
	out.println("<tr>");
    out.println("<th></th>");
    out.println("<th>Product Name</th>");
    out.println("<th>Price</th>");
    out.println("</tr>");
    while (rs.next()) {
         out.println("<tr>");
         out.println("<td><a href='addcart.jsp?id=" + URLEncoder.encode(String.valueOf(rs.getInt("productId")), "UTF-8") + "&name=" + URLEncoder.encode(rs.getString("productName"), "UTF-8") + "&price=" + URLEncoder.encode(String.valueOf(rs.getDouble("productPrice")), "UTF-8") + "'>Add to Cart</a></td>");
         out.println("<td><a href='product.jsp?id=" + URLEncoder.encode(String.valueOf(rs.getInt("productId")), "UTF-8") + "&name=" + URLEncoder.encode(rs.getString("productName"), "UTF-8") + "&price=" + URLEncoder.encode(String.valueOf(rs.getDouble("productPrice")), "UTF-8") + "'>" + rs.getString("productName") + "</a></td>");
         //out.println("<td>" + rs.getString("productName") + "+</td>");
         double price = rs.getDouble("productPrice");
         String priceString = String.format("%.2f", price);
         out.println("<td>$" + priceString + "</td>");
         out.println("</tr>");
      }

      out.println("</table>");
    
	rs.close();
    preparedStatement.close();
    connection.close();
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>