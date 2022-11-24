<%@page import="shop.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
updatePro.jsp<br>
<%

request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bb" class="shop.board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<% 
	BoardDao bdao=BoardDao.getInstance();
	String pageNum=request.getParameter("pageNum");
	String writer=(String)session.getAttribute("mid");
	System.out.println(pageNum);
	String msg;
	String url;	
	if(writer!=null){
		int result=bdao.updateArticle(bb);
		if(result>0){
			msg="수정 완료";
			url="list.jsp?pageNum="+pageNum;
		} else if(result==-2){
			msg="작성자만 수정할 수 있습니다.";
			url="content.jsp?num="+bb.getNum()+"&pageNum="+pageNum;
		} else {
			msg="수정 실패.";
			url="updateForm.jsp?num="+bb.getNum()+"&pageNum="+pageNum;		
		}
	}
	else {
		msg="로그인 후 이용해 주세요.";
		url="content.jsp?num="+bb.getNum()+"&pageNum="+pageNum;
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>