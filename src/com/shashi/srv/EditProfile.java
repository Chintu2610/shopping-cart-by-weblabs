package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shashi.service.impl.ProfileDAO;
import com.shashi.beans.UserBean;

@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve parameters from the request
		String fullname = request.getParameter("fullname");
		String email = request.getParameter("email");
		long phno = Long.parseLong(request.getParameter("phno"));
		String address = request.getParameter("address");
		int pincode = Integer.parseInt(request.getParameter("pincode"));
		String password = request.getParameter("password");

		UserBean profile = new UserBean();
		profile.setName(fullname);
		profile.setEmail(email);
		profile.setMobile(phno);
		profile.setAddress(address);
		profile.setPinCode(pincode);
		profile.setPassword(password);

		ProfileDAO profiledao = new ProfileDAO();
		boolean statusMessage = profiledao.updateProfileDetails(profile);

		// Forward the status message to the JSP page
		RequestDispatcher rd = request.getRequestDispatcher("userProfile.jsp?message=" + statusMessage);
		rd.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
