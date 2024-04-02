<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Address</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #fff;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
	%>



	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			
			 <form action="./AddAddressSrv" method="post" 
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						<img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
						<h2 style="color: green;">Add Address</h2>
					</div>
				</div>
				
				 
				<div class="row">
					<div class="col-md-12 form-group">
						<!-- <label > Email</label> --> 
						<input type="hidden" name="email" value="<%=userName%>">
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12 form-group">
						<label > Street</label> 
						<input type="text"  name="street" class="form-control"  required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label > City</label> 
						<input type="text"  name="city" class="form-control"  required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label > Postal Code</label> 
						<input type="text"  name="postal_code" class="form-control"  required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label > State</label> 
						<input type="text"  name="state" class="form-control"  required>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12 form-group">
						<label > Hno</label> 
						<input type="text"  name="hno" class="form-control"  required>
					</div>
				</div>
				
					<div class="col-md-12 text-center">
										<div class="form-group">
					                <input type="submit" value="Submit" class="btn btn-primary">
					            </div>
					            </div>

			</form>
		</div>
	</div>

	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>

</body>
</html>