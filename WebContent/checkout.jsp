<!DOCTYPE html>
<html>
<head>
<title>CheckOut Line</title>
</head>
<body>

<%@ include file="header.jsp" %>

<h1>Enter your customer id to complete the transaction:</h1>

<form method="get" action="order.jsp">
<input type="text" name="customerId" size="50">

<h1>Enter your payment details</h1>

<label for="paymentType">Choose a credit card type:</label>
<select name="paymentType" id="paymentType">
    <option value="visa">Visa</option>
    <option value="americanExpress">American express</option>
    <option value="masterCard">MasterCard</option>
</select>

<br>

<tr>Credit card number: </tr>
<form method="post" action="order.jsp">
<input type ="text" name="ccnumber" size="20" maxlength="20">


<br>

<tr>Expiry Date: Month </tr>
<from method="post" action="order.jsp">
<select name="month" id="month">
    <option value="m1">1</option>
    <option value="m2">2</option>
    <option value="m3">3</option>
    <option value="m4">4</option>
    <option value="m5">5</option>
    <option value="m6">6</option>
    <option value="m7">7</option>
    <option value="m8">8</option>
    <option value="m9">9</option>
    <option value="m10">10</option>
    <option value="m11">11</option>
    <option value="m12">12</option>
</select>

<tr>Day </tr>
<form method="post" action="order.jsp">
<select name="day" id="day">
    <option value="d1">1</option>
    <option value="d2">2</option>
    <option value="d3">3</option>
    <option value="d4">4</option>
    <option value="d5">5</option>
    <option value="d6">6</option>
    <option value="d7">7</option>
    <option value="d8">8</option>
    <option value="d9">9</option>
    <option value="d10">10</option>
    <option value="d11">11</option>
    <option value="d12">12</option>
    <option value="d13">13</option>
    <option value="d14">14</option>
    <option value="d15">15</option>
    <option value="d16">16</option>
    <option value="d17">17</option>
    <option value="d18">18</option>
    <option value="d19">19</option>
    <option value="d20">20</option>
    <option value="d21">21</option>
    <option value="d22">22</option>
    <option value="d23">23</option>
    <option value="d24">24</option>
    <option value="d25">25</option>
    <option value="d26">26</option>
    <option value="d27">27</option>
    <option value="d28">28</option>
    <option value="d29">29</option>
    <option value="d30">30</option>
    <option value="d31">31</option>
</select>

<br>

<tr>CVV: </tr>
<form method="post" action="order.jsp">
<input type="text" name="cvv" size="3" maxlength="3">

<br>

<h1>Enter your shipping information</h1>

<tr>Street Address: </tr>
<form method="post" action="order.jsp">
<input type="texT" name="address">

<br>

<tr>Province </tr>
<form method="post" action="order.jsp">
<select name="prov" id="prov">
    <option value="NL">NL</option>
    <option value="PE">PE</option>
    <option value="NS">NS</option>
    <option value="NB">NB</option>
    <option value="QC">QC</option>
    <option value="ON">ON</option>
    <option value="MB">MB</option>
    <option value="SK">SK</option>
    <option value="AB">AB</option>
    <option value="BC">BC</option>
    <option value="YT">YT</option>
    <option value="NT">NT</option>
    <option value="NU">NU</option>
</select>

<br>

<tr>City: </tr>
<form method="post" action="order.jsp">
<input type="text" name="city">

<br>

<tr>Postal/Zip Code: </tr>
<form method="post" action="order.jsp">
<input type="text" name="postalCode">

<br>

<input type="submit" value="Submit" name="submit2" value="Order"><input type="reset" value="Reset">
</form>

</body>
</html>

