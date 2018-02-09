<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pptcreate.PPTCreateDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="pptcreate" class="user.User" scope="page" />
<jsp:setProperty name="pptcreate" property="userID" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<iframe width=0 height=0 name="hiddenframe" style="display:none;"></iframe>
	<%
		String[] chk = request.getParameterValues("check");
		String designType = request.getParameter("select");
		PPTCreateDAO pptCreateDAO = new PPTCreateDAO();
		int result = pptCreateDAO.makePowerpoint((String)session.getAttribute("userID"), chk, designType);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("function fileDown(){window.location.assign(\"down.jsp\")}");
			script.println("fileDown()");
			script.println("setTimeout('history.back()',1000)");
			script.println("</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>
