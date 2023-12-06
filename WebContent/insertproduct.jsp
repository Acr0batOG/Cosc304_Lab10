<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
// Get form data
String productName = request.getParameter("productName");
double productPrice = Double.parseDouble(request.getParameter("productPrice"));
String productImageURL = request.getParameter("productImage");
String productDesc = request.getParameter("productDesc");
int categoryId = Integer.parseInt(request.getParameter("categoryId"));



try {
    // Load the JDBC driver
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);

    // SQL query for insertion
    String sql = "INSERT INTO product (productName, productPrice, productImage, productDesc, categoryId) VALUES (?, ?, ?, ?, ?)";
    PreparedStatement pstmt = connection.prepareStatement(sql);
    
    // Set parameters
    pstmt.setString(1, productName);
    pstmt.setDouble(2, productPrice);
    pstmt.setString(3, productImageURL);
    pstmt.setString(4, productDesc);
    pstmt.setInt(5, categoryId);

    // Execute the insert statement
    pstmt.executeUpdate();
    pstmt.close();
    connection.close();
    // Redirect to a success page or display a success message
    response.sendRedirect("admin.jsp");
} catch (Exception e) {
    // Handle exceptions (e.g., display an error message)
    e.printStackTrace();
}

%>
