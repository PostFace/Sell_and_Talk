<%@page import="shop.board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
writePro.jsp<br>
<%

request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bb" class="shop.board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/> 
<%
	BoardDao bdao=BoardDao.getInstance();
	bb.setReg_date(new Timestamp(System.currentTimeMillis())); 	
	bb.setIp(request.getRemoteAddr());
	int result = bdao.insertArticle(bb);
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

