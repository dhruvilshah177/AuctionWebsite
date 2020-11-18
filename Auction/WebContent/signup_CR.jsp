<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Sign up</title>
</head>
<body>

Enter the following information to make a Customer Rep (Please be sure to make note of the case):
<br>
	<form method="post" action="make_CR.jsp">
	<table>
	<tr>    
	<td>User name</td><td><input type="text" name="name"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="pass"></td>
	</tr>
	<tr>    
	<td>Email</td><td><input type="text" name="email"></td>
	</tr>
	<tr>    
	<td>Address</td><td><input type="text" name="address"></td>
	</tr>
	<tr>    
	<td>Bank Account Number</td><td><input type="text" name="BAN"></td>
	</tr>
	<tr>    
	<td>Bank Routing Number</td><td><input type="text" name="BRN"></td>
	</tr>
	<tr>    
	<td>Phone Number</td><td><input type="text" name="phone"></td>
	</tr>
	<tr>    	
	</table>
	<input type="submit" value="Sign up">
	</form>
<br>

<h2> <%
		if(null != request.getAttribute("errorMessage")) {
			out.println(request.getAttribute("errorMessage"));
		}	
%></h2>

<br>

<a href="index.jsp">Go Back to Main Page</a>
<br>
<a href="admin.jsp">Go Back to Admin Page</a>

</body>
</html>