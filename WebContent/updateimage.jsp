<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement" %>
<%@ page import="java.net.URLEncoder" %>

<%
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    String referringPage = request.getHeader("Referer");
    
    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    
    Connection connection = DriverManager.getConnection(url, uid, pw);
        String[] productImageURLs = {
            "img/HD600.jpg", "img/HD800.jpg", "img/Sundara.jpg", "img/Meze99.jpg", "img/ATH-M50X.jpg",
            "img/S12_Pro.jpg", "img/7Hz_Timeless.jpg", "img/Airpods_pro.jpg", "img/Airpods_2nd.jpg",
            "img/m_3.jpg", "img/fiio_3k.jpg", "img/HE_1.jpg"
        };
        
        String updateSQL = "UPDATE product SET productImageURL = ? WHERE ProductId = ?";
        
        PreparedStatement updateStatement = connection.prepareStatement(updateSQL);
            for (int i = 1; i <= productImageURLs.length; i++) {
                updateStatement.setString(1, productImageURLs[i - 1]);
                updateStatement.setInt(2, i);
                updateStatement.executeUpdate();
            }
        if (referringPage.endsWith("index.jsp")) {
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("shop.html");
}
    
} catch (Exception e) {
    // Handle other exceptions
    e.printStackTrace();
}


%>
