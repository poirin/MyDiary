<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="htmlcreate.HTMLCreateDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="htmlcreate" class="user.User" scope="page" />
<jsp:setProperty name="htmlcreate" property="userID" />
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make HTML</title>
</head>
<body>
	<iframe width=0 height=0 name="hiddenframe" style="display:none;"></iframe>
	<% 
		String htmlcode = request.getParameter("htmlcode"); 
		HTMLCreateDAO htmlCreateDAO = new HTMLCreateDAO();
		int result = htmlCreateDAO.makeHTML((String)session.getAttribute("userID"), htmlcode);
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("function fileDown(){window.location.assign(\"downPDF.jsp\")}");
		script.println("fileDown()");
		script.println("setTimeout('history.back()',1000)");
		script.println("</script>");
	%>
</body>
</html>