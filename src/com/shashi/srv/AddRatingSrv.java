

package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shashi.service.impl.RatingServiceImpl;

@WebServlet("/AddRatingSrv")
public class AddRatingSrv extends HttpServlet {
	
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	String status1 = "Add  Failed!";
    	 String rating = request.getParameter("rating");
        String email = request.getParameter("email");
        String pid = request.getParameter("pid");
         String comments = request.getParameter("comments");
       
        RatingServiceImpl add = new RatingServiceImpl();
        status1 = add.addV( rating, email, pid,comments);

        RequestDispatcher rd = request.getRequestDispatcher("userHome.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}








