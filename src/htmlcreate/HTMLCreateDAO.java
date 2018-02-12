package htmlcreate;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HTMLCreateDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public HTMLCreateDAO()  {
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
	
	public int makeHTML(String htmlCode) {
		try {
			String path = HTMLCreateDAO.class.getResource("").getPath()+"../../../";
			File file = new File(path+"Portfolio.html","UTF8"); 
			BufferedWriter uniOutput = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"Portfolio.html"),"UTF8"));

			uniOutput.write(htmlCode);
			uniOutput.close();

		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
