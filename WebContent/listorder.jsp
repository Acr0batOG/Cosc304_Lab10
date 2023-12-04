<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Nolan and Rhys Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);


    String orderQuery = "SELECT orderId, orderDate, ordersummary.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId";
    PreparedStatement orderStatement = connection.prepareStatement(orderQuery);
    ResultSet orderResultSet = orderStatement.executeQuery();
 out.println("<table border='1'>");
out.println("<tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");

while (orderResultSet.next()) {
    int orderId = orderResultSet.getInt("orderId");
    String orderDate = orderResultSet.getString("orderDate");
    String customerId = orderResultSet.getString("customerId");
    String firstName = orderResultSet.getString("firstName");
    String lastName = orderResultSet.getString("lastName");
    double totalAmount = orderResultSet.getDouble("totalAmount");
    String totalString = String.format("%.2f", totalAmount);

    
    out.println("<tr><td>" + orderId + "</td><td>" + orderDate + "</td><td>" + customerId + "</td><td>" + firstName + " " + lastName + "</td><td> $" + totalString + "</td></tr>");

    
    out.println("<tr><td><td><td colspan='5'>");
    out.println("<table border='1'>");
    out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");

    String productSQL = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
    PreparedStatement productPst = connection.prepareStatement(productSQL);
    productPst.setInt(1, orderId);
    ResultSet productResultSet = productPst.executeQuery();

    while (productResultSet.next()) {
        int productId = productResultSet.getInt("productId");
        int quantity = productResultSet.getInt("quantity");
        double price = productResultSet.getDouble("price");
        String priceString = String.format("%.2f", price);

        out.println("<tr><td>" + productId + "</td><td>" + quantity + "</td><td>$" + priceString + "</td></tr>");
    }

    out.println("</table>");
    out.println("</td></td></td></tr>");

    productResultSet.close();
    productPst.close();
}

out.println("</table>");


   
    orderResultSet.close();
    orderStatement.close();
    connection.close();
} catch (Exception e) {
    out.println("Exception: " + e);
}
%>

</body>
</html>

