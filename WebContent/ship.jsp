<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
    <title>Nolan and Rhys's Grocery Shipment Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<%
    // TODO: Get order id
    String orderIdString = request.getParameter("orderId");
    int orderId = Integer.parseInt(orderIdString);

    
    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Establish database connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw";
        Connection connection = DriverManager.getConnection(url, uid, pw);
        
        // TODO: Check if valid order id in database
        String checkSQL = "SELECT * FROM ordersummary WHERE orderId = ?";
        PreparedStatement checkpstmt = connection.prepareStatement(checkSQL);
        checkpstmt.setInt(1, orderId);
        ResultSet rs = checkpstmt.executeQuery();
        
        if (!rs.next()) {
            out.println("Invalid order ID.");
            // TODO: Handle invalid order ID (e.g., display an error message)
        } else {
            // TODO: Start a transaction (turn-off auto-commit)
            connection.setAutoCommit(false);
            
            try {
                // TODO: Retrieve all items in the order with the given ID
                String itemsSQL = "SELECT productinventory.productId, orderproduct.quantity AS oQuantity, productinventory.quantity AS pQuantity FROM orderproduct JOIN productinventory ON orderproduct.productId = productinventory.productId WHERE orderId = ?";
                PreparedStatement orderpstmt = connection.prepareStatement(itemsSQL);
                orderpstmt.setInt(1, orderId);
                ResultSet orderRS = orderpstmt.executeQuery();
                boolean insufficient = false;
                int productId = 0;
                while (orderRS.next()) {
                    productId = orderRS.getInt("productId");
                    int orderedQuantity = orderRS.getInt("oQuantity");
                    int currentInventory = orderRS.getInt("pQuantity");
                    
                    out.println("<table>");
                    
                    // TODO: Check if there is enough quantity in warehouse 1
                    if (currentInventory >= orderedQuantity) {
                        out.println("<tr><td><th>Ordered Product: " + productId + "</th></td>");
                        
                        out.println("<td><th>Qty: " + orderedQuantity + "</th></td>");
                        out.println("<td><th>Previous Inventory: " + currentInventory + "</th></td>");
                        // TODO: Update inventory for each item
                        int newInventory = currentInventory - orderedQuantity;
                        out.println("<td><th>New Inventory: " + newInventory + "</th></td></tr>");
                        String updateInventorySql = "UPDATE productinventory SET quantity = ? WHERE productId = ?";
                        PreparedStatement updateInventoryStmt = connection.prepareStatement(updateInventorySql);
                        updateInventoryStmt.setInt(1, newInventory);
                        
                        updateInventoryStmt.setInt(2, productId);
                        updateInventoryStmt.executeUpdate();
                        updateInventoryStmt.close();
                        out.println("<tr><td><br></td></tr>");
                        
                        
                    } else {
                        // TODO: If any item does not have sufficient inventory, cancel transaction and rollback
                
                        connection.rollback();
                        insufficient = true;
                        break;
                    }
                    out.println("</table>");
                }
                
                

                // TODO: Commit the transaction if all items have sufficient inventory
                if(!insufficient)
                    out.println("<h3>Shipment successfully processed</h3>");
                else
                    out.println("<h3>Shipment not done. Insufficient inventory for product ID: " + productId + "</h3>");
                connection.commit();
                orderpstmt.close();
            } catch (SQLException e) {
                // TODO: Handle SQL exception
                out.println("SQL Exception: " + e);
                connection.rollback();
            } finally {
                // TODO: Auto-commit should be turned back on
                connection.setAutoCommit(true);
                
            }
            
            
        }
        
        checkpstmt.close();
        rs.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Exception: " + e);
    }
%>

<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
