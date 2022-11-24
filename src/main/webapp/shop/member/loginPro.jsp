<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id= request.getParameter("id");
	String password = request.getParameter("password");
	MemberDao mdao=MemberDao.getInstance();
	MemberBean mb=mdao.getMemberByLogin(id, password);
	String viewPage;
	if(mb!=null){
		String mid=mb.getId();
		int mno = mb.getNo();
		String nickname=mb.getNickname();
		session.setAttribute("mid", mid);
		session.setAttribute("mno", mno); 
		session.setAttribute("nickname",nickname );
		if(mid.equals("admin")){
			viewPage=request.getContextPath()+"/shop/admin/admin_Main.jsp";
		} else {
			viewPage=request.getContextPath()+"/Main.jsp";			
		}
	} else {
		viewPage=request.getContextPath()+"/shop/member/login.jsp";
		%>
		<script>
			alert("가입하지 않은 회원입니다.");
		</script>	
		<%
	} 
	%>
<script>
	location.href="<%=viewPage%>";
</script>

