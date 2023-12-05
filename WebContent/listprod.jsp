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

    String sql1 = "UPDATE product SET productImageURL = 'img/HD600.jpg' WHERE ProductId = 1";
    PreparedStatement pst1 = connection.prepareStatement(sql1);
    pst1.executeUpdate();
    String sql2 = "UPDATE product SET productImageURL = 'img/HD800.jpg' WHERE ProductId = 2";
    PreparedStatement pst2 = connection.prepareStatement(sql2);
    pst2.executeUpdate();
    String sql3 = "UPDATE product SET productImageURL = 'img/Sundara.jpg' WHERE ProductId = 3";
    PreparedStatement pst3 = connection.prepareStatement(sql3);
    pst3.executeUpdate();
    String sql4 = "UPDATE product SET productImageURL = 'img/Meze99.jpg' WHERE ProductId = 4";
    PreparedStatement pst4 = connection.prepareStatement(sql4);
    pst4.executeUpdate();
    String sql5 = "UPDATE product SET productImageURL = 'img/ATH-M50X.jpg' WHERE ProductId = 5";
    PreparedStatement pst5 = connection.prepareStatement(sql5);
    pst5.executeUpdate();
    String sql6 = "UPDATE product SET productImageURL = 'img/S12_Pro.jpg' WHERE ProductId = 6";
    PreparedStatement pst6 = connection.prepareStatement(sql6);
    pst6.executeUpdate();
    String sql7 = "UPDATE product SET productImageURL = 'img/7Hz_Timeless.jpg' WHERE ProductId = 7";
    PreparedStatement pst7 = connection.prepareStatement(sql7);
    pst7.executeUpdate();
    String sql8 = "UPDATE product SET productImageURL = 'img/Airpods_pro.jpg' WHERE ProductId = 8";
    PreparedStatement pst8 = connection.prepareStatement(sql8);
    pst8.executeUpdate();
    String sql9 = "UPDATE product SET productImageURL = 'img/Airpods_2nd.jpg' WHERE ProductId = 9";
    PreparedStatement pst9 = connection.prepareStatement(sql9);
    pst9.executeUpdate();
    String sql10 = "UPDATE product SET productImageURL = 'img/m_3.jpg' WHERE ProductId = 10";
    PreparedStatement pst10 = connection.prepareStatement(sql10);
    pst10.executeUpdate();
    String sql11 = "UPDATE product SET productImageURL = 'img/fiio_3k.jpg' WHERE ProductId = 11";
    PreparedStatement pst11 = connection.prepareStatement(sql11);
    pst11.executeUpdate();
    String sql12 = " UPDATE product SET productImageURL = 'img/HE_1.jpg' WHERE ProductId = 12";
    PreparedStatement pst12 = connection.prepareStatement(sql12);
    pst12.executeUpdate();
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
         out.println("<td><a href='reviews.jsp?id=" + URLEncoder.encode(String.valueOf(rs.getInt("productId")), "UTF-8") + "'>Review Product</a></td>");
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