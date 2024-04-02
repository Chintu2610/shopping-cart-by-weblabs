package com.shashi.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shashi.beans.AddressBean;
import com.shashi.utility.DBUtil;

public class AddressDAO {

	
	 public static List<AddressBean> getAddressByCustomerID(String email) {
		    List<AddressBean> customerAddresses = new ArrayList<>();
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    ResultSet resultSet = null;

		    try {
		        connection = DBUtil.provideConnection();
		        String query = "SELECT addressID, email, street, city, postal_code, state, hno FROM address WHERE email = ?;";
		        
		        preparedStatement = connection.prepareStatement(query);
		        preparedStatement.setString(1, email);
		        resultSet = preparedStatement.executeQuery();

		        while (resultSet.next()) {
		        	AddressBean vehicle = new AddressBean();
		            vehicle.setAddressID(resultSet.getString("addressID"));
		            vehicle.setEmail(resultSet.getString("email"));
		            vehicle.setStreet(resultSet.getString("street"));
		            vehicle.setCity(resultSet.getString("city"));
		            vehicle.setPostal_code(resultSet.getString("postal_code"));
		            vehicle.setState(resultSet.getString("state"));
		            vehicle.setHno(resultSet.getString("hno"));
		            
		            customerAddresses.add(vehicle);
		        }
		    } catch (Exception e) {
		        // Handle exceptions
		        e.printStackTrace();
		    } finally {
		        // Close database resources (connection, statement, result set)
		        try {
		            if (resultSet != null) resultSet.close();
		            if (preparedStatement != null) preparedStatement.close();
		            if (connection != null) connection.close();
		        } catch (Exception e) {
		            // Handle exceptions
		            e.printStackTrace();
		        }
		    }

		    return customerAddresses;
		}
	 public static int totalCount() {
		 int count = 0;
		 Connection connection = null;
	        PreparedStatement ps = null;
	        ResultSet rs = null;
		 try {
			 connection = DBUtil.provideConnection();
		   String query = "select count(*) as count from appointment";
		 ps = connection.prepareStatement(query);
		 rs = ps.executeQuery();
		 while (rs.next()) {
		 count = rs.getInt("count");
		 }
		 } catch (Exception e) {
		 e.printStackTrace();
		 } finally {
		 try {
			 connection.close();
		 } catch (SQLException ex) {
		 ex.printStackTrace();
		 }
		 }
		 return count;
		 }
	 
	 public static List<AddressBean> getFilteredAddress(String whereClause, int start, int limit) {
	        List<AddressBean> FilteredAppointments = new ArrayList<>();
	        Connection connection = null;
	        PreparedStatement preparedStatement = null;
	        ResultSet resultSet = null;
	       
	        try {
	            connection = DBUtil.provideConnection();
	            String query;
	            if (whereClause != null && !whereClause.isEmpty()) {
	                query = "SELECT addressID, email, street, city, postal_code, state, hno FROM address WHERE " + whereClause + " LIMIT ? , ?;";
	               
	            } else {
	                query = "SELECT addressID, email, street, city, postal_code, state, hno FROM address LIMIT ? , ?;";
	            }

	            preparedStatement = connection.prepareStatement(query);
	            preparedStatement.setInt(1, start);
	            preparedStatement.setInt(2, limit );
	     
	            resultSet = preparedStatement.executeQuery();

	            while (resultSet.next()) {
	            	AddressBean vehicle = new AddressBean();
		            vehicle.setAddressID(resultSet.getString("addressID"));
		            vehicle.setEmail(resultSet.getString("email"));
		            vehicle.setStreet(resultSet.getString("street"));
		            vehicle.setCity(resultSet.getString("city"));
		            vehicle.setPostal_code(resultSet.getString("postal_code"));
		            vehicle.setState(resultSet.getString("state"));
		            vehicle.setHno(resultSet.getString("hno"));
	            	FilteredAppointments.add(vehicle);
	            }
	        } catch (Exception e) {
	            // Handle exceptions
	            e.printStackTrace();
	        } finally {
	            // Close database resources (connection, statement, result set)
	            try {
	                if (resultSet != null) resultSet.close();
	                if (preparedStatement != null) preparedStatement.close();
	                if (connection != null) connection.close();
	            } catch (Exception e) {
	                // Handle exceptions
	                e.printStackTrace();
	            }
	        }

	        return FilteredAppointments;  
	    } 
}
