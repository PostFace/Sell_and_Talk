<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Main_top2.jsp" %>

[로그인 화면]		
<br>  
	<br>
	<form action="loginPro.jsp" method="post">
		<table height=120 cellspacing = 0>
			<tr>
				<td align="center">아이디</td> 
				<td><input type="text" name="id" placeholder="ID"></td>
			</tr>
			<tr>
				<td  align="center">비번</td>
				<td><input type="password" name="password" placeholder="1234"></td>
			</tr>
			<tr>
				<td colspan='2' align="center">
					<input type="submit" value="로그인" class="btn">
					<input type="button" value="회원 가입" class="btn"
					onclick="location.href='<%=request.getContextPath()%>/shop/member/register.jsp'">
					<!-- ./myshop/member/register.jsp -->
					<input type="button" value="아이디 찾기" class="btn"
					onclick="location.href='<%=request.getContextPath()%>/shop/member/findid.jsp'">
					<input type="button" value="비번 찾기" class="btn"
					onclick="location.href='<%=request.getContextPath()%>/shop/member/findpw.jsp'">
				</td>
			</tr>
		</table>
	</form>
<%@ include file="/Main_bottom.jsp" %>	