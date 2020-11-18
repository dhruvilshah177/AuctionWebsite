<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css?v=1.0"/>
<title>Create Iphone Auction</title>
</head>
<body>

	<div class="content">
		<form action="AuctionCreate.jsp" method="POST">
		<label for="generation">Generation: </label>
			<select name="generation" id="generation" required>
				<option value="" disabled selected hidden="true">Select Generation</option>
				<option value="iPhone 4">4</option>
				<option value="iPhone 4s">4s</option>
				<option value="iPhone 5">5</option>
				<option value="iPhone 5s">5s</option>
				<option value="iPhone 6">6</option>
				<option value="iPhone 6 Plus">6 Plus</option>
				<option value="iPhone 6s">6s</option>
				<option value="iPhone 6s Plus">6s Plus</option>
				<option value="iPhone 7">7</option>
				<option value="iPhone 7 Plus">7 Plus</option>
				<option value="iPhone 8">8</option>
				<option value="iPhone 8 Plus">8 Plus</option>
				<option value="iPhone X">X</option>
				<option value="iPhone XS">XS</option>
				<option value="iPhone XS Max">XS Max</option>			</select> <br> 
		
		<label for="color">Color: </label>
			<select name="color" id="color" required>
				<option value="" disabled selected hidden="true">Select Color</option>
				<option value="Black">Black</option>
				<option value="White">White</option>
				<option value="Silver">Silver</option>
				<option value="Gold">Gold</option>
				<option value="Space Grey">Space Grey</option>
				<option value="Rose Gold">Rose Gold</option> </select> <br>

		<label for="storage">Storage: </label>
			<select name="storage" id="storage" required>
				<option value="" disabled selected hidden="true">Select Storage Amount</option>
				<option value=8>8 GB</option>
				<option value=16>16 GB</option>
				<option value=32>32 GB</option>
				<option value=64>64 GB</option>
				<option value=128>128 GB</option>
				<option value=256>256 GB</option>
				<option value=512>512 GB</option>
				</select> <br> 


			
			<!-- RESTRICT HOURS TO WHOLE HOURS --> 
			<label for="endDateTime">Auction Closing: Date & Time (MUST be >1 day from now)</label>
			<input type="datetime-local" name="endDateTime" id="endDateTime" placeholder="yyyy-mm-dd HH:mm:ss"> <br>

			<label for="min_price">Minimum Bid Price (hidden from bidders)</label>
			<input type="number" step="0.01" name="min_price" placeholder="0.00" min="0.00" required> <br>	
			<label for="starting_price">Starting Bid Price</label>
			<input type="number" step="0.01" name="starting_price" placeholder="0.00" min="0.00" required> <br>	
			<input type="submit" value="Submit">
		</form>
	</div>
	

</body>
</html>