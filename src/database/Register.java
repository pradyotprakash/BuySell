package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Register {

	public static int register(String id, String name, String email, String passwd){
				
		Connection connection = null;
		int status = 0;
		
		try{
			connection = getConnection();
						
			PreparedStatement pstmt = connection.prepareStatement("select count(*) from login_data where id=?");
			pstmt.setString(1, id);
									
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			int count = rs.getInt(1);
			
			if(count != 0)
				return 1;
			
			pstmt = connection.prepareStatement("insert into login_data values(?,?,?,?)");
			
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, passwd);
			pstmt.setString(4, email);
			
			pstmt.executeUpdate();
			
			status = 0;
			return 0;
			
			
		} catch(SQLException sqle){
			System.out.println("SQL exception when getting course list");
		} finally{
			closeConnection(connection);
		}
		return status;
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
