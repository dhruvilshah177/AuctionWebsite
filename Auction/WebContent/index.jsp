<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Auction</title>
</head>
<body>
<h2>
Welcome to the Main Page.
Please choose from the following.
</h2>
<br>

<a href="sign.jsp">SIGNUP</a>
<br>

<%
try {	
	String checker = (String) session.getAttribute("loggedIn");	
	//out.print(session.getAttribute("loggedIn"));
	if(checker == null) {
		%>
		<a href="log.jsp">LOGIN</a>
		<br>
		<%
	} else if(checker.equals("true")) {
		%>
		<a href="logout.jsp">LOGOUT</a> <br>
		<a href="iphoneAuction.jsp">Post an iPhone Auction!</a> <br>
		<a href="ipadAuction.jsp">Post an iPad Auction!</a>   <br>
		<a href="macbookAuction.jsp">Post a MacBook Auction!</a>  <br>
		<a href="browse.jsp">Browse current auctions!</a> <br>
		<a href="alert.jsp">Check your alerts!</a> <br>
		<a href="setAlert.jsp">Set an alert for a desired product!</a> <br>
			
		

<a href="index.jsp">Go Back to Main Page</a>
		<br>
		<%
	} else {
		%>
		<a href="log.jsp">LOGIN</a>
		<br>
		<%
	}
	checker = (String) session.getAttribute("isAdmin");
	if(checker != null && checker.equals("true")) {
		%>
		<a href="admin.jsp">ADMIN PAGE</a>
		<br>
		<%
	}
	checker = (String) session.getAttribute("isRep");
	if(checker != null && checker.equals("true")) {
		%>
		<a href="CR.jsp">CUSTOMER REP PAGE</a>
		<br>
		<%
	}
	
	
} catch (Exception ex) {
	out.print(ex);
	out.print("Failed");
}
%>


</body>
</html>