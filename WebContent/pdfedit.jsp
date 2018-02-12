<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<script src="http://code.jquery.com/jquery-latest.js"></script>

 	<link href="https://unpkg.com/grapesjs/dist/css/grapes.min.css" rel="stylesheet">
    <script src="https://unpkg.com/grapesjs"></script>
    <script src="dist/grapesjs-blocks-basic.min.js"></script>

    <script src="js/html2canvas.min.js"></script>
   	<script src="https://unpkg.com/jspdf@latest/dist/jspdf.min.js"></script>
	<style>
	#main_section {

	   width:100%;
	   height:100%;
	}
	.gjs-pn-panel {
		padding: 0px;
	}
	</style>
	<title>My diary</title>
</head>
<body>
<div id="container">
<header class="header-login-signup">
	<div class="header-limiter">
		<h1><a href="main.jsp">MY<span>DIARY</span></a></h1>

		<nav>
			<a href="#" onclick="document.forms['viewhtml'].submit();">Download HTML</a>
		</nav>

		<ul>
			<li><a href="jsp/logoutAction.jsp">Log out</a></li>
		</ul>

	</div>
</header>


	<div id="main_section">
	
    	<div id="gjs" style="height:0px; overflow:hidden">
    	
		<div class="activityType">활동종류</div>
		<div class="activityName">활동이름</div>
		<div class="activityDate">활동일자</div>
		<div class="activitySummary">활동요약</div>
		<div class="summaryDescription">활동요약Description</div>
		<div class="activityContent">활동내용</div>
		<div class="contentDescription">활동내용Description</div>
		<div class="activityResult">활동결과</div>
		<div class="resultDescription">활동결과Description</div>
		<div class="activityStatus">활동상태</div>
		
		<style>
			.activityType{padding:10px;}
			.activityName{padding:10px;}
			.activityDate{padding:10px;}
			.activitySummary{padding:10px;}
			.summaryDescription{padding:10px;}
			.activityContent{padding:10px;}
			.contentDescription{padding:10px;}
			.activityResult{padding:10px;}
			.resultDescription{padding:10px;}
			.activityStatus{padding:10px;}
		</style>
    	</div>

 		<script type="text/javascript">
			var editor = grapesjs.init({
				height: '100%',
				noticeOnUnload: 0,
				storageManager:{autoload: 0},
 				container : '#gjs',
				fromElement: true,

				plugins: ['gjs-blocks-basic'],
				pluginsOpts: {
					'gjs-blocks-basic': {}
				}
			});

		window.editor = editor;
    </script>
    </div>


	<script src="js/index.js?v=2"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</div>
<form method="GET" action = "jsp/makeHTML.jsp" name="viewhtml">
	<input type = "text" id ="htmlcode" name="htmlcsscode" value="">
</form>
<script>
	document.getElementById('htmlcode').value = "<!DOCTYPE html><style>"+editor.getCss()+"</style><body>"+editor.getHtml()+"</body>";
</script>
<script>
    $('#download').click(function() {       
        html2canvas(document.body, {
            onrendered: function(canvas) {         
                var imgData = canvas.toDataURL(
                    'image/png');              
                var doc = new jsPDF('p', 'mm');
                doc.addImage(imgData, 'PNG', 10, 10);
                doc.save('sample-file.pdf');
            }
        });
    });
    </script>
</body>
</html>
