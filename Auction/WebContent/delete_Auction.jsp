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

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		int aucID = Integer.parseInt(request.getParameter("auctionID"));
		
		String delete="DELETE FROM auction where auctionID=?";
		PreparedStatement deleteAuction = con.prepareStatement(delete);
		deleteAuction.setInt(1, aucID);
		deleteAuction.executeUpdate(); 
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Auction Deletion Successful!");
		request.setAttribute("errorMessage", null);		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Deletion failed :()");
	}
%>

<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>