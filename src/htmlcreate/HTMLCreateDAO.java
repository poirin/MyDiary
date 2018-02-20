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
	
	public HTMLCreateDAO() {
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
	
	public int makeHTML(String userID, String htmlCode) {	
		String SQL = "SELECT * FROM activity WHERE userID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			rs.next();
			
			htmlCode = htmlCode.replaceAll("<div class=\"activityType\">.*?</div>","<div class=\"activityType\">"+"Ȱ������ : " +rs.getString("actType")+"</div>");
			htmlCode = htmlCode.replaceAll("<div class=\"activityName\">.*?</div>","<div class=\"activityName\">"+"Ȱ���̸� : " +rs.getString("actName")+"</div>");
			htmlCode = htmlCode.replaceAll("<div class=\"summaryDescription\">.*?</div>","<div class=\"summaryDescription\">"+rs.getString("actSummary")+"</div>");
			
			if(rs.getString("startDate")!=null&&rs.getString("endDate")!=null)
			{
				htmlCode = htmlCode.replaceAll("<div class=\"activityDate\">.*?</div>","<div class=\"activityDate\">"+rs.getString("startDate")+" ~ "+ rs.getString("endDate")+ "</div>");
			
			}
			else
			{
				htmlCode = htmlCode.replaceAll("<div class=\"activityDate\">.*?</div>","");		
			}
			
			
			if(rs.getString("actStatus")!=null&&!rs.getString("actStatus").equals("����"))
			{
				if(rs.getString("actStatus").equals("�Ϸ��"))
					htmlCode = htmlCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">�Ϸ��  " + rs.getString("actType")+"</div>");
				if(rs.getString("actStatus").equals("������"))
					htmlCode = htmlCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">��������  " + rs.getString("actType")+"</div>");
				if(rs.getString("actStatus").equals("����"))
					htmlCode = htmlCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">������  " + rs.getString("actType")+"</div>");
			}
			else
			{
				htmlCode = htmlCode.replaceAll("<div class=\"activityStatus\">.*?</div>","");
			}
			
			if(rs.getString("actContent")!=null)
			{
				htmlCode = htmlCode.replaceAll("<div class=\"contentDescription\">.*?</div>","<div class=\"contentDescription\">"+rs.getString("actContent")+ "</div>");
			}	
			else
			{
				htmlCode = htmlCode.replaceAll("<div class=\"activityContent\">.*?</div>","");
				htmlCode = htmlCode.replaceAll("<div class=\"contentDescription\">.*?</div>","");
			}
			
			if(rs.getString("actResult")!=null)
			{
				htmlCode = htmlCode.replaceAll("<div class=\"activityResult\">.*?</div>","");
				htmlCode = htmlCode.replaceAll("<div class=\"resultDescription\">.*?</div>","<div class=\"resultDescription\">"+rs.getString("actResult")+ "</div>");
			}
			else
			{
				htmlCode = htmlCode.replaceAll("<div class=\"resultDescription\">.*?</div>","");
			}
			
			String path = HTMLCreateDAO.class.getResource("").getPath()+"../../../";
			//File file = new File(path+"Portfolio.html","UTF8"); 
			BufferedWriter uniOutput = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"Portfolio.html"),"UTF8"));
	
			uniOutput.write(htmlCode);
			uniOutput.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	
}
