package com.shashi.service.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.shashi.beans.UserBean;
import com.shashi.utility.DBUtil;


public class ProfileDAO {

	public UserBean getProfileByUserName(String email) {
		UserBean profile = null;
		try (Connection connection = DBUtil.provideConnection();
				PreparedStatement preparedStatement = connection.prepareStatement(

						"SELECT email, name, mobile, address, pincode, password FROM user WHERE email = ?")) {

			preparedStatement.setString(1, email);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					profile = new UserBean();
					profile.setEmail(resultSet.getString("email"));
					profile.setName(resultSet.getString("name"));
					profile.setMobile(resultSet.getLong("mobile"));
					profile.setAddress(resultSet.getString("address"));
					profile.setPinCode(resultSet.getInt("pincode"));
					profile.setPassword(resultSet.getString("password"));
				}
			}

		} catch (SQLException e) {
		
		}
		return profile;
	}

	
	public boolean updateProfileDetails(UserBean profile) {
	    try (Connection connection = DBUtil.provideConnection();
	         PreparedStatement preparedStatement = connection.prepareStatement(
	                 "UPDATE user SET name = ?, mobile = ?, address = ?, pincode = ?,password = ? WHERE email = ?")) {
	        preparedStatement.setString(1, profile.getName());
	        preparedStatement.setLong(2, profile.getMobile());
	        preparedStatement.setString(3, profile.getAddress());
	        preparedStatement.setInt(4, profile.getPinCode());
	        preparedStatement.setString(5, profile.getPassword()); 
	        preparedStatement.setString(6, profile.getEmail()); 
	        // Add the email for WHERE clause
	        int rowsUpdated = preparedStatement.executeUpdate();
	        return rowsUpdated > 0;
	    } catch (SQLException e) {
	        // Handle any exceptions, log them if necessary
	        e.printStackTrace();
	        return false;
	    }
	}

}
