<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="activity.ActivityDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="activity" class="activity.Activity" scope="page" />
<jsp:setProperty name="activity" property="actType" /> 
<jsp:setProperty name="activity" property="actName" />
<jsp:setProperty name="activity" property="actSummary" />
<!doctype html>
<html lang = "ko">
    <head>
        <meta charset="utf-8" content="text/html" http-equiv="Content-Type">
        <title>My diary</title>
    </head>

    <body>
		<%
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
				int result = activityDAO.add(activity, (String)session.getAttribute("userID"), (Integer)session.getAttribute("actNumber"));
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 활동입니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				else
				{
					session.setAttribute("actNumber", (Integer)session.getAttribute("actNumber")+1);
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('활동이 추가되었습니다.')");
					script.println("location.href = '../main.jsp'");
					script.println("</script>");
				}
			}
		}
		%>
    </body>
</html>
