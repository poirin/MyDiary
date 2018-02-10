package doccreate;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class DOCCreateDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public DOCCreateDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID ="root";
			String dbPassword ="root"; //please input password
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	

	public int makeDocumentation(String userID, String[] chk, String designType) {
		String SQL = "SELECT * FROM activity WHERE userID=?";
		
		return 0;
	}
}
