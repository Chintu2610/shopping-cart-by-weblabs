<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Profile Details</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body style="background-color: #ffd77c4f;">

	<%
	/* Checking the user credentials */
	String email = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (email == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}
%>
	<jsp:include page="header.jsp" />

		
 <form action="EditProfile" method="post">

<div class="main-wrapper">

		 
		 <div class="page-wrapper">
			
				<!-- Page Content -->
                <div class="content container-fluid">

                <!-- Other content or form elements can be placed here -->           						
						<!-- Profile Modal -->
							<div class="row">
								<div class="col-md-12">
									<h2>Edit Profile </h2>
							</div>
							</div>
						 	
						<!-- userID,     ReferrerUsername -->																					
								<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Full Name<span class="text-danger">*</span></label>				
					    				<input type="text" id="fullname" name="fullname" class="form-control" >					       
									</div>
								</div>
								<div class="col-md-6">
								<div class="form-group">
									<label>Email <span class="text-danger">*</span></label>				
					    			<input type="text" id="email" name="email" class="form-control" readonly>					       
								</div>
								</div>
							</div>
							<div class="row">
					<div class="col-md-6">
						<div class="form-group">
							<label>Phone <span class="text-danger">*</span></label>
			       <input type="text" id="phno" name="phno" class="form-control">
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="form-group">
							<label>Address<span class="text-danger">*</span></label>
			       <input type="text" id="address" name="address" class="form-control">
						</div>
					</div>
					</div>	
					
					<div class="row">				
					<div class="col-md-6">
						<div class="form-group">
							<label>PinCode <span class="text-danger">*</span></label>
			       <input type="text" id="pincode" name="pincode" class="form-control">
						</div>
					</div>
					
					<div class="col-md-6">
						<div class="form-group">
						<label>Password <span class="text-danger">*</span></label> 
			       <input type="text" id="password" name="password" class="form-control">
						</div>
					</div>
					
					</div>
					<!-- <div class="row">
					   <div class="col-md-6">
                		<div class="form-group">
                    <label>Confirm Password<span class="text-danger">*</span></label>
                    <input  name="confirm_pass" id="confirm_pass" type="password" class="form-control">
                		</div>
            		</div>
           			 <span id="passwordError" style="color: red;"></span>
					</div> -->
					
										<div class="col-md-12 text-center">
										<div class="form-group">
					                <input type="submit" value="Submit" class="btn btn-primary">
					            </div>
					            </div>
								</div>
						</div>        
       
    </div>

</form>
<!-- Wrapper End --> 

<!--	Js Link
============================================================--> 
<script>
    // Add an event listener to check password match when the confirm password field changes
    document.getElementById("confirm_pass").addEventListener("input", function () {
        validatePasswordMatch();
    });

    // Function to validate password and confirm password match
    function validatePasswordMatch() {
        var password = document.getElementById("password").value;
        var confirmPass = document.getElementById("confirm_pass").value;
        var errorSpan = document.getElementById("passwordError");

        if (password !== confirmPass) {
            errorSpan.textContent = "Passwords do not match";
        } else {
            errorSpan.textContent = "";
        }
    }
</script>
<script>
    $(document).ready(function () {
        showProfileDetails();
    });

    function showProfileDetails() {
        // Get the email from the session
        var email = '<%= email %>'; // Use 'email' directly, not 'session.getAttribute("email")'
        
        // Make sure email is not null before proceeding with AJAX request
        if (email) {
            $.ajax({
                type: 'GET',
                url: 'ProfileDetails?email=' + email,
                dataType: 'json',
                success: function (data) {
                    // Populate the form fields with the retrieved profile details
                    $('[name="fullname"]').val(data.fullname);
                    $('[name="email"]').val(data.email);
                    $('[name="phno"]').val(data.phno);
                    $('[name="address"]').val(data.address);
                    $('[name="pincode"]').val(data.pincode);
                    $('[name="password"]').val(data.password);
                    // Handle other fields as needed
                },
                error: function (error) {
                    console.error('Error fetching profile details:', error);
                }
            });
        } else {
            console.error('Email is null. Cannot fetch profile details.');
        }
    }
</script>

	<br>
	<br>
	<br>

	<%@ include file="footer.html"%>

</body>
</html>
