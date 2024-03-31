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

@WebServlet("/sortProductSrv")
public class SortProductSrv extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SortProductSrv() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
	    String sortOption = request.getParameter("sortOptions");
	    
	    
		response.setContentType("text/html");
		ProductServiceImpl prodDao = new ProductServiceImpl();
		List<ProductBean> products = new ArrayList<ProductBean>();
		products=prodDao.getAllProductsByOrder(sortOption);
		
		 
			request.setAttribute("sortProducts", products);
		RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");

		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
