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
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<link rel="stylesheet" href="css/frame.css?v=3">
	<link rel="stylesheet" href="css/inputlayout.css?v=1">
	<link rel="stylesheet" href="css/button.css?v=1">
	<link rel="stylesheet" href="css/form.css?v=2">
	<link rel="stylesheet" href="css/mainheader.css?v=1">
	<link rel="stylesheet" href="css/search.css">
	<link rel="stylesheet" href="css/aside.css">
	<title>My diary</title>
</head>
<body>
<div id="container">



	
	
<header class="header-login-signup">
	<div class="header-limiter">
		<h1><a href="main.jsp">MY<span>DIARY</span></a></h1>

		<nav>
			<a href="picactivity.jsp" >Make portfolio</a>
			<a href="#layer2" class="selected">Add activity</a>
		</nav>

		<ul>
			<li><a href="jsp/logoutAction.jsp">Log out</a></li>
		</ul>

	</div>
</header>
	
			<%
				ActivityDAO activityDAO = new ActivityDAO();
				String keyword = request.getParameter("keyword");
				ArrayList<Activity> list;
				if(keyword==null||keyword.equals(""))
				{
					list = activityDAO.getList((String) session.getAttribute("userID"));
				}
				else
				{
					list = activityDAO.getListByKeyword((String) session.getAttribute("userID"),keyword);
				}
				ArrayList<String> yearList = activityDAO.getYear((String) session.getAttribute("userID"));
			%>	
	
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
				for(int i=0; i<yearList.size(); i++) {
			%>
				<li class="menu"> <a href="#"><%=yearList.get(i) %></a>
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
			<%
				for(int i=0; i<list.size(); i++) {
			%>
			
			
		
	

			
	

		    <div class="thumbnail">
		      <div class="caption">
		        <h3><%= list.get(i).getActName()%></h3>
		        <p ><%= list.get(i).getActSummary()%></p>
		      </div>
		      <div class="thum-btn">
		      	<p><a href="modify.jsp?actNum=<%=list.get(i).getActNum()%>" class="btn btn-primary" role="button">modify</a> 
		       	<a href="jsp/deleteAction.jsp?actNum=<%=list.get(i).getActNum()%>" class="btn btn-default" role="button">delete</a></p>
		       </div>
			</div>
			
			
			
			
			<%
				}
			%>
	
	</div>
	
	<div class="dim-layer">
		<div class="dimBg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<form action="jsp/activityAddAction.jsp" method="post" class="pop-conts" id="frm">
					<!--content //-->
					<p class="ctxt mb20">활동 종류</p>
					<input maxlength="24" type= "text" name="actType" onblur="inputLengthCheck(this);" autofocus required>
					<p class="ctxt mb20">활동 이름</p>
					<input maxlength="19" type= "text" name="actName" onblur="inputLengthCheck(this);" required>
					<p class="ctxt mb20">활동 요약</p>
					<input maxlength="100" type= "text" name="actSummary" onblur="inputLengthCheck(this);" required>
					<div class="btn-r">
						<a href="#"  style="text-decoration:none" class="btn-layerClose">Close</a>
						<a href="#"  style="text-decoration:none" onclick="document.getElementById('frm').submit();" class="btn-layerAdd">Add</a>
					</div>
					<!--// content-->
				</form>
			</div>
		</div>
	</div>

	<script src="js/index.js?v=2"></script>
	<script src="js/checklength.js"></script>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    	<script src="js/bootstrap.min.js"></script>
</div>
</body>
</html>
