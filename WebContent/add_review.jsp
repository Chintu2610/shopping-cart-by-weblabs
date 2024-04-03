<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
	<%
String uid = request.getParameter("uid");
String pid = request.getParameter("pid");


%>
<!DOCTYPE html>
<html>
<head>
<title>Review</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	
<style>
/* Styles for the star rating */
.rating > span {
  display: inline-block;
  position: relative;
  width: 1.1em;
  font-size: 25px;
}
.rating > span:hover:before,
.rating > span:hover ~ span:before {
   content: "\2605";
   position: absolute;
   color: gold;
}
</style>
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
			
			 <form action="AddRatingSrv" method="post" 
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
<!-- 						<img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
 -->						<h2 style="color: green;">Add Review</h2>
					</div>
				</div>
				
				 
				<div class="row">
					<div class="col-md-12 form-group">
						<!-- <label > Email</label>  -->
						<input type="hidden" name="email" value="<%=uid%>">
						<!-- <input type="text"  name="email" class="form-control"  required> -->
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12 form-group">
						<!-- <label > Product Id</label>  -->
						<input type="hidden" name="pid" value="<%=pid%>">
					</div>
				</div>
				
					<div class="row">
    <div class="col-md-12 form-group">
        <label>Add rating</label> 
        <div class="rating">
            <span data-value="1">&#9734;</span>
            <span data-value="2">&#9734;</span>
            <span data-value="3">&#9734;</span>
            <span data-value="4">&#9734;</span>
            <span data-value="5">&#9734;</span>
        </div>
        <input type="hidden" name="rating" value="">
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const stars = document.querySelectorAll('.rating > span');
        const ratingInput = document.querySelector('input[name="rating"]');

        stars.forEach(function (star) {
            star.addEventListener('click', function () {
                const value = parseInt(star.getAttribute('data-value'));
                ratingInput.value = value;
                // Update star appearance based on selection
                stars.forEach(function (s) {
                    const sValue = parseInt(s.getAttribute('data-value'));
                    if (sValue <= value) {
                        s.innerHTML = '&#9733;';
                    } else {
                        s.innerHTML = '&#9734;';
                    }
                });
            });
        });
    });
</script>

				
				<div class="row">
					<div class="col-md-12 form-group">
						<label > Comments</label> 
						<input type="text"  name="comments" class="form-control"  required>
					</div>
				</div>
				
				
					<div class="col-md-12 text-center">
										<div class="form-group">
					                <input type="submit" value="Submit" class="btn btn-primary">
					            </div>
					            </div>

			</form>
			
		<%-- 	<% 
			List<RatingBean> x = RatingDAO.getCommentsByProductId(pid);
			for (RatingBean aaaa : x) {
			%>
			<div class="col-md-12 text-center"><div class="form-group">
		            xx=	<%=aaaa.getComments() %>
			 </div> </div>
			
			<%} %> --%>
			
		</div>
	</div>
	
	
	
<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Reviews</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #115884; color: white; font-size: 18px;">
										<tr>
											 <th>Name</th>
									       
									        <th>Rating</th>
									       
									        <th>Comments</th>
									<!--         <th>Edit</th>
									         <th>Delete</th>    --> 
										</tr>
									</thead>
	<% 
			List<RatingBean> x = RatingDAO.getCommentsByProductId(pid);
			for (RatingBean aaaa : x) {
			%>
			
			
<tr>
  	<td><%=aaaa.getName() %></td>
  
   <td><%=aaaa.getRating() %></td>
 
   <td><%=aaaa.getComments() %></td>


</tr>
<%
}
%>

								</table>
								
								</div></div>
	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>

</body>
</html>