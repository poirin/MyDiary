<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="activity.ActivityDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="activity" class="activity.Activity" scope="page" />
<jsp:setProperty name="activity" property="actType" /> 
<jsp:setProperty name="activity" property="actName" />
<jsp:setProperty name="activity" property="startDate" />
<jsp:setProperty name="activity" property="endDate" /> 
<jsp:setProperty name="activity" property="actSummary" />
<jsp:setProperty name="activity" property="actContent" />
<jsp:setProperty name="activity" property="actResult" />
<jsp:setProperty name="activity" property="actStatus" />
<!doctype html>
<html lang = "ko">
    <head>
        <meta charset="utf-8" content="text/html" http-equiv="Content-Type">
        <title>My diary</title>
    </head>

    <body>
		<%
		int actNum = 0;
		if(request.getParameter("actNum") != null){
			actNum = Integer.parseInt(request.getParameter("actNum"));
		}
		if(actNum==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		
	
		if(session.getAttribute("userID") == null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 해주십시오.')");
			script.println("location.href = '../mydiary.html");
			script.println("</script>");
		}
		else
		{
			ActivityDAO activityDAO = new ActivityDAO();
			if(activity.getActType()==null || activity.getActName()==null)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('활동종류와 활동이름을 입력해주십시오.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else
			{
				int result = activityDAO.modify(activity, (String)session.getAttribute("userID"), actNum);
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('DB Error')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('활동이 수정되었습니다.')");
					script.println("location.href = '../main.jsp'");
					script.println("</script>");
				}
			}
		}
		%>
    </body>
</html>
