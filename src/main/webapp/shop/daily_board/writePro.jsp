<%@page import="shop.board.DailyBoardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.Timestamp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writePro.jsp<br>
<%

request.setCharacterEncoding("UTF-8");
%>

<%	
ServletContext sContext= config.getServletContext();
String folderPath=sContext.getRealPath("/shop/images");
int maxSize=1024*1024*5;
String encType="UTF-8";
MultipartRequest mr=new MultipartRequest( 
											request,
											folderPath,
											maxSize,
											encType,
											new DefaultFileRenamePolicy()
											);
	DailyBoardDao bdao=DailyBoardDao.getInstance();
	String proname=mr.getFilesystemName("image"); 	
	
	int result = bdao.insertArticle(mr);
	String msg;
	String url;
	if(result>0){
		msg="삽입성공";
		url="list.jsp";
	} else{
		msg="삽입실패";
		url="writeForm.jsp";		
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";

</script>

