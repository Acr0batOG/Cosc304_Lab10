<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%
    // Check if the form is submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Retrieve input parameters from the HTML form
        int reviewRating = Integer.parseInt(request.getParameter("reviewRating"));
        String reviewComment = request.getParameter("reviewComment");
        String reviewDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        int productId = Integer.parseInt(request.getParameter("id"));
        
        // You can retrieve other parameters like customerId, productId, etc., similarly

        // Database connection parameters
        

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	    // Establish database connection
        String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
        String uid = "sa";
        String pw = "304#sa#pw";
        Connection connection = DriverManager.getConnection(url, uid, pw);

            // SQL query to insert data into the review table
            String insertQuery = "INSERT INTO review (reviewRating, reviewDate, productId, reviewComment) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setInt(1, reviewRating);
            preparedStatement.setString(2, reviewDate);
            preparedStatement.setInt(3, productId);
            preparedStatement.setString(4, reviewComment);

            // Execute the query
            preparedStatement.executeUpdate();
            out.println("Review submitted");
            Thread.sleep(1000);
            preparedStatement.close();
            connection.close();

            // Redirect to a success page or display a success message
            response.sendRedirect("listprod.jsp");
        } catch (Exception e) {
            e.printStackTrace();
                response.sendRedirect("listprod.jsp");
        }
    }
%>
