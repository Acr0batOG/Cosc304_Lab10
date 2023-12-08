<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<%
try {
    // Load driver class
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);

    // Get parameters from the URL
    int productId = Integer.parseInt(request.getParameter("id"));

    // Check for references in orderproduct table
    String checkOrderProductSQL = "SELECT COUNT(*) FROM orderproduct WHERE productId = ?";
    PreparedStatement checkOrderProductStatement = connection.prepareStatement(checkOrderProductSQL);
    checkOrderProductStatement.setInt(1, productId);
    ResultSet orderProductReferencesResult = checkOrderProductStatement.executeQuery();

    // Check for references in incart table
    String checkInCartSQL = "SELECT COUNT(*) FROM incart WHERE productId = ?";
    PreparedStatement checkInCartStatement = connection.prepareStatement(checkInCartSQL);
    checkInCartStatement.setInt(1, productId);
    ResultSet inCartReferencesResult = checkInCartStatement.executeQuery();

    if (orderProductReferencesResult.next() && orderProductReferencesResult.getInt(1) > 0
            || inCartReferencesResult.next() && inCartReferencesResult.getInt(1) > 0) {
        // Product has references in orderproduct or incart, handle accordingly (e.g., display an error message)
        out.println("<html><head><title>Delete Product</title></head><body>");
        out.println("<h2>Delete Product Result</h2>");
        out.println("<p>Cannot delete product with ID " + productId + " because it is referenced in the orderproduct or incart table.</p>");
        out.println("</body></html>");
    } else {
        // Your delete SQL statement
        String deleteSQL = "DELETE FROM product WHERE productId = ?";
        PreparedStatement deleteStatement = connection.prepareStatement(deleteSQL);
        deleteStatement.setInt(1, productId);

        // Execute the delete operation
        int rowsAffected = deleteStatement.executeUpdate();

        // Display the result
        out.println("<html><head><title>Delete Product</title></head><body>");
        out.println("<h2>Delete Product Result</h2>");
        if (rowsAffected > 0) {
            out.println("<p>Product with ID " + productId + " deleted successfully.</p>");
        } else {
            out.println("<p>Failed to delete product with ID " + productId + ".</p>");
        }
        out.println("</body></html>");

        deleteStatement.close();
    }

    orderProductReferencesResult.close();
    inCartReferencesResult.close();
    checkOrderProductStatement.close();
    checkInCartStatement.close();
    connection.close();
} catch (SQLException | ClassNotFoundException e) {
    out.println("Error: The product could not be deleted");
    
}
%>
<h2><a href="admin.jsp">Back to Admin</a></h2>

