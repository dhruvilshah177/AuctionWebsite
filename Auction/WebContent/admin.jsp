<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Admin Privileges</title>
</head>
<body>
<h1>
What would you like to do today?
</h1>
<br>
	
	<table>
	<tr>    
	<td><a href="signup_CR.jsp">Make a Customer Representative</a></td>
	</tr>
	<tr>
	<td><a href="sales_report.jsp">Generate a Sales Report</a></td>
	</tr>	
	</table>
	
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