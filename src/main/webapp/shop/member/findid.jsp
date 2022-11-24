<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Main_top2.jsp" %>

[아이디 찾기]		
<br>  
	<br>
	<form action="findidPro.jsp" method="post">
		<table height=120 cellspacing = 0>
			<tr>
		<td align="center">이름</td>
		<td><input type="text" name="name" placeholder="홍길동">    	
	</tr>
	<tr>
		<td align="center">주민 등록 번호</td>
		<td>
			<input type="text" name="rrn1" maxlength="6" size="6" placeholder="111111">
			- 
			<input type="text" name="rrn2" maxlength="7" size="7" placeholder="2222222">
		</td>				
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="아이디 찾기">
		</td>
	</tr>	
		</table>
	</form>
<%@ include file="/Main_bottom.jsp" %>	