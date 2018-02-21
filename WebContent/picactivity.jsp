<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="activity.ActivityDAO"%>
<%@ page import="activity.Activity"%>
<%@ page import="java.util.ArrayList"%>
<!doctype html>
<html lang = "ko">
<head>
	<meta charset="utf-8" content="text/html" http-equiv="Content-Type">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="css/inputlayout.css?v=1">
	<link rel="stylesheet" href="css/button.css?v=1">
	<link rel="stylesheet" href="css/form.css?v=1">
	<link rel="stylesheet" href="css/mainheader.css?v=1">
	<link rel="stylesheet" href="css/frame.css?v=1">
	<link rel="stylesheet" href="css/search.css?v=1">
	<link rel="stylesheet" href="css/aside.css?v=1">
	<link rel="stylesheet" href="css/indexstyle.css?v=1">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<title>My diary</title>
</head>
<body>
<div id="container">
<header class="header-login-signup">
	<div class="header-limiter">
		<h1><a href="main.jsp">MY<span>DIARY</span></a></h1>

		<nav>
			<a href="#" onclick="document.forms['radform'].submit();">Select activity</a>
		</nav>

		<ul>
			<li><a href="jsp/logoutAction.jsp">Log out</a></li>
		</ul>

	</div>
</header>
<div id="main_aside"> 
	<div id="title">
		 <form id="search" style="display:inline;" method="get" action="main.jsp">
			<input id="search-box" name="keyword" size="40" type="text" placeholder="Search"/>
			<input id="search-btn" value="Go" type="submit"/>
		</form>
	</div>
	<div id="asidebottom">
		<aside>
			<ul>
			<%
				ActivityDAO activityDAO = new ActivityDAO();
				String keyword = request.getParameter("keyword");
				ArrayList<Activity> list;
				list = activityDAO.getList((String) session.getAttribute("userID"));
				ArrayList<String> yearList = activityDAO.getYear((String) session.getAttribute("userID"));
				for(int i=0; i<yearList.size(); i++) {
					int yearsize=0;
					for(int j=0; j<list.size(); j++) {
						int start,end;
						if(list.get(j).getStartDate()!=null) 
							start = Integer.parseInt(list.get(j).getStartDate().substring(0,4));
						else 
							start = 0;
						
						if(list.get(j).getEndDate()!=null) 
							end = Integer.parseInt(list.get(j).getEndDate().substring(0,4));
						else 
							end = 0;
						
						int thisyear = Integer.parseInt(yearList.get(i));
						if(start==thisyear || end==thisyear || (start!=0 && end!=0 && thisyear<end && thisyear>start))
						{	
							yearsize++;
						}
					}
			%>
				<li class="menu"> <a href="#"><%=yearList.get(i) %><span class="badge"><%=yearsize %></span></a>
					<ul class="yearlist">
					<%
						for(int j=0; j<list.size(); j++) {
							int start,end;
							if(list.get(j).getStartDate()!=null) 
								start = Integer.parseInt(list.get(j).getStartDate().substring(0,4));
							else 
								start = 0;
							
							if(list.get(j).getEndDate()!=null) 
								end = Integer.parseInt(list.get(j).getEndDate().substring(0,4));
							else 
								end = 0;
							
							int thisyear = Integer.parseInt(yearList.get(i));
							if(start==thisyear || end==thisyear || (start!=0 && end!=0 && thisyear<end && thisyear>start))
							{	
								%>
								<li ><a href="modify.jsp?actNum=<%=list.get(j).getActNum()%>">-&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(j).getActName() %></a></li>
								<%
							}
						}
					%>
					</ul>
				</li>
			<%
				}
			%>
			</ul>
  		</aside>
					
	</div>
</div>
	<div id="main_section">
	<div style="margin-top:30px; margin-left:30px">
		<p class="register">"Want another design? "
			<a href="pdfedit.jsp">Create your own design!</a>
		</p>
	</div>
		<form id="radioform" method="get" action="selactivity.jsp" name="radform">
		<div id="activity_form">
			<%
				for(int i=0; i<24; i++) {
			%>
			
			<div class="thumbnail">
				<% if(i==0){%>
					<input type="radio" name="select" value="<%=i%>" style="width:24px;height:24px" checked>
					<% }else{ %>
					<input type="radio" name="select" value="<%=i%>" style="width:24px;height:24px">
					<%}%>
	
					<div id="activity-cont">
						<img src = "ppttheme/<%=i%>.png" width="100%"/>
					</div>
			</div>
			<%
				}
			%>
		</div>
		<input type = "hidden" name="maketype" value="ppt"/> <!-- Make Type : ppt selactivity's argument  -->
	
		</form>
	</div>

	<script src="js/index.js?v=2"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</div>
</body>
</html>
