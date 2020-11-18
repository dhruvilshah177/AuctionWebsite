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
<title>Product Q&A</title>
</head>
<body>
<h1>
</h1>
<br>
	
	<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();		 
	

	int ItemID=Integer.parseInt(request.getParameter("itemID"));
	/* out.println("item id is "+ItemID); */
	
	
	
	PreparedStatement select_forum = con.prepareStatement("SELECT * FROM forum where itemID=(?)");		
	select_forum.setInt(1,ItemID);
	ResultSet resultForum = select_forum.executeQuery();
	
	
	%>
	<table>
	<% 
	while(resultForum.next()) {
		%>
		<tr>
		<td>
		<%
		/* out.println("ItemID: "+resultForum.getString("itemID"));  
		out.println("<br/>"); */
		out.println("Question: "+resultForum.getString("question"));
		out.println("<br/>");
		out.println("Answer: "+resultForum.getString("answer"));
		// PASS AUCTION ID TO AUCTION PAGE ON CLICK		
			
		%>
		</td>
		</tr>
		<% 		
	}
	%>
	
	</table>	

<form action= "create_question.jsp?itemID=<%= ItemID %>" method="POST">
			<label for="question">Enter new question</label>
			<input type="text" name="question"> <br>		
			<input type="submit" value="Submit">
		</form>

		
<a href="index.jsp">Go Back to Main Page</a>


</body>
</html>














