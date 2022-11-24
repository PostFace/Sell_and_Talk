<%@page import="shop.board.DailyBoardDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
updatePro.jsp<br>
<%

request.setCharacterEncoding("UTF-8");
%>

<% 
	DailyBoardDao bdao=DailyBoardDao.getInstance();
	
	String writer=(String)session.getAttribute("mid");

	String msg;
	String url;	
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
		 	
		
		
	if(writer!=null){
		int result=bdao.updateArticle(mr); 
		if(result>0){
			msg="수정 완료";
			url="list.jsp?pageNum="+mr.getParameter("pageNum");
		} else if(result==-2){
			msg="작성자만 수정할 수 있습니다.";
			url="content.jsp?num="+mr.getParameter("num")+"&pageNum="+mr.getParameter("pageNum");
		} else {
			msg="수정 실패.";
			url="updateForm.jsp?num="+mr.getParameter("num")+"&pageNum="+mr.getParameter("pageNum");	
		}
	}
	else {
		msg="로그인 후 이용해 주세요.";
		url="content.jsp?num="+mr.getParameter("num")+"&pageNum="+mr.getParameter("pageNum");
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>