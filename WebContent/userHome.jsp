<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
    <script>
     function generateStarRating(averageRating, containerId) {
            console.log("Average Rating: " + averageRating);
            var starRatingContainer = document.getElementById(containerId);
            starRatingContainer.innerHTML = ""; // Clear any existing stars

            var totalStars = 5;
            var fullStars = Math.floor(averageRating); // Number of full stars
            var remainder = averageRating - fullStars; // Fractional part for half star

            // Add full stars
            for (var i = 0; i < fullStars; i++) {
                starRatingContainer.innerHTML += '<span class="fa fa-star checked"></span>';
            }

            // Add half star if needed
            if (remainder >= 0.25 && remainder <= 0.75) {
                starRatingContainer.innerHTML += '<span class="fa fa-star-half checked"></span>';
                fullStars++; // Increment fullStars to maintain the total count
            }

            // Add empty stars to fill up the remaining space
            for (var i = fullStars; i < totalStars; i++) {
                starRatingContainer.innerHTML += '<span class="fa fa-star"></span>';
            }
        }
     
    </script>
    
    

     <style>
    .star-rating {
        font-size: 24px; /* Adjust the font size as needed */
    }

    .fa-star {
        color: #ccc; /* Color of empty star */
    }

    .checked {
        color: gold; /* Color of filled star */
    }
</style> 
<!-- <script>  
    // Function to fetch user count using AJAX
    function fetchUserCount(userRatingcount, productId) {
    	console.log("userRatingcount: " + userRatingcount+"pid"+productId);
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
        	debugger;
            if (this.readyState == 4 && this.status == 200) {
            	
                var userCountElement = document.getElementById('userCount_' + productId);
                userCountElement.innerHTML = 'User Count: ' + this.responseText;
            }
        };
     /*    xhttp.open("GET", "getUserCount?productId=" + productId, true);
        xhttp.send(); */
    }
</script> -->
    
</head>
<body style="background-color: #ffd77c4f;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductBean> products = new ArrayList<ProductBean>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "All Products";
	if (search != null) {
		products = prodDao.searchAllProducts(search);
		message = "Showing Results for '" + search + "'";
	} else if (type != null) {
		products = prodDao.getAllProductsByType(type);
		message = "Showing Results for '" + type + "'";
	}else
		if(request.getAttribute("sortProducts")!=null)
		{
			products = (List<ProductBean>) request.getAttribute("sortProducts");
		}else
	
	if(request.getAttribute("products")!=null)
	{
		products = (List<ProductBean>) request.getAttribute("products");
	}
	
	else {
		products = prodDao.getAllProducts();
	}
	
	
	 double minPrice = 0; // Default minimum price
	    double maxPrice = Double.MAX_VALUE; // Default maximum price
	    String minPriceStr = request.getParameter("minPrice");
	    String maxPriceStr = request.getParameter("maxPrice");

	   
		/* if (products.isEmpty()) {
			message = "No items found for the search '" + (search != null ? search : type) + "'";
			filteredProducts = prodDao.getAllProducts();
		} */
	
	if (products.isEmpty()) {
		message = "No items found for the search '" + (search != null ? search : type) + "'";
		products = prodDao.getAllProducts();
	}
	%>



	<jsp:include page="header.jsp" />

	<div class="text-center"
		style="color: black; font-size: 14px; font-weight: bold;"><%=message%></div>
	<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
 		<!-- Price Range Filter -->
   <div class="container" style="margin-bottom:20px">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <form method="get" id="priceFilterForm" class="form-inline text-center" action="./filterProduct">
                <div class="form-group">
                    <label for="minPrice">Min Price:</label>
                    <input type="text" class="form-control" id="minPrice" name="minPrice" placeholder="Min">
                </div>
                <div class="form-group">
                    <label for="maxPrice">Max Price:</label>
                    <input type="text" class="form-control" id="maxPrice" name="maxPrice" placeholder="Max" >
                </div>
                
            </form>
        </div>
    </div>
</div>

<div class="container" style="margin-bottom:20px">
    <div class="row">
        <div class="col-md-6 col-md-offset-3">
            <div class="form-inline text-center">
                <div class="form-group">
                <form method="get" id="priceFilterForm" class="form-inline text-center" action="./sortProductSrv">
                    <label for="sortOptions">Sort By:</label>
                    <select class="form-control" id="sortOptions" name="sortOptions">
                        <option value="lowToHigh">Price: Low to High</option>
                        <option value="highToLow">Price: High to Low</option>
                        <!-- <option value="avgCustomerReview">Avg. Customer Review</option>
                        <option value="newestArrivals">Newest Arrivals</option> -->
                    </select>
                    <button id="sortButton" class="btn btn-primary">Sort</button>
                    </form>
                </div>
                
            </div>
        </div>
    </div>
</div>


   
 
  <script>
       
            $('#maxPrice').keypress(function (event) {
                if (event.keyCode === 13) { // Enter key pressed
                    event.preventDefault();
                    applyPriceFilter();
                }
            });

            function applyPriceFilter() {
                var minPrice = parseFloat($('#minPrice').val());
                var maxPrice = parseFloat($('#maxPrice').val());

                if (minPrice > maxPrice) {
                    alert("Minimum price cannot be greater than maximum price!");
                    return;
                }

                $('#priceFilterForm').submit();
            }
            /* $('#sortOptions').change(function() {
                $('#priceFilterForm').submit(); // Submit the form when selection changes
            }); */
        
    </script>
 
 
	<!-- Start of Product Items List -->
	<div class="container">
		<div class="row text-center">

			<%
			int  userRatingcount =0;
			for (ProductBean product : products) {
				int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
				  double averageRating = RatingDAO.getAverageRatingByProductId(product.getProdId());
				    userRatingcount = RatingDAO.getUserCountByEmail(product.getProdId());
			%>
			<div class="col-sm-4" style='height: 350px;'>
				<div class="thumbnail">
					<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
						style="height: 150px; max-width: 180px">
					<p class="productname"><%=product.getProdName()%>
					</p>
					<%
					String description = product.getProdInfo();
					description = description.substring(0, Math.min(description.length(), 100));
					%>
					<p class="productinfo"><%=description%>..
					</p>
					<p class="price">
						Rs
						<%=product.getProdPrice()%>
					</p>
					
					

  <span class="star-rating" id="starRating_<%=product.getProdId()%>"></span>&nbsp;&nbsp;(<span><%=userRatingcount%></span>)
  
<div id="userCount_<%=product.getProdId()%>"></div>
 <%-- <div id="userCount_<%=product.getProdId()%>"></div> --%>
 
                <script>
                    generateStarRating(<%= averageRating %>, 'starRating_<%=product.getProdId()%>');
                    
                  <%--   fetchUserCount(<%= userRatingcount %>, 'userCount_<%= product.getProdId() %>'); --%>
                </script> 











					<form method="post">
						<%
						if (cartQty == 0) {
						%>
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-success">Add to Cart</button>
						&nbsp;&nbsp;&nbsp;
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-primary">Buy Now</button>&nbsp;&nbsp;&nbsp;

                         <button type="submit"
							formaction="add_review.jsp?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							style="background-color: orange;" class="btn btn-primary">Add Review</button>
							<%-- <h1><%=userRatingcount %></h1><br> --%>
						<%} else {
						%>
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0"
							class="btn btn-danger">Remove From Cart</button>
						&nbsp;&nbsp;&nbsp;
						<button type="submit" formaction="cartDetails.jsp"
							class="btn btn-success">Checkout</button>
						<%
						}
						%>
						
					</form>
					<br />
				</div>
			</div>

			<%
			}
			%>

		</div>
	</div>
	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>

</body>
</html>