<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.net.URLEncoder" %>


<%
    //Needed since the ddl didn't work for setting the imageURL
	try{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
	String sql1 = "UPDATE product SET productImageURL = 'img/HD600.jpg' WHERE ProductId = 1";
    PreparedStatement pst1 = connection.prepareStatement(sql1);
    pst1.executeUpdate();
    String sql2 = "UPDATE product SET productImageURL = 'img/HD800.jpg' WHERE ProductId = 2";
    PreparedStatement pst2 = connection.prepareStatement(sql2);
    pst2.executeUpdate();
    String sql3 = "UPDATE product SET productImageURL = 'img/Sundara.jpg' WHERE ProductId = 3";
    PreparedStatement pst3 = connection.prepareStatement(sql3);
    pst3.executeUpdate();
    String sql4 = "UPDATE product SET productImageURL = 'img/Meze99.jpg' WHERE ProductId = 4";
    PreparedStatement pst4 = connection.prepareStatement(sql4);
    pst4.executeUpdate();
    String sql5 = "UPDATE product SET productImageURL = 'img/ATH-M50X.jpg' WHERE ProductId = 5";
    PreparedStatement pst5 = connection.prepareStatement(sql5);
    pst5.executeUpdate();
    String sql6 = "UPDATE product SET productImageURL = 'img/S12_Pro.jpg' WHERE ProductId = 6";
    PreparedStatement pst6 = connection.prepareStatement(sql6);
    pst6.executeUpdate();
    String sql7 = "UPDATE product SET productImageURL = 'img/7Hz_Timeless.jpg' WHERE ProductId = 7";
    PreparedStatement pst7 = connection.prepareStatement(sql7);
    pst7.executeUpdate();
    String sql8 = "UPDATE product SET productImageURL = 'img/Airpods_pro.jpg' WHERE ProductId = 8";
    PreparedStatement pst8 = connection.prepareStatement(sql8);
    pst8.executeUpdate();
    String sql9 = "UPDATE product SET productImageURL = 'img/Airpods_2nd.jpg' WHERE ProductId = 9";
    PreparedStatement pst9 = connection.prepareStatement(sql9);
    pst9.executeUpdate();
    String sql10 = "UPDATE product SET productImageURL = 'img/m_3.jpg' WHERE ProductId = 10";
    PreparedStatement pst10 = connection.prepareStatement(sql10);
    pst10.executeUpdate();
    String sql11 = "UPDATE product SET productImageURL = 'img/fiio_3k.jpg' WHERE ProductId = 11";
    PreparedStatement pst11 = connection.prepareStatement(sql11);
    pst11.executeUpdate();
    String sql12 = " UPDATE product SET productImageURL = 'img/HE_1.jpg' WHERE ProductId = 12";
    PreparedStatement pst12 = connection.prepareStatement(sql12);
    pst12.executeUpdate();
	}catch(Exception e){
		
	}
    response.sendRedirect("listprod.jsp");
%>