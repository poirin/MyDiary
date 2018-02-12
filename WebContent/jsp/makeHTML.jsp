<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="htmlcreate.HTMLCreateDAO" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="htmlcreate" class="user.User" scope="page" />
<jsp:setProperty name="htmlcreate" property="userID" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make HTML</title>
</head>
<body>

	<%
	String htmlCode = request.getParameter("htmlcsscode");
	HTMLCreateDAO htmlCreateDAO = new HTMLCreateDAO();
	int result = htmlCreateDAO.makeHTML(htmlCode);
	%>
</body>
</html>