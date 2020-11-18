<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title></title>
</head>
<body>
	<%
	try {		
		session.setAttribute("loggedIn", "false"); 	
		request.setAttribute("errorMessage", null);
		session.setAttribute("isRep", "false");
		session.setAttribute("isAdmin", "false");
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
		rd.forward(request, response);
		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Login failed");
	}
	%>
<br>
<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>