package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;
import java.util.TreeSet;

public class AccessDatabase {
	
	public static ResultSet GetSellingListing(String id){
		
		boolean flag = false;
		Connection connection = null;
		ResultSet rs = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select * from items natural join item_sell where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();		
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
	}
	
	public static ResultSet GetBuyingListing(String owner){
		
		boolean flag = false;
		Connection connection = null;
		ResultSet rs = null;
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select * from items natural join item_sell where id <> ?");
			pstmt.setString(1, owner);
			rs = pstmt.executeQuery();
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
	}
	
	public static ArrayList<String> GetItemsInWishlistForUser(String id){
		
		ArrayList<String> result = new ArrayList<String>();
		Connection connection = null;
			
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select item_id from item_wishlist where id=?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				result.add(rs.getString(1));
			}
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return result;
		
	}
	
	public static HashMap<String, ArrayList<String>> GetAlreadyMarkedForBuyingListing(String id){
		
		Connection connection = null;
		HashMap<String, ArrayList<String>> hm = new HashMap<String, ArrayList<String>>(); 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement("select item_id, specifications, quantity, price_range, comments from item_wishlist where id=?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				ArrayList<String> al = new ArrayList<String>();
				al.add(rs.getString(2));
				al.add(Integer.toString(rs.getInt(3)));
				al.add(rs.getString(4));
				al.add(rs.getString(5));
				hm.put(rs.getString(1), al);
			}
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return hm;
	}
	
	public static ResultSet GetTransactionHistoryAsSeller(String id){
		
		Connection connection = null;
		ResultSet rs = null; 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("select name, username, price, quantity, time_, comments "
					+ "from ((transaction_history natural join items) join login_data on id=buyer) "
					+ "where seller=?;");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
		
	}
	
	public static ResultSet GetTransactionHistoryAsBuyer(String id){
		
		Connection connection = null;
		ResultSet rs = null; 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("select name, username, price, quantity, time_, comments "
					+ "from ((transaction_history natural join items) join login_data on id=seller) "
					+ "where buyer=?;");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return rs;
		
	}
	
	public static String GetName(String id){
		
		Connection connection = null;
		String s = null;  
		ResultSet rs = null; 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("select username from login_data where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				s = rs.getString(1);
			}
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return s;
		
	}
	
	public static ArrayList<Pair<String,String>> ListOfAllUsers(){
		
		Connection connection = null;
		ArrayList<Pair<String,String>> al = new ArrayList<Pair<String,String>>();  
		ResultSet rs = null; 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("select id, username from login_data");
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				al.add(new Pair<String, String>(rs.getString(1), rs.getString(2)));
			}
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return al;
		
	}
	
	public static TreeMap<Timestamp, Pair<Boolean, String>> GetAllMessagesBetweenAPair(String sender, String receiver){
		
		Connection connection = null;
		TreeMap<Timestamp, Pair<Boolean, String>> ts = new TreeMap<Timestamp, Pair<Boolean, String>>();  
		ResultSet rs = null; 
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("select * from messages where sender=? and receiver=? or sender=? and receiver=?");
			
			pstmt.setString(1, sender);
			pstmt.setString(2, receiver);
			pstmt.setString(3, receiver);
			pstmt.setString(4, sender);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Pair<Boolean, String> p;
				if(rs.getString(1).equals(sender)){
					p = new Pair<Boolean, String>(true, rs.getString(3));
				}
				else{
					p = new Pair<Boolean, String>(false, rs.getString(3));
				}
				ts.put(rs.getTimestamp(4), p);
			}
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return ts;
		
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
