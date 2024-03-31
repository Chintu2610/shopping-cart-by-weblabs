package com.shashi.srv;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shashi.beans.ProductBean;
import com.shashi.service.impl.ProductServiceImpl;

@WebServlet("/filterProduct")
public class FilterProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FilterProduct() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		double minPrice = 0; // Default minimum price
	    double maxPrice = Double.MAX_VALUE; // Default maximum price
	    String minPriceStr = request.getParameter("minPrice");
	    String maxPriceStr = request.getParameter("maxPrice");
		response.setContentType("text/html");
		ProductServiceImpl prodDao = new ProductServiceImpl();
		List<ProductBean> products = new ArrayList<ProductBean>();
		 if (minPriceStr != null && !minPriceStr.isEmpty()) {
		        minPrice = Double.parseDouble(minPriceStr);
		    }

		    if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
		        maxPrice = Double.parseDouble(maxPriceStr);
		    }
			if(minPriceStr!=null && maxPriceStr!=null){
				products=prodDao.getAllProductsByRange(minPriceStr, maxPriceStr);
			}
			request.setAttribute("products", products);
		RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");

		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
