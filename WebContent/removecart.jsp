<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>

<%
// Get the product ID parameter from the request
String productIdToRemove = request.getParameter("productId");

// Retrieve the productList from the session
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Check if the productList is not null
if (productList != null) {
    // Remove the product with the specified ID
    productList.remove(productIdToRemove);

    // Update the productList in the session
    session.setAttribute("productList", productList);
}


response.sendRedirect("showcart.jsp");
%>

