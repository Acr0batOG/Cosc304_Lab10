<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>

<%
try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);

    // Get parameters from the HTML form
    int productId = Integer.parseInt(request.getParameter("id"));
    String updatedProductName = URLDecoder.decode(request.getParameter("productName"), "UTF-8");
    String updatedProductImage = URLDecoder.decode(request.getParameter("productImageURL"), "UTF-8");
    double updatedProductPrice = Double.parseDouble(request.getParameter("productPrice"));
    String updatedProductDesc = URLDecoder.decode(request.getParameter("productDesc"), "UTF-8");

    // Your update SQL statement
    String updateSQL = "UPDATE product SET productName = ?, productPrice = ?, productImageURL= ?, productDesc = ? WHERE productId = ?";
    PreparedStatement updateStatement = connection.prepareStatement(updateSQL);
    updateStatement.setString(1, updatedProductName);
    updateStatement.setDouble(2, updatedProductPrice);
    updateStatement.setString(3, updatedProductImage);
    updateStatement.setString(4, updatedProductDesc);
    updateStatement.setInt(5, productId);

    // Execute the update operation
    int rowsAffected = updateStatement.executeUpdate();

    // Display the result
    out.println("<!DOCTYPE html>");
    out.println("<html lang=\"en\">");
    out.println("<head>");
    out.println("    <meta charset=\"UTF-8\">");
    out.println("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
    out.println("    <title>Update Product Result</title>");
    out.println("</head>");
    out.println("<body>");
    out.println("    <h1>Update Product Result</h1>");
    if (rowsAffected > 0) {
        out.println("    <p>Product with ID " + productId + " updated successfully.</p>");
    } else {
        out.println("    <p>Failed to update product with ID " + productId + ".</p>");
    }
    out.println("</body>");
    out.println("</html>");

    updateStatement.close();
    connection.close();
} catch (SQLException | ClassNotFoundException e) {
    out.println("Error: Cold not update that product");
    
}
%>
<a href = "admin.jsp">Back to Admin</a>