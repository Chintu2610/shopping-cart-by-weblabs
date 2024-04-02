<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.AddressServiceImpl" %>
<%@ page import="com.shashi.service.impl.AddressDAO" %>
<%@ page import="com.shashi.beans.AddressBean" %>
<%@ page import="java.util.List" %>

<%
String userName = request.getParameter("userName");
String amount = request.getParameter("amount");

   /*  String userName = (String)session.getAttribute("username"); */
%>
<!DOCTYPE html>
<html lang="en">
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
HttpSession sessionRec = request.getSession(true);

// Initialize recordsPerPage and currentPage as Java variables
String recordsPerPageStr = (String) sessionRec.getAttribute("recordsPerPage");
String currentPageStr = (String) sessionRec.getAttribute("currentPage");

if (recordsPerPageStr == null || "0".equals(recordsPerPageStr)) {
    recordsPerPageStr = "10"; // Set a default value, e.g., 1
    sessionRec.setAttribute("recordsPerPage", recordsPerPageStr);
}
int recordsPerPage = Integer.parseInt(recordsPerPageStr);

if (currentPageStr == null || "0".equals(currentPageStr)) {
    currentPageStr = "1"; // Set a default value, e.g., 1
    sessionRec.setAttribute("currentPage", currentPageStr);
}
int currentPage = Integer.parseInt(currentPageStr);

// Handle the change in recordsPerPage here
int newRecordsPerPage = 10; // Default value
String newRecordsPerPageParam = request.getParameter("newRecordsPerPage");
if (newRecordsPerPageParam != null) {
    newRecordsPerPage = Integer.parseInt(newRecordsPerPageParam);
    sessionRec.setAttribute("recordsPerPage", String.valueOf(newRecordsPerPage));
    //currentPage = 1; // Reset to the first page when changing recordsPerPage
    //sessionRec.setAttribute("currentPage", "1");
}

%>
 <jsp:include page="header.jsp" />
<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			

			<!-- 	<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						<img src="images/profile.jpg" alt="Payment Proceed" height="100px" />
						<h2 style="color: green;"> Address</h2>
					</div>
				</div> -->
				
<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Select
		Address</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #115884; color: white; font-size: 18px;">
										<tr>
											<th>Select</th>
											<th>addressID</th>
											<!-- <th>email </th> -->
									        <th>street</th>
									        <th>city</th>
									        <th>postal_code</th>
									        <th>state</th>
									        <th>hno</th>
									        <th>Edit</th>
									         <th>Delete</th>    
										</tr>
									</thead>
<%
int start = currentPage;
int limit = newRecordsPerPage;
// pagenation code start
int pageno = 1;
int noOfPages = 0;

String pageNoStr = request.getParameter("page");

if (pageNoStr != null) {
    pageno = Integer.parseInt(pageNoStr);
}

start = (pageno - 1) * limit;
// pagenation code ended
String usernameFilter = request.getParameter("description");
String idFilter = request.getParameter("workerID");
List<AddressBean> tax;

String whereClause = ""; // Initialize an empty whereClause

if (usernameFilter != null && !usernameFilter.isEmpty()) {
    whereClause = "description like '%" + usernameFilter + "%'";
}

if (idFilter != null && !idFilter.isEmpty()) {
    if (!whereClause.isEmpty()) {
        whereClause += " or ";
    }
    whereClause += "workerID = '" + idFilter + "'";
}
// page
int recordcount = AddressDAO.totalCount();

noOfPages = (int) Math.ceil((double) recordcount / limit);
// pagee
if (!whereClause.isEmpty()) {
    // Apply the whereClause condition
	  tax = AddressDAO.getFilteredAddress(whereClause, start, limit);
} else {
    // Retrieve all data based on the limit
	 tax = AddressDAO.getFilteredAddress("", start, limit);
}

for (AddressBean tasks : tax) {
	
%>
<tr>
 			<td>
 			<input type="radio" name="addressID" value="<%= tasks.getAddressID() %>" onclick="updateSelectedAddressID(this)">
            <%-- <input type="radio" name="addressID" value="<%=tasks.getAddressID()%>"> --%>
       	 </td>
    <td><%=tasks.getAddressID() %></td>
    <%--  <td><%=tasks.getEmail() %></td>   --%>
    <td><%=tasks.getStreet() %></td>
    <td><%=tasks.getCity() %></td>
    <td><%=tasks.getPostal_code() %></td>
    <td><%=tasks.getState() %></td>
    <td><%=tasks.getHno() %></td>
   <td>
        <a href="address_edit.jsp?addressID=<%= tasks.getAddressID() %>">Edit</a>
    </td> 
    <td>
        <a href="DeleteAddressSrv?addressID=<%= tasks.getAddressID() %>">Delete</a> 
    </td>
</tr>
<%
}
%>

								</table>
								<form action="merchant_payment" method="post">
 								<input type="hidden" name="userName" value="<%= userName %>">
    							<input type="hidden" name="amount" value="<%= amount %>">
    							<input type="hidden" name="addressID" id="selectedAddressID" value="">
										<div class="col-md-12 text-center">
										<div class="form-group">
					                <input type="submit" value="Pay" class="btn btn-primary">
					            </div>
					            </div>
					            </form>
<script>
function updateSelectedAddressID(radioButton) {
    // Get the selected address ID
    var selectedAddressID = radioButton.value;
    // Set the value of the hidden input field
    document.getElementById("selectedAddressID").value = selectedAddressID;
}
</script>
</div>
							</div>
						</div>
					</div>
		
	<%@ include file="footer.html"%>
	


    </body>
</html>