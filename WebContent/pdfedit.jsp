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
			<a href="#" id ="download">Download HTML</a>
		
			<!--  <a href="#" onclick="document.forms['viewhtml'].submit();">Download HTML</a>-->
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
<script>
	$('#download').click(function() {
		var iframe = document.createElement('iframe');
		document.body.appendChild(iframe);
	    var iframedoc = iframe.contentDocument||iframe.contentWindow.document;
	    iframe.width = ""+(document.getElementsByClassName('gjs-frame')[0].clientWidth+70)+"px";
		iframe.height ="0px";
	    
    	iframedoc.body.innerHTML = "<!DOCTYPE html><style>"+editor.getCss()+"</style><body>"+editor.getHtml()+"</body>";

        html2canvas(iframedoc.body, {
            onrendered: function(canvas) 
            {  

                var imgData = canvas.toDataURL('image/png');
                
                var imgWidth = 210;
                var pageHeight = imgWidth * 1.414;
                var imgHeight = canvas.height *imgWidth/canvas.width;
                var heightLeft = imgHeight;
            	var doc = new jsPDF('p', 'mm');
            	var position = 0;

                doc.addImage(imgData, 'PNG',0,position,imgWidth, imgHeight);
                while (heightLeft >= 20) {
                    position = heightLeft - imgHeight;
                    doc.addPage();
                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;
                  }
            	//var width = doc.internal.pageSize.width;
                doc.save('sample-file.pdf');
                iframe.style.display="none";
            }
        });
    });
    </script>
</body>
</html>