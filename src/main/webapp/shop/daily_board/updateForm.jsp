
<%@page import="shop.board.DailyBoardBean"%>
<%@page import="shop.board.DailyBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>      

<% 
	DailyBoardDao bdao=DailyBoardDao.getInstance();
	String num=request.getParameter("num");
	DailyBoardBean bb=bdao.updateGetArticle(num);
	String pageNum=request.getParameter("pageNum");
%>



    <style type="text/css">
	body{
		text-align: center;
	}
	table{
		margin: auto;
	}
</style>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>    
writeForm.jsp<br>
<body>

<%if(mid!=null){ %>
		
		<form method="post" enctype="multipart/form-data" name="writeform" action="updatePro.jsp" onsubmit="return writeSave()"> 
			<table width="480" border="1" cellspacing="0" cellpadding="0"
				 align="center">
				<tr>
					<td align="right" colspan="2">
						<a href="list.jsp"> 글목록</a>
					</td>
				</tr>
				<tr>
					<td width="150" align="center">이 름</td>
					<td width="330" align="left">
					<input type="text" size="30" maxlength="10"	name="writer" 
							value="<%=nickname%>" readonly></td>
				</tr>
				
				<tr>
					<td width="150" align="center">제 목</td>
					<td width="330" align="left">					
						<input type="text" size="50" maxlength="50" name="subject" 
								value="<%=bb.getSubject() %>">
						<input type="hidden"  name="num" 
								value="<%=num %>">
						<input type="hidden"  name="pageNum" 
								value="<%=pageNum %>">
					</td>
				</tr>
				<tr>
					<td width="150" align="center">상품이미지</td>
					<td  width="330"  align="left">
						<input type="file" name="image">
					</td>
				</tr>			
				<tr>
					<td width="150" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" id="abc" rows="13" cols="50"><%=bb.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center" height="30">
						<input	type="submit" value="글쓰기"> 
						<input type="reset"	value="다시작성"> 
						<input type="button" value="목록보기"	
								OnClick="window.location='list.jsp'">
					</td>
				</tr>
			</table>	
		</form>
		<%}else{
			%>
		<script type="text/javascript">
			alert('로그인 후 이용가능합니다.');
			location.href="list.jsp?pageNum=<%=pageNum%>";
		</script>
		<%} %>
		<%@include file="/Main_bottom.jsp" %>   