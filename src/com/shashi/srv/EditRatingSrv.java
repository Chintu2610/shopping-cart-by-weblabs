
package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shashi.beans.RatingBean;
import com.shashi.service.impl.RatingServiceImpl;
			
@WebServlet("/EditRatingSrv")
public class EditRatingSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	 String rating = request.getParameter("rating");
         String email = request.getParameter("email");
         String pid = request.getParameter("pid");
         String comments = request.getParameter("comments");
         RatingBean dept = new RatingBean();
        
        dept.setRating(rating);
        dept.setEmail(email);
        dept.setPid(pid);
        dept.setComments(comments);
        RatingServiceImpl dao = new RatingServiceImpl();
   
        String status2 = dao.editV( rating, email, pid,comments);
        RequestDispatcher rd = request.getRequestDispatcher("add_review.jsp");
        rd.forward(request, response);
      
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}