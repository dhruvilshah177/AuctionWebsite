<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Alerts</title>
</head>
<body>
You have recieved the following alerts.
<h1>
</h1>
<br>
	
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();		 
	

	/* int ItemID=Integer.parseInt(request.getParameter("itemID"));
	out.println("item id is "+ItemID); */
	

	int MemberID=(Integer) session.getAttribute("id");	
	PreparedStatement select_alerts= con.prepareStatement("SELECT * FROM alert where memberID=(?)");		
	select_alerts.setInt(1,MemberID);
	ResultSet resultAlerts = select_alerts.executeQuery();
	
	
	%>
	<table>
	<% 
	while(resultAlerts.next()) {
		%>
		<tr>
		<td>
		<%
		out.println("AlertID: "+resultAlerts.getString("alertID"));  
		out.println("<br/>");
		/* out.println("MemberID: "+resultAlerts.getString("memberID"));
		out.println("<br/>"); */
		out.println("ItemID: "+resultAlerts.getString("itemID"));
		out.println("<br/>");
		out.println("Content: "+resultAlerts.getString("content"));
		out.println("<br/>");
		out.println("Time: "+resultAlerts.getString("time"));
		
		// PASS AUCTION ID TO AUCTION PAGE ON CLICK		
			
			
	}
	%>
	
	</table>	



		
<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>














