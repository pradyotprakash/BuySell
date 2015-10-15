package database;

import java.sql.*;

public class UpdateDatabase {
	
	public static boolean AddSellingListing(String id, String item_name, String item_description, String item_category, 
			int item_price, int item_quantity, String item_biddable, int item_bidding_price){
		
		boolean flag = false;
		Connection connection = null;
		int i = 0;
		
		try{
			connection = getConnection();
			connection.setAutoCommit(false);
			
			PreparedStatement pstmt = connection.prepareStatement("select * from id_tracker");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				i = rs.getInt(1); 
			}
					
			// columns are
			// item_id | item_name | item_description | category | timestamp | is_biddable | bidding_price | id | quantity | price | interested_buyers
			pstmt = connection.prepareStatement
					("insert into item_sell values(?,?,?,?,current_date,?,?,?,?,?,null)");
			
			pstmt.setString(1, Integer.toString(i));
			pstmt.setString(2, item_name);
			pstmt.setString(3, item_description);
			pstmt.setString(4, item_category);
			if(item_biddable.equals("no")){
				pstmt.setString(5, "n");
				pstmt.setDouble(6, 0);
			}
			else{
				pstmt.setString(5, "y");
				pstmt.setDouble(6, item_bidding_price);
			}
			
			pstmt.setString(7, id);
			pstmt.setInt(8, item_quantity);
			pstmt.setInt(9, item_price);
			
			pstmt.executeUpdate();
			
			
			pstmt = connection.prepareStatement("update id_tracker set current_id=? where current_id=?");
			pstmt.setString(1, Integer.toString(i+1));
			pstmt.setString(2, Integer.toString(i));
			System.out.println(pstmt.toString());
			pstmt.executeUpdate();
			
			connection.commit();
			
			flag = true;			
		
		} catch(SQLException sqle){
			sqle.printStackTrace();
			System.out.println("POPOP");
			try {
				connection.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return flag;
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
