<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Create Mac Auction</title>
</head>
<body>

	<div class="content">
		<form action="macAuctionCreate.jsp" method="POST">
		<label for="model">Model: </label>
			<select name="model" id="model" required>
				<option value="" disabled selected hidden="true">Select Generation</option>
				<option value="MacBook">MacBook</option>
				<option value="MacBook Air">MacBook Air</option>
				<option value="MacBook Pro">MacBook Pro</option>
				</select> <br> 
		
		<label for="color">Color: </label>
			<select name="color" id="color" required>
				<option value="" disabled selected hidden="true">Select Color</option>
				<option value="Silver">Silver</option>
				<option value="Gold">Gold</option>
				<option value="Space Grey">Space Grey</option>
				<option value="Rose Gold">Rose Gold</option>
				</select> <br> 
		<label for="storage">Storage: </label>
			<select name="storage" id="storage" required>
				<option value="" disabled selected hidden="true">Select Storage Amount</option>
				<option value=128>128 GB</option>
				<option value=256>256 GB</option>
				<option value=512>512 GB</option>
				<option value=1>1 TB</option>
				<option value=2>2 TB</option>
				<option value=2>4 TB</option>
				</select> <br> 
		<label for="size">Size: </label>
			<select name="size" id="size" required>
				<option value="" disabled selected hidden="true">Select Size</option>
				<option value=11>11 in</option>
				<option value=13>13 in</option>
				<option value=15>15 in</option>
				<option value=17>17 in</option>				
			</select>
			
			
		<label for="year">Year: </label>
			<select name="year" id="year" required>
				<option value="" disabled selected hidden="true">Select Size</option>
				<option value=2009>2009</option>
				<option value=2010>2010</option>
				<option value=2011>2011</option>
				<option value=2012>2012</option>				
				<option value=2013>2013</option>
				<option value=2014>2014</option>
				<option value=2015>2015</option>
				<option value=2016>2016</option>
				<option value=2017>2017</option>
				<option value=2018>2018</option>
				<option value=2019>2019</option>
						
				</select>
				
		<label for="ram">RAM: </label>
			<select name="ram" id="ram" required>
				<option value="" disabled selected hidden="true">Select Size</option>
				<option value=2>2 GB</option>
				<option value=4>4 GB</option>
				<option value=8>8 GB</option>
				<option value=16>16 GB</option>
				<option value=32>32 GB</option>
			</select>
		<br>

			
			<!-- RESTRICT HOURS TO WHOLE HOURS --> 
			<label for="endDateTime">Auction Closing: Date & Time (MUST be >1 day from now)</label>
			<input type="datetime-local" name="endDateTime" id="endDateTime" placeholder="yyyy-mm-dd hh:mm:s"> <br>

			<label for="min_price">Minimum Bid Price (hidden from bidders)</label>
			<input type="number" step="0.01" name="min_price" placeholder="0.00" min="0.00" required> <br>	
			<label for="starting_price">Starting Bid Price</label>
			<input type="number" step="0.01" name="starting_price" placeholder="0.00" min="0.00" required> <br>	
			<input type="submit" value="Submit">
		</form>
	</div>


</body>
</html>