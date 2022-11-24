<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>  

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

<%
	String ref=request.getParameter("ref");
	String re_step=request.getParameter("re_step");
	String re_level=request.getParameter("re_level");
	System.out.println(ref);
	System.out.println(re_step);
	System.out.println(re_level);
	
%>
<body>
<%
	if(mid!=null){
%>
		<b>답글쓰기</b> <br>
		<form method="post" name="writeform" action="replyPro.jsp" onsubmit="return writeSave()">
		<input type="hidden" name="ref" value="<%=ref%>"> 
		<input type="hidden" name="re_step" value="<%=re_step%>"> 
		<input type="hidden" name="re_level" value="<%=re_level%>"> 		
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
								placeholder="[답글]어떤글">
					</td>
				</tr>
				
				
				<tr>
					<td width="150" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" id="abc" rows="13" cols="50" placeholder="내용 입력"></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan=2 align="center" height="30">
						<input	type="submit" value="답글쓰기"> 
						<input type="reset"	value="다시작성"> 
						<input type="button" value="목록보기"	
								OnClick="window.location='list.jsp'">
					</td>
				</tr>
			</table>	
		</form>
		<%}else{
			String pageNum=request.getParameter("pageNum");%>
		<script type="text/javascript">
			alert('로그인 후 이용가능합니다.');
			location.href="list.jsp?pageNum=<%=pageNum%>";
		</script>
		<%} %>
<%@include file="/Main_bottom.jsp" %>  				