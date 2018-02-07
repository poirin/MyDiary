<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="activity.ActivityDAO"%>
<%@ page import="activity.Activity"%>
<%@ page import="java.util.ArrayList"%>
<!doctype html>
<html lang = "ko">
<head>
	<meta charset="utf-8" content="text/html" http-equiv="Content-Type">
	<link rel="stylesheet" href="css/frame.css?v=1">
	<link rel="stylesheet" href="css/button.css?v=1">
	<link rel="stylesheet" href="css/inputlayout.css?v=1">
	<link rel="stylesheet" href="css/form.css?v=1">
	<link rel="stylesheet" href="css/mainheader.css?v=1">
	<link rel="stylesheet" href="css/search.css?v=1">
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
		<form action="jsp/modifyAction.jsp?actNum=<%=actNum%>" method="post" id="modify_form">
			<br><br>
			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 종류</titlefont><br><br>
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<input maxlength="24" name="actType" class="txt" type="text" value="<%=activity.getActType()%>" onblur="inputLengthCheck(this);" required><br>
          	
			<br><br><br><br>		
 
			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 이름</titlefont><br><br>
			
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<input maxlength="19" name="actName" class="txt" type="text" value="<%=activity.getActName()%>" onblur="inputLengthCheck(this);" required><br>
         
			<br><br><br><br>

			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 기간</titlefont><br><br>
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<input name="startDate" class="day" type="date" value="<%=activity.getStartDate()%>"> 
			~ 
			<input name="endDate" class="day" type="date" value="<%=activity.getEndDate()%>">
			<br><br><br><br>

			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 summary</titlefont><br><br>
			
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<textarea maxlength="100" name="actSummary" class="txt" rows="5" cols="50" value="<%=activity.getActSummary()%>"><%=activity.getActSummary()%></textarea><br>
          
			<br><br><br><br>

			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 내용</titlefont><br><br>
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<textarea maxlength="1000" name="actContent" rows="30" cols="100" placeholder="Description"><%if(activity.getActContent()!=null)%><%=activity.getActContent()%></textarea>
			<br><br><br><br>

			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;활동 결과</titlefont><br><br>
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<textarea maxlength="1000" name="actResult" rows="20" cols="100" placeholder="Description"><%if(activity.getActResult()!=null)%><%=activity.getActResult()%></textarea>
			<br><br><br><br>
	
			<titlefont>&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;진행 상태</titlefont><br><br>
			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
			<select name="actStatus">
				<option value="<%if(activity.getActStatus()==null||activity.getActStatus().equals("선택")){%>선택<%}else if(activity.getActStatus().equals("완료됨")||activity.getActStatus().equals("진행중")||activity.getActStatus().equals("예정")){%><%=activity.getActStatus()%><%}else{%>선택<%}%>" selected="selected"><%if(activity.getActStatus()!=null)%><%=activity.getActStatus()%></option>
				<option value="완료됨">완료됨</option>
				<option value="진행중">진행중</option>
				<option value="예정">예정</option>
			</select>
			<br><br><br><br>	
			
			<div id="btn-modify">
				<a href="main.jsp" class="Button">취소</a>
				<a href="#" onclick="document.getElementById('modify_form').submit();" class="Button">수정</a>
			</div>
		</form>
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
</div>
</body>
</html>
