<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Nolan and Rhys Grocery Order Processing</title>
</head>
<body>

<%@ include file="header.jsp" %>

<% 
// Get customer id

String custId = request.getParameter("customerId");
String orderDate = request.getParameter("orderDate");
String total = request.getParameter("totalAmount");
String ccnumber = request.getParameter("ccnumber");
String month = request.getParameter("month");
String day = request.getParameter("day");
String cvv = request.getParameter("cvv");
String address = request.getParameter("address");
String prov = request.getParameter("prov");
String city = request.getParameter("city");
String postalCode = request.getParameter("postalCode");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message
//make sure to add check for customer id that is a number, but is not a customer id
  //ie we have customer id's 1,2,3,4,5 but they enter 10, print out error


// Make connection
try{
	int cust = Integer.parseInt(custId);
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	// Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    Connection connection = DriverManager.getConnection(url, uid, pw);
	String remove = "DELETE FROM orderproduct";
	Statement rmv = connection.createStatement();
	rmv.executeUpdate(remove);
	String custIdCheck = "SELECT customerId FROM customer";
	Statement custIdCheckStatement = connection.createStatement();
	ResultSet custIdCheckRST = custIdCheckStatement.executeQuery(custIdCheck);
	int count = 0;
	boolean validCustomerId = false;

while(custIdCheckRST.next()){
    if(cust == custIdCheckRST.getInt("customerId")) {
        validCustomerId = true;
        break;
    }
}
if(validCustomerId==true){
	if(ccnumber == null || ccnumber.length() < 20){
		out.println("<tr><th>Invalid credit card number. Please go back and enter a valid credit card number");
	}
	else{
		try{
			double temp = Double.parseDouble(ccnumber);
			if((month.equals("m4") || month.equals("m6") || month.equals("m9") || month.equals("m11")) && (day.equals("d31"))){
				out.println("<tr><th>Invalid Date, please enter a valid date");
			}
			else if(month.equals("m2") && (day.equals("d29") || day.equals("d30") || day.equals("d31"))){
				out.println("<tr><th>Invalid Date, please ense a valid date");
			}
			else{
				if(cvv == null || cvv.length() < 3){
					out.println("<tr><th>Invalid CVV, please enter a valid 3 digit CVV");
				}
				else{
					try{
						int i = Integer.parseInt(cvv);
						String shipSql = "SELECT address, state, city, postalCode FROM customer WHERE customerId = ?";
						PreparedStatement shipPstmt = connection.prepareStatement(shipSql);
						shipPstmt.setString(1, custId);
						ResultSet shipRst = shipPstmt.executeQuery();
						String checkAddress = null;
						String checkProv = null;
						String checkCity = null;
						String checkPostalCode = null;
						while(shipRst.next()){
							checkAddress = shipRst.getString(1);
							checkProv = shipRst.getString(2);
							checkCity = shipRst.getString(3);
							checkPostalCode = shipRst.getString(4);
						}
						if(!(address.equals(checkAddress)) || !(prov.equals(checkProv)) || !(city.equals(checkCity)) || !(postalCode.equals(checkPostalCode))){
							out.println("<tr><th>Invalid shipment infomation.</th><br><th>Please make sure the shipping informatino you enter is the same information tied to your account</th></tr>");
						}
						else{
							String sql = "INSERT INTO ordersummary(customerId, orderDate, totalAmount) VALUES (?, ?, ?)";
							PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
							pstmt.setString(1, custId);
							pstmt.setString(2, orderDate);
							pstmt.setString(3, total);
							pstmt.executeUpdate();
							double orderTotal = 0;
							ResultSet keys = pstmt.getGeneratedKeys();
							keys.next();
							int orderId = keys.getInt(1);
							String sql2 = "INSERT INTO orderproduct(orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
							PreparedStatement pstmt2 = connection.prepareStatement(sql2);
							Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
							if(iterator.hasNext()){
								while (iterator.hasNext())
								{ 
									Map.Entry<String, ArrayList<Object>> entry = iterator.next();
									ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
									String productId = (String) product.get(0);
									String price = (String) product.get(2);
									double pr = Double.parseDouble(price);
									int qty = ( (Integer)product.get(3)).intValue();
									pstmt2.setInt(1, orderId);
									pstmt2.setString(2, productId);
									pstmt2.setInt(3, qty);
									pstmt2.setString(4, price);
									pstmt2.executeUpdate();
								}
								out.println("<header><h2>Your Order Summary</h2>");
								out.println("<table>");
								
								out.println("<tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
								String sql3 = "SELECT orderproduct.productId, productName, quantity, price, price FROM orderproduct JOIN product ON orderproduct.productId = product.productId";
								Statement stmt = connection.createStatement();
								ResultSet rst = stmt.executeQuery(sql3);
								while (rst.next()) {
									out.println("<tr>");
									out.println("<td>" + rst.getInt(1) + "</td>");
									out.println("<td>" + rst.getString(2) + "</td>");
									out.println("<td>" + rst.getInt(3) + "</td>");
									double price = rst.getDouble(4);
									orderTotal += price;
									out.println("<td> $" + rst.getString(4) + "</td>");
									out.println("<td>  $" + rst.getString(5) + "</td>");
									out.println("</tr>");
								}
								String priceString = String.format("%.2f", orderTotal);
								out.println("<td> </td><td> </td><td> </td><td><b>Order Total</b> $" + priceString + "</td>");
								out.println("</table>");
								
								out.println("<header><h1>Order Completed. Will be shipped soon.</h1>");
								out.println("<header><h1>Your order reference number is: " + orderId + ".</h1>");
								String SQL = "SELECT firstName, lastName FROM customer WHERE customerId = ?";
								PreparedStatement pstmtSQL = connection.prepareStatement(SQL);
								pstmtSQL.setInt(1,cust);
								ResultSet rs = pstmtSQL.executeQuery();
								
								while (rs.next()) {
									String lastName = rs.getString("lastName");
									String firstName = rs.getString("firstName");
									out.println("<header><h1>Shipping to customer " + cust + " Name: " + firstName + " " + lastName + "</h1>");
								}
								String orderTotalString = Double.toString(orderTotal);
								String updateOrderSummary = "UPDATE orderSummary SET totalAmount = ? WHERE orderId = ?";
								PreparedStatement update = connection.prepareStatement(updateOrderSummary);
								update.setString(1, orderTotalString);
								update.setInt(2, orderId);
								update.executeUpdate();

								session.removeAttribute("productList");
								pstmt.close();
								pstmt2.close();
								stmt.close();
								rmv.close();
								rst.close();
								connection.close();

							}
							else{
								out.println("<header><h1>Your shopping cart is empty, please put at least 1 item into your shopping cart</h1>");
							}
						}

					}catch(NumberFormatException e){
						out.println("<tr><th>Invalid CVV. Please enter a valid 3 digit cvv");
					}
				}
			}
		} catch(NumberFormatException e){
			out.println("<tr><th>Invalid credit card number. Please enter a valid credit card number");
		}
	}
}
else{
	out.println("<header><th>Invalid customer id, please go back and enter a valid customer id</h1>");
}
}catch (NumberFormatException e){
	out.println("<tr><th>Invalid Id, go back to the previous page and try again</th></tr>");
}catch (NullPointerException e){
	out.println("<tr><th>Your cart is empty, please go back and choose at least 1 item to put in your cart</th></tr>");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// try{
// 	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

//     String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
//     String uid = "sa";
//     String pw = "304#sa#pw";
//     Connection connection = DriverManager.getConnection(url, uid, pw);
// 	String insrt = "INSERT INTO orderProduct ()"
// }

// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/
	

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>


