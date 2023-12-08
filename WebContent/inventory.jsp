<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<h2><a href="index.jsp">Home</a></h2>
<%
try {
    // Load the JDBC driver
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);

    // SQL query for insertion
    String sql = "SELECT warehouseId FROM warehouse";
    PreparedStatement pstmt = connection.prepareStatement(sql);
    String sql1 = "SELECT productId, quantity, price FROM productinventory WHERE warehouseId = ?";

    // HTML table start
    

    // Execute the insert statement
    ResultSet rs = pstmt.executeQuery();
    while (rs.next()) {
        int id = rs.getInt("warehouseId");
        
            out.println("<h3>For Warehouse #" + id + "</h3>");
            out.println("<table border='1'>");
            out.println("<tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
        PreparedStatement pst1 = connection.prepareStatement(sql1);
        pst1.setInt(1, id);
        ResultSet rs1 = pst1.executeQuery();
        while (rs1.next()) {
            out.println("<tr>");
            out.println("<td>" + rs1.getInt("productId") + "</td>");
            out.println("<td>" + rs1.getInt("quantity") + "</td>");
            out.println("<td>" + rs1.getBigDecimal("price") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
        rs1.close();
        
    }
    

    pstmt.close();
    connection.close();

} catch (Exception e) {
    out.println("Error");
    // Handle exceptions (e.g., display an error message)
}
%>


