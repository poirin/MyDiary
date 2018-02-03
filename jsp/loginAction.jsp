<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />
<!doctype html>
<html lang = "ko">
    <head>
        <meta charset="utf-8" content="text/html" http-equiv="Content-Type">
        <title>My diary</title>
    </head>

    <body>
		<%
		String userID = user.getUserID();
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPW());
		if(result >= 1){
			session.setAttribute("actNumber", result);
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../main.jsp'");
			script.println("</script>");
		}
		else if(result ==0)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result ==-1)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result==-2)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB error.')");
			script.println("history.back()");
			script.println("</script>");
		}
		%>
    </body>
</html>
