<%@ page import="java.util.regex.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%!
private static final Pattern VALID_PHONE_NUMBER = Pattern.compile("^[0-9.()-]{10,25}$");
private static final String POSTAL_CODE_REGEX = "^[a-zA-Z0-9\\s-]{1,20}$";
// Function to check if a string is empty
boolean isEmpty(String str) {
    return str == null || str.trim().isEmpty();
}

// Function to validate email format
boolean isValidEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    return email.matches(emailRegex);
}


boolean isValidPhoneNumber(String s) {
        Matcher m = VALID_PHONE_NUMBER.matcher(s);
        return m.matches();
    }

boolean isValidPostalCode(String postalCode) {
        return !isEmpty(postalCode) && postalCode.matches(POSTAL_CODE_REGEX);
    }

// Function to validate password format
boolean isValidPassword(String password) {
    // Password must contain at least one uppercase, one lowercase, and one digit
    return password.matches(".*[A-Z].*") && password.matches(".*[a-z].*") && password.matches(".*\\d.*");
}
%>
<%
// Get parameter values from the request
String firstName = request.getParameter("firstName");
String lastName = request.getParameter("lastName");
String userEmail = request.getParameter("email"); // Rename to avoid conflict
String phonenum = request.getParameter("phonenum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalCode = request.getParameter("postalCode");
String country = request.getParameter("country");
String userid = request.getParameter("userid");
String userPassword = request.getParameter("password"); // Rename to avoid conflict

// Server-side validation
if (isEmpty(firstName) || isEmpty(lastName) || isEmpty(userEmail) || isEmpty(phonenum) || isEmpty(address) ||
    isEmpty(city) || isEmpty(state) || isEmpty(postalCode) || isEmpty(country) || isEmpty(userid) || isEmpty(userPassword)) {
    out.println("All fields are required. Please fill in all the fields.");
    out.println("<a href='create.html'>Back</a>");
} else if (!isValidEmail(userEmail)) {
    out.println("Invalid email format. Please enter a valid email address.");
    out.println("<a href='create.html'>Back</a>");
} else if (!isValidPhoneNumber(phonenum)) {
    out.println("Invalid phone number format. Please enter a valid phone number.");
    out.println("<a href='create.html'>Back</a>");
} else if (!isValidPostalCode(postalCode)) {
    out.println("Invalid postal code format. Please enter a valid postal code.");
    out.println("<a href='create.html'>Back</a>");
} else if (!isValidPassword(userPassword)) {
    out.println("Invalid password format. Password must contain at least one uppercase letter, one lowercase letter, and one digit.");
    out.println("<a href='create.html'>Back</a>");
} else {
    // Perform database insertion or other necessary actions here
    out.println("<h2><a href='shop.html'>Home</a><h2>");
try {
    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
   
    // Establish database connection
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    
    Connection connection = DriverManager.getConnection(url, uid, pw);
        
        
        String SQL = "INSERT INTO customer(firstName,lastName,email,phonenum,address,city,state,postalCode,country,userid,password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        
        PreparedStatement pst = connection.prepareStatement(SQL);
        pst.setString(1, firstName);
        pst.setString(2,lastName);
        pst.setString(3,userEmail);
        pst.setString(4, phonenum);
        pst.setString(5,address);
        pst.setString(6,city);
        pst.setString(7,state);
        pst.setString(8,postalCode);
        pst.setString(9,country);
        pst.setString(10,userid);
        pst.setString(11, userPassword);
        pst.executeUpdate();
        out.println("Customer Successfully Added");   
    
} catch (Exception e) {
    // Handle other exceptions
    out.println("Error inserting customer");
}
    
}
%>
