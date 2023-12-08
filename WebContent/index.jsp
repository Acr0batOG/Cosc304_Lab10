<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nolan and Rhys's Headphone Emporium</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        header {
            background-color: #007BFF; /* Blue color for the banner */
            color: #fff;
            padding: 10px;
            text-align: center;
        }

        h1 {
            margin: 0; /* Remove default margin for h1 */
        }

        nav {
            display: flex;
            flex-direction: column; /* Make the list vertical */
            align-items: center; /* Center links horizontally */
            background-color: #333;
            padding: 10px;
        }

        nav a {
            color: #007BFF;
            text-decoration: none;
            margin: 5px 0; /* Add some vertical spacing between links */
        }

        nav a:hover {
            text-decoration: underline;
        }
		.scroller-container {
            white-space: nowrap; /* Prevent line breaks */
            animation: scroll 20s linear infinite; /* Adjust the animation duration as needed */
        }

        .scroller-image {
            display: inline-block;
            max-height: 100vh; /* Adjust the maximum height as needed */
            margin-right: 20px; /* Adjust the spacing between images */
        }

        @keyframes scroll {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%);
            }
        }
    </style>
</head>
<body>

    <header>
        <h1 align="center">Nolan and Rhys's Headphone Emporium</h1>
    </header>

    <%
        String userName = (String) session.getAttribute("authenticatedUser");
        if (userName != null)
            out.println("<h3 align=\"center\">Signed in as: " + userName + "</h3>");
    %>

    <nav>
        <a href="login.jsp">Login</a>
        <a href="listprod.jsp">Begin Shopping</a>
        <a href="listorder.jsp">List All Orders</a>
        <a href="customer.jsp">Customer Info</a>
        <a href="admin.jsp">Administrators</a>
        <a href = "inventory.jsp">Inventory by Store</a>
        <a href="logout.jsp">Log Out</a>
        <a href="showcart.jsp">View your Cart</a>
        <a href = "updateimage.jsp">Load Images</a>
        <a href="ship.jsp?orderId=1">Test Ship orderId=1</a>
        <a href="ship.jsp?orderId=3">Test Ship orderId=3</a>
    </nav>
	<div class="scroller-container">
    <img class="scroller-image" src="img/HD800.jpg" alt="Image 2">
    <img class="scroller-image" src="img/Sundara.jpg" alt="Image 3">
    <img class="scroller-image" src="img/S12_Pro.jpg" alt="Image 6">    
    <img class="scroller-image" src="img/HE_1.jpg" alt="Image 12">
</div>
</body>
</html>



