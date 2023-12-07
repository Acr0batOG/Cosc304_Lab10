<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// Get the productId parameter from the request
String id = request.getParameter("productId");
int productId = Integer.parseInt(id);

try {
    // Load the JDBC driver
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
    
    // SQL query for deletion
    String sql = "DELETE FROM product WHERE productId = ?";
    PreparedStatement pstmt = connection.prepareStatement(sql);

    // Set the parameter
    pstmt.setInt(1, productId);

    // Execute the delete statement
    int rowsAffected = pstmt.executeUpdate();
    pstmt.close();
    connection.close();

    if (rowsAffected > 0) {
        out.println("Product with productId " + productId + " deleted successfully.");
    } else {
        out.println("Product with productId " + productId + " not found or couldn't be deleted.");
    }

    // Redirect to a success page or display a success message
    //response.sendRedirect("admin.jsp");
} catch (Exception e) {
    // Handle exceptions (e.g., display an error message)
    out.println("Error");
    
    //response.sendRedirect("admin.jsp");
}
%>
