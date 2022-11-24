<%@page import="shop.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userid=request.getParameter("userid");
	System.out.println(userid);
	MemberDao mdao=MemberDao.getInstance();
	boolean isCheck=mdao.searchId(userid);    
	System.out.println("isCheck:"+isCheck);
	String str;
	if(isCheck){ 
		str="NO";
		System.out.println("str:"+str);
		out.print(str); 
	} else { 
		str="YES";
		System.out.println("str:"+str);
		out.print(str);
	}
%>