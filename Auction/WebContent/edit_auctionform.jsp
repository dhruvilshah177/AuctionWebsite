<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Edit Auction</title>
</head>
<body>

Enter the auctionID and Secret Upper Limit or End Time that you wish to change:
<br>
	<form method="post" action="edit_auction.jsp">
	<table>
	<tr>    
	<td>Auction ID</td><td><input type="text" name="auctionID"></td>
	</tr>
	<tr>    
	<td>New Secret Lower Limit</td><td><input type="text" name="secretlowlimit"></td>
	</tr>
	<tr>    
	<td>New End Time </td><td><input type="text" name="endtime"></td>
	</tr>
	<tr>    	
	</table>
	<input type="submit" value="Update">
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