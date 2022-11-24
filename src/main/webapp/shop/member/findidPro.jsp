<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<% 
	request.setCharacterEncoding("UTF-8");
	String name=request.getParameter("name");
	String rrn1=request.getParameter("rrn1");
	String rrn2=request.getParameter("rrn2");
	MemberDao mdao=MemberDao.getInstance();
	String id;//getMemberByRrn;
	MemberBean mdto=mdao.getMemberByRrn(name, rrn1, rrn2);
	String msg;	
	if(mdto!=null){
		msg="찾으신 ID는 "+mdto.getId()+" 입니다.";
	} else {
		msg="찾으시는 ID가 존재하지 않습니다.";		
	}
%>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href='<%=request.getContextPath()%>/shop/member/login.jsp';
</script>
