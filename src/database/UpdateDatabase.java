package database;

import java.sql.*;

public class UpdateDatabase {
	
	public static boolean AddSellingListing(String id, String item_name, String item_description, String item_category, 
			int item_price, int item_quantity){
		
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
			// id | item_id | name | description | category | is_biddable | bidding_price
			pstmt = connection.prepareStatement
					("insert into items (id,name,description,category,is_biddable,bidding_price) values (?,?,?,?,?,?) returning item_id");
			pstmt.setString(1, id);
			pstmt.setString(2, item_name);
			pstmt.setString(3, item_description);
			pstmt.setString(4, item_category);
			pstmt.setString(5, "n");
			pstmt.setDouble(6, 0);
			/*pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement
					("select currval('items_item_id_seq') ");*/
			ResultSet res = pstmt.executeQuery();
			Integer last_inserted=0;
			while(res.next()){
				last_inserted = res.getInt(1);
			}
			// columns are
			// id | item_id | quantity | price | timestamp
			pstmt = connection.prepareStatement
					("insert into item_sell (id,item_id,quantity,price,time_) values(?,?,?,?,now())");
			
			pstmt.setString(1, id);
			pstmt.setInt(2, last_inserted);
			pstmt.setInt(3, item_quantity);
			pstmt.setInt(4, item_price);
			
			pstmt.executeUpdate();
			
			
			pstmt = connection.prepareStatement("update id_tracker set current_id=? where current_id=?");
			pstmt.setString(1, Integer.toString(i+1));
			pstmt.setString(2, Integer.toString(i));
			pstmt.executeUpdate();
			
			connection.commit();
			
			flag = true;			
		
		} catch(SQLException sqle){
			System.out.println(sqle);
			sqle.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.out.println("SQL exception! in insertion into items"+sqle);
		} finally{
			closeConnection(connection);
		}
		
		return flag;
	}
	
public static boolean InsertMessageIntoDatabase(String sender, String receiver, String message){
		
		boolean flag = false;
		Connection connection = null;  
		
		try{
			connection = getConnection();
			
			PreparedStatement pstmt = connection.prepareStatement
					("insert into messages values(?,?,?,now())");
			pstmt.setString(1, sender);
			pstmt.setString(2, receiver);
			pstmt.setString(3, message);
			
			pstmt.executeUpdate();
			flag = true;
		
		} catch(SQLException sqle){
			System.out.println("SQL exception!");
		} finally{
			closeConnection(connection);
		}
		
		return flag;
	}
	
	public static boolean UpdateWishlist(String id, String itemid, String str_quantity, 
		String owner, String pricerange, String comment, String specification){
	
	boolean flag = false;
	Connection connection = null;
	
	int quantity = Integer.parseInt(str_quantity);	
	try{
		connection = getConnection();
		connection.setAutoCommit(false);
		PreparedStatement pstmt = null;
		if(quantity == 0){
			pstmt = connection.prepareStatement("delete from item_wishlist where id=? and item_id=?");
			pstmt.setString(1, id);
			pstmt.setString(2, itemid);
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement("update item_sell set interested_buyers = (select array_remove(interested_buyers,?) from item_sell where id=? and item_id=?) where id=? and item_id=?");
			pstmt.setString(1, id);
			pstmt.setString(2, owner);
			pstmt.setString(3, itemid);
			pstmt.setString(4, owner);
			pstmt.setString(5, itemid);
			pstmt.executeUpdate();
			
			connection.commit();
		}
		else{
		
			pstmt = connection.prepareStatement
					("update item_wishlist set quantity=?, price_range=?, specifications=?, comments=?, time_=now() where id=? and item_id=?");
			
			pstmt.setInt(1, quantity);
			pstmt.setString(2, pricerange);
			pstmt.setString(3, specification);
			pstmt.setString(4, comment);
			pstmt.setString(5, id);
			pstmt.setString(6, itemid);
			pstmt.executeUpdate();
			
			connection.commit();
		}
	
		flag = true;
		
	} catch(SQLException sqle){
		System.out.println("SQL exception!");
	} finally{
		closeConnection(connection);
	}
	
	return flag;
}

public static boolean AddToSellWishlist(String id, String itemid, String specification, Integer quantity){
	
	boolean flag = false;
	Connection connection = null;
		
	try{
		connection = getConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement pstmt = connection.prepareStatement("select count(*) from item_sell_wishlist where id=? and item_id=?");
		pstmt.setInt(2, Integer.parseInt(itemid));
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		Integer count=0;
		while(rs.next()) {
			count=rs.getInt(1);
		}
		
		if(count!=0) {
			pstmt = connection.prepareStatement("update item_sell_wishlist set message=?, quantity=? where id=? and item_id=?");
			pstmt.setInt(2, quantity);
			pstmt.setInt(4, Integer.parseInt(itemid));
			pstmt.setString(3, id);
			pstmt.setString(1, specification);
			pstmt.executeUpdate();

		}
		else {
			PreparedStatement pstmt1 = connection.prepareStatement("insert into item_sell_wishlist values(?,?,?,?)");			
			pstmt1.setInt(1, Integer.parseInt(itemid));
			pstmt1.setString(2, id);
			pstmt1.setString(3, specification);
			pstmt1.setInt(4, quantity);
			
			pstmt1.executeUpdate();
		}
		/*pstmt = connection.prepareStatement("select no_of_interested_buyers from item_sell where id=? and item_id=?");
		pstmt.setString(1, owner);
		pstmt.setString(2, itemid);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		int c = rs.getInt(1);
		
		pstmt = connection.prepareStatement("update item_sell set interested_buyers[?] = ?, no_of_interested_buyers=? where id=? and item_id=?");
		pstmt.setInt(1, c);
		pstmt.setString(2, id);
		pstmt.setInt(3, c+1);
		pstmt.setString(4, owner);
		pstmt.setString(5, itemid);
		pstmt.executeUpdate();*/
		
		connection.commit();
		flag = true;
		
	} catch(SQLException sqle){
		System.out.println("SQL exception in AddToSellWishlist" + sqle);
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
	
	public static boolean Sell_item(String itemid, String buyer, String owner, Integer quantity){
		
		boolean flag = false;
		Connection connection = null;
			
		try{
			connection = getConnection();
			connection.setAutoCommit(false);
			
			// delete this entry from item_sell_wishlist
			//reduce the quantity in items
			//if quantity == 0 delete the item from item_sell
			//populate into history
			
			PreparedStatement pstmt = connection.prepareStatement("delete from item_sell_wishlist where id=? and item_id=?");
			pstmt.setString(1, buyer);
			pstmt.setInt(2, Integer.parseInt(itemid));
			pstmt.executeUpdate();
			
			pstmt = connection.prepareStatement("select quantity,price from item_sell where item_id=?");
			pstmt.setInt(1, Integer.parseInt(itemid));			
			ResultSet rs = pstmt.executeQuery();
			Integer quant=0;
			Integer price=0;
			while(rs.next()) {
				quant=rs.getInt(1);
				price=rs.getInt(2);
			}
			
			if(quant<=quantity) {
				
				pstmt = connection.prepareStatement("insert into transaction_history values (?,?,?,?,?,null,now()) ");
				pstmt.setString(1, buyer);
				pstmt.setString(2, owner);
				pstmt.setInt(3, Integer.parseInt(itemid));
				pstmt.setInt(4, price);
				pstmt.setInt(5, quant);
				pstmt.executeUpdate();
				
				pstmt = connection.prepareStatement("delete from item_sell_wishlist where item_id=?");
				pstmt.setInt(1, Integer.parseInt(itemid));
				pstmt.executeUpdate();
				
				pstmt = connection.prepareStatement("delete from item_sell where item_id=?");
				pstmt.setInt(1, Integer.parseInt(itemid));
				pstmt.executeUpdate();

			}
			else {
				pstmt = connection.prepareStatement("insert into transaction_history values (?,?,?,?,?,null,now()) ");
				pstmt.setString(1, buyer);
				pstmt.setString(2, owner);
				pstmt.setInt(3, Integer.parseInt(itemid));
				pstmt.setInt(4, price);
				pstmt.setInt(5, quantity);
				pstmt.executeUpdate();
				
				pstmt = connection.prepareStatement("update item_sell set quantity=quantity - ? where item_id=?");
				pstmt.setInt(2, Integer.parseInt(itemid));
				pstmt.setInt(1, quantity);
				pstmt.executeUpdate();
			}
			
			/*if(count!=0) {
				pstmt = connection.prepareStatement("update item_sell_wishlist set message=? where id=? and item_id=?");
				
				pstmt.setInt(3, Integer.parseInt(itemid));
				pstmt.setString(2, id);
				pstmt.setString(1, specification);
				
				pstmt.executeUpdate();

			}
			else {*/
				/*pstmt = connection.prepareStatement("insert into item_sell_wishlist values(?,?,?)");
				
				pstmt.setInt(1, Integer.parseInt(itemid));
				pstmt.setString(2, id);
				pstmt.setString(3, id);
				
				pstmt.executeUpdate();*/
			//}
			/*pstmt = connection.prepareStatement("select no_of_interested_buyers from item_sell where id=? and item_id=?");
			pstmt.setString(1, owner);
			pstmt.setString(2, itemid);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			int c = rs.getInt(1);
			
			pstmt = connection.prepareStatement("update item_sell set interested_buyers[?] = ?, no_of_interested_buyers=? where id=? and item_id=?");
			pstmt.setInt(1, c);
			pstmt.setString(2, id);
			pstmt.setInt(3, c+1);
			pstmt.setString(4, owner);
			pstmt.setString(5, itemid);
			pstmt.executeUpdate();*/
			
			connection.commit();
			flag = true;
			
		} catch(SQLException sqle){
			System.out.println("SQL exception in AddToSellWishlist" + sqle);
		} finally{
			closeConnection(connection);
		}
		return flag;
	}

}
