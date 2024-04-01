
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
@WebServlet("/DeleteAddressSrv")
public class DeleteAddressSrv  extends HttpServlet {

	    private static final long serialVersionUID = 1L;

	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	  
	    	String addressID = request.getParameter("addressID");

	    	DeleteAddressSrv department = new DeleteAddressSrv();

			String status = department.deleteaddress(addressID);
			
	        RequestDispatcher rd = request.getRequestDispatcher("address.jsp?message=" + status);
	        rd.forward(request, response);
	    }

	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        doGet(request, response);
	    }
	


public String deleteaddress(String addressID) {
    String status = "Address Removal Failed!";

    Connection con = DBUtil.provideConnection();
    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("DELETE FROM address WHERE addressID = ?");
        ps.setString(1, addressID);

        int k = ps.executeUpdate();

        if (k > 0) {
            status = "Address Removed Successfully!";
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
