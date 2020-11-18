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

		//Get parameters from the HTML form at the HelloWorld.jsp
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String bAN = request.getParameter("BAN");
		String bRN = request.getParameter("BRN");
		String phone = request.getParameter("phone");
		
		if (name.equals("") || pass.equals("") || email.equals("") || address.equals("") || bAN.equals("") || bRN.equals("") || phone.equals("")) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "You did not finish the form. Please finish it.");
			RequestDispatcher rd = request.getRequestDispatcher("/sign.jsp");
			rd.forward(request, response);
		}
		
		if(phone.length() != 10) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "Phone Number invalid. Please enter correct number.");
			RequestDispatcher rd = request.getRequestDispatcher("/sign.jsp");
			rd.forward(request, response);
		} else if (!email.contains("@")) {
			con.close();
			session.invalidate();
			request.setAttribute("errorMessage", "Email invalid. Please enter email.");
			RequestDispatcher rd = request.getRequestDispatcher("/sign.jsp");
			rd.forward(request, response);
		} 
		
		
		PreparedStatement select_name = con.prepareStatement("SELECT name1 FROM member WHERE name1 = (?)");
		select_name.setString(1, name);
				

		ResultSet result_name = select_name.executeQuery();
		
		while(result_name.next()) {
			if(name.equals(result_name.getString("name1"))) {
				con.close();
				session.invalidate();
				request.setAttribute("errorMessage", "Username already taken. Please choose another.");
				RequestDispatcher rd = request.getRequestDispatcher("/sign.jsp");
				rd.forward(request, response);
				break;
			}		
		}
		
		String insert = "";		
		
		
		//Make an insert statement for the Sells table:
		
		insert = "INSERT INTO member(memberID, name1, pass, email, phone, homeAddress, bankAccountNum, bankRoutingNum, isRep, isAdmin)"
				+ "VALUES (0, ?, ?, ?, ?, ?, ?, ?, 1, 0)";
		
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, name);
		ps.setString(2, pass);
		ps.setString(3, email);
		ps.setString(4, phone);
		ps.setString(5, address);
		ps.setString(6, bAN);
		ps.setString(7, bRN);
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		out.print("Sign Up Successful!");
		request.setAttribute("errorMessage", null);		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed :()");
	}
%>

<br>

<a href="index.jsp">Go Back to Main Page</a>

</body>
</html>