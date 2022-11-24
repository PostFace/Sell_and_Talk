<%@page import="shop.board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
replyPro.jsp<br> <!-- 입력한 정보 5개+부모3가지+(작성일+ip부가로 생성) -->
<%

request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bb" class="shop.board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%
	BoardDao bdao=BoardDao.getInstance();
	bb.setReg_date(new Timestamp(System.currentTimeMillis()));
	bb.setIp(request.getRemoteAddr());
	System.out.println("ref:"+bb.getRef());
	System.out.println("re_level:"+bb.getRe_level());
	System.out.println("re_step:"+bb.getRe_step());
	int result = bdao.replyArticle(bb);
	String msg;
	String url;
	if(result>0){
		msg="삽입성공";
		url="list.jsp";
	} else{
		msg="삽입실패";
		url="replyForm.jsp?ref="+bb.getRef()+"&re_step="+bb.getRe_step()+
				"&re_level="+bb.getRe_level();	
	} 
%>	
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>