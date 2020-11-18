<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Edit Account Info</title>
</head>
<body>
Enter the memberID and any fields that you wish to edit for the corresponding account:
<br>
	<form method="post" action="update_Account.jsp">
	<table>
	<tr>    
	<td>MemberID</td><td><input type="text" name="memberID"></td>
	</tr>
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
	<input type="submit" value="Update Account">
	</form>
<br>
	
<h2> <%
		if(null != request.getAttribute("errorMessage")) {
			out.println(request.getAttribute("errorMessage"));
		}	
%></h2>

<br>


<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>