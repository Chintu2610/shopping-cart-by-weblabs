
package com.shashi.srv;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.shashi.utility.DBUtil;

import javax.servlet.RequestDispatcher;
@WebServlet("/DeleteRatingSrv")
public class DeleteRatingSrv  extends HttpServlet {

	    private static final long serialVersionUID = 1L;

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	  
	    	String email = request.getParameter("email");

	    	DeleteRatingSrv department = new DeleteRatingSrv();

			String status = department.deleteV(email);
			
	        RequestDispatcher rd = request.getRequestDispatcher("review.jsp?message=" + status);
	        rd.forward(request, response);
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        doGet(request, response);
	    }
	

public String deleteV(String email) {
    String status = "Address Removal Failed!";

    Connection con = DBUtil.provideConnection();
    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("DELETE FROM review WHERE email = ?");
        ps.setString(1, email);

        int k = ps.executeUpdate();

        if (k > 0) {
            status = " Removed Successfully!";
        }
    } catch (SQLException e) {
        status = "Error: " + e.getMessage();
        e.printStackTrace();
    } finally {
        DBUtil.closeConnection(con);
        DBUtil.closeConnection(ps);
    }

    return status;
}

}
