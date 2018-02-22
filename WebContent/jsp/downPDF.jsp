<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Down PDF</title>
    
</head>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script src="../js/html2canvas.min.js"></script>
   	<script src="https://unpkg.com/jspdf@latest/dist/jspdf.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#header").load("../Portfolio.html")
		});

	</script>
<body>

   	<div id="header" style="width:800px;word-break:break-all;">
   	</div>
	<script>

  	function canvas(){
		html2canvas(document.body, {
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
				heightLeft-=pageHeight;
				while (heightLeft >= 20) {
					position = heightLeft - imgHeight;
					doc.addPage();
					doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
					heightLeft -= pageHeight;
				}
				doc.save('sample-file.pdf');
				
			}
		});
  	}
	  	setTimeout('canvas()',100);
	  	setTimeout('history.back();',1000);
	</script>
</body>
</html>