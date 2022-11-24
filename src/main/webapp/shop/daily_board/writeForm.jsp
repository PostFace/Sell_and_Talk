<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style type="text/css">
	body{
		text-align: center;
	}
	table{
		margin: auto;
	}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>    
<%@include file="/Main_top.jsp" %>  
<%
	if(mid!=null){
%>

<body>
		<b>글쓰기</b> <br>
	
		<form method="post" enctype="multipart/form-data" name="writeform" action="writePro.jsp" onsubmit="return writeSave()"> 
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
								placeholder="제목">
					</td>
				</tr>
				<tr>
					<td width="150">이미지</td>
					<td width="330" align="left">
						<input type="file" name="image">
					</td>
				</tr>			
				<tr>
					<td width="150" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" id="abc" rows="13" cols="50" placeholder="글을 작성하세요."></textarea>
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
			String pageNum=request.getParameter("page");%>
		<script type="text/javascript">
			alert('로그인 후 이용가능합니다.');
			location.href="list.jsp?pageNum=<%=pageNum%>";
		</script>
		<%} %>
		<%@include file="/Main_bottom.jsp" %>  
				