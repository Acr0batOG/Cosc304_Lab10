<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product</title>
</head>
<body>

    <h1>Update Product</h1>
    <% int productId = Integer.parseInt(request.getParameter("id")); %>

    <form action="update.jsp" method="get">
        <!-- Include the id as a hidden field -->
        <input type="hidden" name="id" value="<%= productId %>">

        <!-- productName -->
        <label for="productName">Updated Product Name:</label>
        <input type="text" id="productName" name="productName" required><br>

        <!-- productPrice -->
        <label for="productPrice">Updated Price:</label>
        <input type="number" id="productPrice" name="productPrice" step="0.01" required><br>

        <!-- productImageURL -->
        <label for="productImageURL">Updated Image URL:</label>
        <input type="text" id="productImageURL" name="productImageURL" required><br>

        <!-- productDesc -->
        <label for="productDesc">Updated Product Description:</label>
        <textarea id="productDesc" name="productDesc" rows="4" cols="50" required></textarea><br>

        <!-- Submit Button -->
        <input type="submit" value="Update Product">
    </form>

</body>
</html>
