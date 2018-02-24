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
	
	public int makeHTML(String userID, String[] chk, String htmlCode) {	
		String SQL = "SELECT * FROM activity WHERE userID=?";
		if(chk==null) 
		{
			chk = new String[1]; 
			chk[0] = "99999999";
		}
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			String totalHtml = "";
			
			int cnt = 0; // For check count
			while(rs.next()&&cnt<chk.length) {
				if(rs.getInt("actNum")!=Integer.parseInt(chk[cnt])) continue;
				String changeCode = htmlCode;
				totalHtml = totalHtml + "<div id=\"port\">";
				changeCode = changeCode.replaceAll("<div class=\"activityName\">.*?</div>","<div class=\"activityName\">"+rs.getString("actName")+"</div>");
				changeCode = changeCode.replaceAll("<div class=\"activityType\">.*?</div>","<div class=\"activityType\">"+"활동종류 : " +rs.getString("actType")+"</div>");
				changeCode = changeCode.replaceAll("<div class=\"summaryDescription\">.*?</div>","<div class=\"summaryDescription\">"+rs.getString("actSummary")+"</div>");
				
				if(rs.getString("startDate")!=null&&rs.getString("endDate")!=null)
				{
					changeCode = changeCode.replaceAll("<div class=\"activityDate\">.*?</div>","<div class=\"activityDate\">"+"활동일자 : "+rs.getString("startDate")+" ~ "+ rs.getString("endDate")+ "</div>");
				
				}
				else
				{
					changeCode = changeCode.replaceAll("<div class=\"activityDate\">.*?</div>","");		
				}
				
				
				if(rs.getString("actStatus")!=null&&!rs.getString("actStatus").equals("선택"))
				{
					if(rs.getString("actStatus").equals("완료됨"))
						changeCode = changeCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">완료된  " + rs.getString("actType")+"</div>");
					if(rs.getString("actStatus").equals("진행중"))
						changeCode = changeCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">진행중인  " + rs.getString("actType")+"</div>");
					if(rs.getString("actStatus").equals("예정"))
						changeCode = changeCode.replaceAll("<div class=\"activityStatus\">.*?</div>","<div class=\"activityStatus\">예정된  " + rs.getString("actType")+"</div>");
				}
				else
				{
					changeCode = changeCode.replaceAll("<div class=\"activityStatus\">.*?</div>","");
				}
				
				if(rs.getString("actContent")!=null)
				{
					changeCode = changeCode.replaceAll("<div class=\"contentDescription\">.*?</div>","<div class=\"contentDescription\">"+rs.getString("actContent")+ "</div>");
				}
				else
				{
					changeCode = changeCode.replaceAll("<div class=\"activityContent\">.*?</div>","");
					changeCode = changeCode.replaceAll("<div class=\"contentDescription\">.*?</div>","");
				}
				
				if(rs.getString("actResult")!=null)
				{
					changeCode = changeCode.replaceAll("<div class=\"resultDescription\">.*?</div>","<div class=\"resultDescription\">"+rs.getString("actResult")+ "</div>");
				}
				else
				{
					changeCode = changeCode.replaceAll("<div class=\"activityResult\">.*?</div>","");
					changeCode = changeCode.replaceAll("<div class=\"resultDescription\">.*?</div>","");
				}
				
				totalHtml = totalHtml + changeCode+"</div>";
				cnt++;
			}
			String path = HTMLCreateDAO.class.getResource("").getPath()+"../../../";
			BufferedWriter uniOutput = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path+"Portfolio.html"),"UTF8"));

			uniOutput.write(totalHtml);
			uniOutput.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}