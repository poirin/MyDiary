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
	<link rel="stylesheet" href="css/frame.css?v=2">
	<link rel="stylesheet" href="css/button.css?v=1">
	<link rel="stylesheet" href="css/inputlayout.css?v=1">
	<link rel="stylesheet" href="css/form.css?v=1">
	<link rel="stylesheet" href="css/mainheader.css?v=1">
	<link rel="stylesheet" href="css/search.css?v=2">
	<link rel="stylesheet" href="css/aside.css?v=1">
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<title>My diary</title>
</head>
<body>
<div id="container">
	<header class="header-login-signup">
		<div class="header-limiter">
			<h1><a href="main.jsp">MY<span>DIARY</span></a></h1>
	
	
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
				<li class="menu"> <a href="#" style="text-decoration:none"><%=yearList.get(i) %><span class="badge"><%=yearsize %></span></a>
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
								<li ><a href="modify.jsp?actNum=<%=list.get(j).getActNum()%>" style="text-decoration:none"> -&nbsp;&nbsp;&nbsp;&nbsp;<%=list.get(j).getActName() %></a></li>
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
	<%
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
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
		Activity activity = new ActivityDAO().getActivity(userID,actNum);
	%>
	<div id="main_section">
	<div style="margin-top:50px">
		<form action="jsp/modifyAction.jsp?actNum=<%=actNum%>" method="post" id="modify_form" class="form-horizontal ">
		
			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Type</label>
				<div class="col-md-6">
					<input maxlength="24" name="actType" class="form-control" type="text" value="<%=activity.getActType()%>" onblur="inputLengthCheck(this);" required><br>
				</div>
          	</div>	
 
			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Name</label>
				<div class="col-md-6">
					<input maxlength="19" name="actName" class="form-control" type="text" value="<%=activity.getActName()%>" onblur="inputLengthCheck(this);" required><br>
				</div>
			</div>


			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Date</label>
				<div class="col-sm-10">
					<div class="date-line">
						<input name="startDate" class="form-control" type="date" value="<%=activity.getStartDate()%>">
					</div> 
					<div class="date-line">
						<p>~</p>
					</div>
					<div class="date-line">
						<input name="endDate" class="form-control" type="date" value="<%=activity.getEndDate()%>">
					</div>
				</div>
			</div><br>


			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Summary</label>
				<div class="col-sm-10">
					<textarea class="form-control" maxlength="100" name="actSummary" class="form-control" rows="5" cols="50" value="<%=activity.getActSummary()%>"><%=activity.getActSummary()%></textarea><br>
				</div>
			</div>
           	<br>


			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Contents</label>
				<div class="col-sm-10">
					<textarea class="form-control" maxlength="1000" name="actContent" rows="30" cols="100" placeholder="Description"><%if(activity.getActContent()!=null)%><%=activity.getActContent()%></textarea>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Result</label>
				<div class="col-sm-10">
					<textarea class="form-control" maxlength="1000" name="actResult" rows="20" cols="100" placeholder="Description"><%if(activity.getActResult()!=null)%><%=activity.getActResult()%></textarea>
				</div>
			</div>
	
			<div class="form-group">
				<label class="col-sm-2 control-label">Activity Name</label>
				<div class="col-sm-10">
					<select class="form-control" name="actStatus">
						<option value="<%if(activity.getActStatus()==null||activity.getActStatus().equals("선택")){%>선택<%}else if(activity.getActStatus().equals("완료됨")||activity.getActStatus().equals("진행중")||activity.getActStatus().equals("예정")){%><%=activity.getActStatus()%><%}else{%>선택<%}%>" selected="selected"><%if(activity.getActStatus()!=null)%><%=activity.getActStatus()%></option>
						<option value="완료됨">완료됨</option>
						<option value="진행중">진행중</option>
						<option value="예정">예정</option>
					</select>
				</div>
			</div>	
			
			<div id="btn-modify">
				<a href="main.jsp" class="btn btn-default">취소</a>
				<a href="#" onclick="document.getElementById('modify_form').submit();" class="btn btn-default">수정</a>
			</div>
		</form>
	</div>
	</div>
	
	<div class="dim-layer">
		<div class="dimBg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<form action="jsp/activityAddAction.jsp" method="post" class="pop-conts" id="frm">
					<!--content //-->
					<p class="ctxt mb20">활동 종류</p>
					<input type= "text" name="actType" autofocus required>
					<p class="ctxt mb20">활동 이름</p>
					<input type= "text" name="actName" required>
					<p class="ctxt mb20">활동 설명</p>
					<input type= "text" name="actSummary" required>
					<div class="btn-r">
						<a href="#" class="btn-layerClose">Close</a>
						<a href="#" onclick="document.getElementById('frm').submit();" class="btn-layerAdd">Add</a>
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
