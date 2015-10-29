package database;

import java.sql.*;
import java.util.*;


public class Session {
	
	public static String getUserName(String id, String password){
		
		Connection connection = null;
		String name = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt= connection.prepareStatement("select username from login_data where id=? and password=?");
			pstmt.setString(1, id);
			// add hashing of passwords later
			pstmt.setString(2, password);
				
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next())
				name = rs.getString("username");
			
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting course list");
		} finally{
			closeConnection(connection);
		}
		
		return name;
		
	}
	
	static Connection getConnection() {
		String dbURL = "jdbc:postgresql://10.105.1.12/cs387";
        String dbUser = "db130050046";
        String dbPass = "db@ubuntu";
        Connection connection=null;
        try {
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(dbURL, dbUser, dbPass);
        } catch(ClassNotFoundException cnfe){
        	System.out.println("JDBC Driver not found");
        } catch(SQLException sqle){
        	System.out.println("Error in getting connetcion from the database");
        }
        
        return connection;
	}
	
	static void closeConnection(Connection connection) {
		try{
			connection.close();
		} catch(SQLException sqle) {
			System.out.println("Error in close database connetcion");
		}
	}
}
