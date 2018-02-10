﻿package pptcreate;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.poi.xslf.usermodel.SlideLayout;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.apache.poi.xslf.usermodel.XSLFSlide;
import org.apache.poi.xslf.usermodel.XSLFSlideLayout;
import org.apache.poi.xslf.usermodel.XSLFSlideMaster;
import org.apache.poi.xslf.usermodel.XSLFTextShape;

public class PPTCreateDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public PPTCreateDAO() {
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
	
	public int makePowerpoint(String userID, String[] chk, String designType) {
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
			String url = designType+".pptx";
			String path = PPTCreateDAO.class.getResource("").getPath()+"../../../";
			XMLSlideShow ppt = new XMLSlideShow(new FileInputStream(path+"ppttheme/"+url)); //make a powerpoint
			
			
			XSLFSlideMaster defaultMaster = ppt.getSlideMasters().get(0); //slide type
	
			// title slide
			XSLFSlideLayout titleLayout = defaultMaster.getLayout(SlideLayout.TITLE);
			// fill the placeholders
			XSLFSlide slide1 = ppt.createSlide(titleLayout);
			XSLFTextShape title1;
			XSLFTextShape content1;
			if(slide1.getPlaceholder(0).getText().equals("마스터 제목 스타일 편집"))
			{
				title1 = slide1.getPlaceholder(0);
				content1 = slide1.getPlaceholder(1);
			}
			else
			{
				title1 = slide1.getPlaceholder(1);
				content1 = slide1.getPlaceholder(0);
			}
			title1.setText(userID+"의 포트폴리오");
			content1.setText(" ");
		
			int cnt = 0; // For check count
			while(rs.next()&&cnt<chk.length) {
			
				if(rs.getInt("actNum")!=Integer.parseInt(chk[cnt])) continue;
				// title and content
				XSLFSlideLayout titleBodyLayout = defaultMaster.getLayout(SlideLayout.TITLE_AND_CONTENT);
				XSLFSlide slide2 = ppt.createSlide(titleBodyLayout);
				XSLFTextShape title2;
				XSLFTextShape body2;
				if(slide2.getPlaceholder(0).getText().equals("마스터 제목 스타일 편집"))
				{
					title2 = slide2.getPlaceholder(0);
					body2 = slide2.getPlaceholder(1);
				}
				else
				{
					title2 = slide2.getPlaceholder(1);
					body2 = slide2.getPlaceholder(0);
				}

				title2.setText(rs.getString("actName"));

				body2.clearText(); // unset any existing text
				body2.addNewTextParagraph().addNewTextRun().setText("활동 종류 : "+rs.getString("actType"));
				body2.addNewTextParagraph().addNewTextRun().setText("");
				body2.addNewTextParagraph().addNewTextRun().setText("활동 요약 : "+rs.getString("actSummary"));
				body2.addNewTextParagraph().addNewTextRun().setText("");
				if(rs.getString("startDate")!=null&&rs.getString("endDate")!=null)
				{
					body2.addNewTextParagraph().addNewTextRun().setText("활동 날짜 : "+rs.getString("startDate") + " ~ "+ rs.getString("endDate"));
					body2.addNewTextParagraph().addNewTextRun().setText("");
				}
				if(rs.getString("actStatus")!=null&&!rs.getString("actStatus").equals("선택"))
				{
					if(rs.getString("actStatus").equals("완료됨"))
						body2.addNewTextParagraph().addNewTextRun().setText("완료된 " + rs.getString("actType"));
					if(rs.getString("actStatus").equals("진행중"))
						body2.addNewTextParagraph().addNewTextRun().setText("진행중인 " + rs.getString("actType"));
					if(rs.getString("actStatus").equals("예정"))
						body2.addNewTextParagraph().addNewTextRun().setText("예정된 " + rs.getString("actType"));
					body2.addNewTextParagraph().addNewTextRun().setText("");
				}
				cnt++;
			}

			
			File file = new File(path+"Portfolio.pptx");
			try {
				FileOutputStream out2 = new FileOutputStream(file);
				ppt.write(out2);
				out2.close();
				
				return -1;
			}catch(Exception e) {
				System.out.println(e);
			}
			return -2;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	
	}
}
