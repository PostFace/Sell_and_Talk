<%@page import="shop.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mb" class="shop.member.MemberBean"/>
<jsp:setProperty property="*" name="mb"/>
<% 
	/* System.out.println(mdto.getId());
	System.out.println(mdto.getHp1());
	System.out.println(mdto.getHp2());
	System.out.println(mdto.getName());
	System.out.println(mdto.getEmail()); */
	MemberDao mdao=MemberDao.getInstance();
	int result=mdao.insertMember(mb);
	String msg;
	String url;
	if(result>0){
		msg="입력 성공";
		url=request.getContextPath()+"/Main.jsp";
	} else {
		msg="입력 실패";
		url="register.jsp";		
	}
%>
<script type="text/javascript">
	alert('<%=msg%>');
	location.href='<%=url%>';
</script>