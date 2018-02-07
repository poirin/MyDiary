package activity;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

class Ascending implements Comparator<String> {
    public int compare(String o1, String o2) {
        return o1.compareTo(o2);
    }
}

public class ActivityDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ActivityDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID ="root";
			String dbPassword ="root"; //please input password
			/*
			
			String dbURL = "jdbc:mysql://localhost:3306/mydiary";
			String dbID ="root";
			String dbPassword ="dhfoswl1";
			*/ 
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
					
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
public ArrayList<String> getYear(String userID)
	{
		String SQL = "SELECT * FROM activity WHERE userID=?";
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> resultList = new ArrayList<String>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String start = null;
				String end = null;
				if(rs.getString(5)!=null) start = (rs.getString(5).substring(0, 4));
				if(rs.getString(6)!=null) end = (rs.getString(6).substring(0, 4));
				if(start==null && end !=null) list.add(end);
				if(start!=null && end ==null) list.add(start);
				if(start !=null && end !=null)
				{
					int istart = Integer.parseInt(start);
					int iend = Integer.parseInt(end);
					for(int i= istart; i<= iend; i++)
						list.add(Integer.toString(i));
				}
				
			}
			
			for (int i = 0; i < list.size(); i++) {
			    if (!resultList.contains(list.get(i))) {
			        resultList.add(list.get(i));
			    }
			}
			
			Ascending ascending = new Ascending();
	        Collections.sort(resultList, ascending);
	        
		} catch(Exception e) {
			e.printStackTrace();
		}
		return resultList; 
	}

	public int add(Activity activity, String userID, int actNumber)
	{
		String SQL = "INSERT INTO activity(userID, actNum, actType, actName, actSummary) VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, actNumber);
			pstmt.setString(3, activity.getActType());
			pstmt.setString(4, activity.getActName());
			pstmt.setString(5, activity.getActSummary());
			pstmt.executeUpdate();
			
			pstmt.clearParameters();
			SQL = "UPDATE user SET actNumber= ? WHERE userID= ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, actNumber+1);
			pstmt.setString(2, userID);
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<Activity> getList(String userID)
	{
		String SQL = "SELECT * FROM activity WHERE userID=?";
		ArrayList<Activity> list = new ArrayList<Activity>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Activity activity = new Activity();
				activity.setUserID(rs.getString(1));
				activity.setActNum(rs.getInt(2));
				activity.setActType(rs.getString(3));
				activity.setActName(rs.getString(4));
				activity.setStartDate(rs.getString(5));
				activity.setEndDate(rs.getString(6));
				activity.setActSummary(rs.getString(7));
				list.add(activity);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public ArrayList<Activity> getListByKeyword(String userID, String keyword)
	{
		String SQL = "SELECT * FROM activity WHERE userID=? AND ((actName LIKE ?) OR (actType LIKE ?) OR (actSummary LIKE ?))";
		ArrayList<Activity> list = new ArrayList<Activity>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, "%" + keyword + "%");
			pstmt.setString(3, "%" + keyword + "%");
			pstmt.setString(4, "%" + keyword + "%");
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Activity activity = new Activity();
				activity.setUserID(rs.getString(1));
				activity.setActNum(rs.getInt(2));
				activity.setActType(rs.getString(3));
				activity.setActName(rs.getString(4));
				activity.setActSummary(rs.getString(7));
				list.add(activity);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public Activity getActivity(String userID, int actNum)
	{
		String SQL = "SELECT * FROM activity WHERE userID=? AND actNum=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, actNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				Activity activity = new Activity();
				activity.setUserID(rs.getString(1));
				activity.setActNum(rs.getInt(2));
				activity.setActType(rs.getString(3));
				activity.setActName(rs.getString(4));
				activity.setStartDate(rs.getString(5));
				activity.setEndDate(rs.getString(6));
				activity.setActSummary(rs.getString(7));
				activity.setActContent(rs.getString(8));
				activity.setActResult(rs.getString(9));
				activity.setActStatus(rs.getString(10));
				return activity;
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	public int modify(Activity activity, String userID, int actNumber)
	{
		String SQL = "UPDATE activity SET "
				+ "actType=?, actName=?, startDate=?, endDate=?, "
				+ "actSummary=?, actContent=?, actResult=?, actStatus=?"
				+ "WHERE userID=? AND actNum=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, activity.getActType());
			pstmt.setString(2, activity.getActName());
			pstmt.setString(3, activity.getStartDate());
			pstmt.setString(4, activity.getEndDate());
			pstmt.setString(5, activity.getActSummary());
			pstmt.setString(6, activity.getActContent());
			pstmt.setString(7, activity.getActResult());
			pstmt.setString(8, activity.getActStatus());
			pstmt.setString(9, userID);
			pstmt.setInt(10, actNumber);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int delete(String userID, int actNumber)
	{
		String SQL = "delete from activity where userID = ? AND actNum = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, actNumber);
			
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}
