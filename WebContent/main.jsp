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


<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
	  <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
      	<div align="center" style="margin-left:10px; margin-top:20px">
	      	<p>Using template design <button type="button" class="btn btn-default" style="margin:10px" onclick="location.href = 'picactivity.jsp'">ppt</button></p>
	    </div>
	    <div align="center" style="margin-left:10px; margin-top:20px">
	      	<p>Using your own design<button type="button" class="btn btn-default" style="margin:10px" onclick="location.href = 'pdfedit.jsp'">pdf</button></p>
	    </div>
      </div>
    </div>
  </div>
</div>
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">
        		<form action="jsp/activityAddAction.jsp" method="post" class="pop-conts" id="frm">
					<!--content //-->
					  <div class="form-group">
			            <p>Activity type:</p>
			            <input type="text" class="form-control" id="type" maxlength="24" name="actType" onblur="inputLengthCheck(this);" autofocus required>
			          </div>
			          
					  <div class="form-group">
			            <p>Activity name:</p>
			            <input type="text" class="form-control" id="actname" maxlength="19" name="actName" onblur="inputLengthCheck(this);" required>
			          </div>

					  <div class="form-group">
			            <p>Activity summary:</p>
			            <textarea class="form-control" id="actsum" maxlength="100" name="actSummary" onblur="inputLengthCheck(this);" required></textarea>
			          </div>
					<!--// content-->
				</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="document.getElementById('frm').submit();">Save</button>
      </div>
    </div>
  </div>
</div>
	
<header class="header-login-signup">
	<div class="header-limiter">
		<h1><a href="main.jsp">MY<span>DIARY</span></a></h1>

		<nav>
			<a href="#" data-toggle="modal" data-target=".bs-example-modal-sm">Make portfolio</a>
			<a href="#layer2" class="selected" data-toggle="modal" data-target="#myModal">Add activity</a>
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
				<li class="menu"> <a href="#" style="text-decoration:none"> <%=yearList.get(i) %><span class="badge"><%=yearsize %></span></a>
				
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
								<li ><a href="modify.jsp?actNum=<%=list.get(j).getActNum()%>" style="text-decoration:none">-&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(j).getActName() %></a></li>
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

	<script src="js/index.js?v=2"></script>
	<script src="js/checklength.js"></script>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</div>
</body>
</html>
