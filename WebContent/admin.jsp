<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>
<h2>Administrator's Sales Report by Day</h2>
<%
// TODO: Include files auth.jsp and jdbc.jsp
%>
<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>
<%
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT CAST(orderDate AS DATE), SUM(totalAmount) FROM orderSummary GROUP BY CAST(orderDate AS DATE)";
try{
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
    Statement stmt = connection.createStatement();
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<table border='1'>");
    out.println("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    while(rst.next()){
        Date oDate = rst.getDate(1);
        String total = rst.getString(2);
        out.println("<tr><td>" + oDate + "</td><td> $" + total + "</td></tr>");
    }
    out.println("</table>");
    rst.close();
    stmt.close();
}catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


%>
<a href= "index.jsp">Home</a><br>
<a href="addproduct.html">Add Product</a><br>
<a href="deleteproduct.jsp">Delete/Update Product</a><br>

</body>
</html>

