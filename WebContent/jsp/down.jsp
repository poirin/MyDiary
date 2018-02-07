<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.File"%>
<%
 request.setCharacterEncoding("UTF-8");
 response.setCharacterEncoding("UTF-8");
 response.setContentType("text/html;charset=UTF-8");

 String filename = "Portfolio.pptx";
 //String folder = "/home/hosting_users/poirin/tomcat/webapps/ROOT/WEB-INF/";
 String folder = request.getRealPath("")+"/";
 File file = new File(folder+"Portfolio.pptx");

 byte b[] = new byte[(int)file.length()];
 if(file.length() > 0 && file.isFile()){ //0byte 이상이고, 해당 파일이 존재하는 경우
  response.setContentType("application/x-msdownload");
  response.setHeader("Content-Disposition", "attachment;filename="+ filename + ";");
  
  BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));

  BufferedOutputStream output = new BufferedOutputStream(response.getOutputStream());

  int read = 0;
  try{
   while((read = input.read(b)) != -1){
    output.write(b, 0, read);
   }
   output.close();
   input.close();
   out.clear();
   out = pageContext.pushBody();
   
  }catch(Exception e){
   System.out.println("에러메세지: " + e.getMessage());
  }finally{
   if(output != null){output.close();}
   if(input != null){input.close();}
  }
 }else{
%>
<script>
alert("File Not Found");
self.close();
</script>
<%
 }
%>



