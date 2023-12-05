<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Form</title>
</head>
<body>

    <h2>Write a Review</h2>

    <%-- Get productId and customerId from request parameters --%>
    <%
        String productId = request.getParameter("id");
    
    %>

    <form action="review.jsp?id=<%= productId %>" method="post">
        <label for="reviewRating">Rating:</label>
        <input type="number" id="reviewRating" name="reviewRating" min="1" max="5" required>
        <br>

        <label for="reviewComment">Review Comment:</label>
        <textarea id="reviewComment" name="reviewComment" rows="4" cols="50" required></textarea>
        <br>

        <!-- Add other input fields if needed -->

        <input type="submit" value="Submit">
    </form>

</body>
</html>


