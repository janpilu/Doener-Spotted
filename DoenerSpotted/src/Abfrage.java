/**
 * 
 */

/**
 * @author armin
 *
 */
import java.sql.*;
public class Abfrage {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try{
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/doenerspotted", "root", "af310300");
			
			Statement stmt = con.createStatement();
			
			ResultSet rs = stmt.executeQuery("Select * from benutzer");
			System.out.println(rs);
		
		
			while(rs.next()){
				System.out.println(rs.getString(1)+""+rs.getString(2)+""+rs.getString(3)+""+rs.getString(4)+""+rs.getInt(5)+""+rs.getString(6));
			}

			
			// create a Statement from the connection
			Statement statement = con.createStatement();

			// insert the data
			statement.executeUpdate("INSERT INTO benutzer VALUES ('A3', 'Simpson', 'Mr.', 'Springfield', 2001, 'Ab');");

			con.close();
			
		}catch(Exception e){
			System.out.println("Krah");
		}
		
		
		
		
	}

}
