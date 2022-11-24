<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp"%> 
<%
	if(mid!=null){
		MemberDao mdao=MemberDao.getInstance();
		MemberBean mb=mdao.getProfile(mid);	
		String exp="신입회원";
		
			
	   	if(mb.getExp()>1000000){
			exp="관리자";
		} else if(mb.getExp()>10000){
			exp="감사회원";
		} else if(mb.getExp()>1000){
			exp="유명회원";
		} else if(mb.getExp()>100){
			exp="열심회원";
		} else if(mb.getExp()>10){
			exp="일반회원";
		}
%>  

		<table width=400 height=300>
			<tr>
				<td colspan='5'><b>마이페이지</b></td>
			</tr>
			<tr align="left">
				<td colspan='2'>아이디</td>
				<td colspan='3'><%=mb.getId() %></td>
			</tr>
			<tr align="left">
				<td colspan='2'>이름</td>
				<td colspan='3'><%=mb.getName() %></td>
			</tr>
			<tr align="left">
				<td colspan='2'>닉네임</td>
				<td colspan='2'><%=mb.getNickname() %></td>
				<td ><input type="button" value="닉네임 변경" class="btn"></td>
			</tr>
			<tr align="left">
				<td colspan='2'>회원번호</td>
				<td colspan='3'><%=mb.getNo() %></td>
			</tr>
			<tr align="left">
				<td colspan='2'>가입일자</td>
				<td colspan='3'><%=mb.getJoindate() %></td>
			</tr>
			<tr align="left">
				<td colspan='2'>회원등급</td>
				<td colspan='3'><%=exp %></td>
			</tr>
			<tr align="left">
				<td colspan='2'>전화번호</td>
				<td colspan='3'>
				<%=mb.getHp1() %> - 
				<%=mb.getHp2() %> - 
				<%=mb.getHp3() %>
				</td>
			</tr>
		</table>

<%}else{ %>
		<script type="text/javascript">
			alert('로그인 후 이용 가능합니다.');
			location.href="<%=request.getContextPath()%>/Main.jsp"
		</script>
		<%} %>     

<%@include file="/Main_bottom.jsp"%>    