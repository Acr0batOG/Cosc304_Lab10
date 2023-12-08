<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.net.URLEncoder" %>

<%
//Note: Forces loading of SQL Server driver
try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
    String sql = "SELECT * FROM product";

    PreparedStatement preparedStatement = connection.prepareStatement(sql);

    ResultSet rs = preparedStatement.executeQuery();
    out.println("<header><h2>Select Product to Delete/Update</h2>");
    out.println("<table>");
    out.println("<tr>");
    out.println("<th></th>");
    out.println("<th>Product Name</th>");
    out.println("<th>Price</th>");
    out.println("</tr>");

    while (rs.next()) {
        out.println("<tr>");
        out.println("<td><a href='delete.jsp?id=" + URLEncoder.encode(String.valueOf(rs.getInt("productId")), "UTF-8") + "&name=" + URLEncoder.encode(rs.getString("productName"), "UTF-8") + "&price=" + URLEncoder.encode(String.valueOf(rs.getDouble("productPrice")), "UTF-8") + "'>Delete Product</a></td>");
        out.println("<td>" + rs.getString("productName") + "</td>");
        double price = rs.getDouble("productPrice");
        String priceString = String.format("%.2f", price);
        out.println("<td>$" + priceString + "</td>");
        out.println("<td><a href='updateproduct.jsp?id=" + URLEncoder.encode(String.valueOf(rs.getInt("productId")), "UTF-8") + "'>Update Product</a></td>");
        out.println("</tr>");
    }

    out.println("</table>");

    rs.close();
    preparedStatement.close();
    connection.close();
    
} catch (Exception e) {
    out.println("Error: " + e.getMessage());

}
%>
