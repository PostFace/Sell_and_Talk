<%@page import="shop.board.ReBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="rb" class="shop.board.ReBoardBean"/>
<jsp:setProperty property="*" name="rb"/>
<%
	request.setCharacterEncoding("UTF-8");
	ReBoardDao rd=ReBoardDao.getInstance();
	String num=request.getParameter("num"); //부모번호(선택한 글)
	String pageNum=request.getParameter("pageNum");
	rb.setWriter((String)session.getAttribute("nickname"));
	int result=rd.insertReple(rb);
	String msg,url="content.jsp?num="+num+"&pageNum="+pageNum;
	if(result>0){
		msg="삽입성공";
	} else{
		msg="삽입실패";		
	}
%>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href="<%=url%>";
</script>