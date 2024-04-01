 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shashi.beans.AddressBean" %>
<%@ page import="com.shashi.service.impl.AddressDAO" %>
<%@ page import="java.util.List" %>

    
  <!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Address</title>
    <!-- Add your CSS and JavaScript includes here -->
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="assets/logo.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- Lineawesome CSS -->
    <link rel="stylesheet" href="css/line-awesome.min.css">

    <!-- Select2 CSS -->
    <link rel="stylesheet" href="css/select2.min.css">

    <!-- Datetimepicker CSS -->
    <link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- table styles CSS -->
    <link rel="stylesheet" href="css/styles.css">
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/select2.min.js"></script>
   
 </head>
<body>  
    <%
    int start = 0;
    int limit = 25;

    String idFilter = request.getParameter("addressID");
    List<AddressBean> tasksList = null;
    String whereClause = "";

    if (idFilter != null && !idFilter.isEmpty()) {
        whereClause += "addressID = '" + idFilter + "'";
    }

    if (!whereClause.isEmpty()) {
        tasksList = AddressDAO.getFilteredAddress(whereClause, start, limit);
    }

    if (tasksList != null && !tasksList.isEmpty()) {
    	AddressBean task = tasksList.get(0);

        if (task != null) {
%>
    
   
    
<form action="./EditAddressSrv" method="post">
    <div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label">addressID </label>
            <input name="addressID" required class="form-control" type="text"readonly value="<%= task.getAddressID() %>">
        </div>
    </div>

       

    <div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label"> email <span class="text-danger">*</span></label>
            <input name="email" required class="form-control" type="text" value="<%= task.getEmail() %>">
        </div>
    </div>

    
<div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label">street <span class="text-danger">*</span></label>
            <input name="street" required class="form-control" type="text" value="<%= task.getStreet() %>">
        </div>
    </div>
    
    <div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label">city <span class="text-danger">*</span></label>
            <input name="city" required class="form-control" type="text" value="<%= task.getCity() %>">
        </div>
    </div> 
  
    <div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label"> postal_code <span class="text-danger">*</span></label>
            <input name="postal_code" required class="form-control" type="text" value="<%= task.getPostal_code() %>">
        </div>
    </div>

    
<div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label">state <span class="text-danger">*</span></label>
            <input name="state" required class="form-control" type="text" value="<%= task.getState() %>">
        </div>
    </div>
    
    <div class="col-md-6">
        <div class="form-group">
            <label class="col-form-label">hno <span class="text-danger">*</span></label>
            <input name="hno" required class="form-control" type="text" value="<%= task.getHno() %>">
        </div>
    </div> 
  
    <div class="submit-section">
        <button type="submit"  class="btn btn-primary submit-btn">Submit</button>
    </div>
</form>
<%
    HttpSession sessionstatus = request.getSession(true);
    if (sessionstatus.getAttribute("status") != null && sessionstatus.getAttribute("status").equals("provident found Position Updated Successfully!")) {
        response.sendRedirect("appointment.jsp");
    } else {
%>
   <div class="col-sm-6">
        <p>Task not found with the provided ID.</p>
   </div>
<%
    }}}
%>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.slimscroll.min.js"></script>
<script src="js/select2.min.js"></script>
<script src="js/moment.min.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
<script src="js/app.js"></script>
</body>
</html>

		

