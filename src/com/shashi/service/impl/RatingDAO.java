package com.shashi.service.impl;



import com.shashi.beans.RatingBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shashi.utility.DBUtil;

	public class RatingDAO {
	    
	    // Method to get average rating by product ID
	    public static double getAverageRatingByProductId(String productId) {
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	        double averageRating = 0.0; // Default average rating
	        
	        try {
	            // Your code to establish a database connection
	            conn = DBUtil.provideConnection(); // Replace with your database connection method
	            
	            // SQL query to retrieve average rating by product ID
	            String sql = "SELECT AVG(rating) AS average_rating FROM review WHERE pid = ?";
	            
	            // Prepare the statement
	            stmt = conn.prepareStatement(sql);
	            stmt.setString(1, productId);
	            
	            // Execute the query
	            rs = stmt.executeQuery();
	            
	            // Check if there is a result
	            if (rs.next()) {
	                averageRating = rs.getDouble("average_rating"); // Get the average rating from the result set
	            }
	        } catch (SQLException e) {
	            e.printStackTrace(); // Handle the exception as per your application's requirement
	        } finally {
	            // Close the resources
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (stmt != null) {
	                    stmt.close();
	                }
	                if (conn != null) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace(); // Handle the exception as per your application's requirement
	            }
	        }
	        
	        return averageRating; // Return the average rating
	    }
	    

	    
	    public static int getUserCountByEmail(String productId) {
	        Connection conn = null;
	        PreparedStatement stmt = null;
	        ResultSet rs = null;
	        int userCount = 0; // Default user count
	        
	        try {
	            // Your code to establish a database connection
	            conn = DBUtil.provideConnection(); // Replace with your database connection method
	            
	            // SQL query to retrieve count of distinct users who rated the product by product ID
	            String sql = "SELECT COUNT(DISTINCT email) AS user_count FROM review WHERE pid = ?";
	        //    String sql = "SELECT AVG(subquery.rating) AS average_rating FROM (SELECT DISTINCT email, rating FROM review WHERE pid = ?) AS subquery";

	            // Prepare the statement
	            stmt = conn.prepareStatement(sql);
	            stmt.setString(1, productId);
	            
	            // Execute the query
	            rs = stmt.executeQuery();
	            
	            // Check if there is a result
	            if (rs.next()) {
	                userCount = rs.getInt("user_count"); 
	            }
	        } catch (SQLException e) {
	            e.printStackTrace(); 
	        } finally {
	            // Close the resources
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (stmt != null) {
	                    stmt.close();
	                }
	                if (conn != null) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace(); 
	            }
	        }
	        
	        return userCount; 
	    }
	    
	    
	    
	    
	    
	    public static List<RatingBean> getCommentsByProductId(String pid) {
		    List<RatingBean> allS = new ArrayList<>();
		    Connection connection = null;
		    PreparedStatement preparedStatement = null;
		    ResultSet resultSet = null;

		    try {
		        connection = DBUtil.provideConnection();
		        
		        // Modify the query based on the specified type
		        String query = "SELECT review.reviewID, review.rating, review.email, review.pid, review.comments,user.name FROM review inner join user on review.email=user.email WHERE pid = ?;";
		        
		        preparedStatement = connection.prepareStatement(query);
		        preparedStatement.setString(1, pid); // Set the type parameter
		        resultSet = preparedStatement.executeQuery();

		        while (resultSet.next()) {
		        	RatingBean aa = new RatingBean();
		        	  aa.setReviewID(resultSet.getString("reviewID"));
		            aa.setRating(resultSet.getString("rating"));
		            aa.setEmail(resultSet.getString("email"));
		            aa.setComments(resultSet.getString("comments"));
		            aa.setName(resultSet.getString("name"));
		            allS.add(aa);
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

		    return allS;
		}

	}


