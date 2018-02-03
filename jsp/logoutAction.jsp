<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html lang = "ko">
    <head>
        <meta charset="utf-8" content="text/html" http-equiv="Content-Type">
        <title>My diary</title>
    </head>

    <body>
		<%
			session.invalidate();
		%>
		<script>
			location.href='../mydiary.html';
		</script>
    </body>
</html>