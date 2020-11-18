<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Login</title>
</head>
<body>

Enter your User Name and Password below (Case Sensitive):

<br>
	<form method="post" action="login.jsp">
	<table>
	<tr>    
	<td>User name</td><td><input type="text" name="name"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="text" name="pass"></td>
	</tr>	
	</table>
	<input type="submit" value="Log in">
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