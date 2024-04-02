
package com.shashi.srv;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shashi.beans.AddressBean;
import com.shashi.service.impl.AddressServiceImpl;
			
@WebServlet("/EditAddressSrv")
public class EditAddressSrv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

       // String status1 = "Edit Failed!"; 
        String addressID= request.getParameter("addressID");
        String email = request.getParameter("email");
        String street = request.getParameter("street");
        String city = request.getParameter("city");
        String postal_code = request.getParameter("postal_code");
        String state = request.getParameter("state");
        String hno = request.getParameter("hno");
        
        AddressBean dept = new AddressBean();
        
        dept.setAddressID(addressID);
        dept.setEmail(email);
        dept.setStreet(street);
        dept.setCity(city);
        dept.setPostal_code(postal_code);
        dept.setState(state);
        dept.setHno(hno);
        AddressServiceImpl dao = new AddressServiceImpl();
   
        String status2 = dao.editV(addressID, email, street, city, postal_code, state, hno);
        RequestDispatcher rd = request.getRequestDispatcher("address.jsp");
        rd.forward(request, response);
      
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}