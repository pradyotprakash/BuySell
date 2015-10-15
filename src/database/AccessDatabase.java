package database;

import java.sql.*;

public class AccessDatabase {
	
	public static ResultSet GetSellingListing(String id){
		
		boolean flag = false;
		Connection connection = null;
		ResultSet rs = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select * from item_sell where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();		
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		//System.out.println(rs);
		return rs;
	}
	
	public static ResultSet GetBuyingListing(){
		
		boolean flag = false;
		Connection connection = null;
		ResultSet rs = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select * from item_sell");
			rs = pstmt.executeQuery();
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
	}
	
	public static ResultSet GetAlreadyMarkedForBuyingListing(String id){
		
		boolean flag = false;
		Connection connection = null;
		ResultSet rs = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select * from item_buy where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();		
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
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
