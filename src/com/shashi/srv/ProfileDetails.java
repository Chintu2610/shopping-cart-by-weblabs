package com.shashi.srv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shashi.service.impl.ProfileDAO;
import com.shashi.beans.UserBean;

@WebServlet("/ProfileDetails")
public class ProfileDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String email = request.getParameter("email");
		
		ProfileDAO profiledao = new ProfileDAO();
		UserBean profiledetails = profiledao.getProfileByUserName(email);

		// Convert the property details to JSON format
		String jsonResponse = convertPropertyDetailsToJson(profiledetails);
		// Set the content type and write the JSON response
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		out.print(jsonResponse);
		out.flush();
	}

	private String convertPropertyDetailsToJson(UserBean profileDetails) {
		// Convert property details to JSON format
		// You can use a JSON library like Jackson or Gson for more complex objects
		// For simplicity, a basic JSON string is created here
		return "{" +
        "\"fullname\":\"" + profileDetails.getName() + "\"," +
        "\"email\":\"" + profileDetails.getEmail() + "\"," +
        "\"phno\":\"" + profileDetails.getMobile() + "\"," +
        "\"address\":\"" + profileDetails.getAddress() + "\"," +
        "\"pincode\":\"" + profileDetails.getPinCode() + "\"," +
        "\"password\":\"" + profileDetails.getPassword() + "\"" +
        "}";

	}
}
