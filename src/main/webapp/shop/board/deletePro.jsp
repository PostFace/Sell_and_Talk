<%@page import="shop.board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteForm.jsp=>deletePro.jsp<br>
<% 
	String num=request.getParameter("num");
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	String writer=(String)session.getAttribute("mid");
	String nickname=(String)session.getAttribute("nickname");
	
	BoardDao bdao=BoardDao.getInstance(); 
	String msg;
	String url;	
	if(writer!=null){
		int result= bdao.deleteArticle(num,nickname); 
		int count=bdao.getArticleCount();
		int pageCount=count/10+(count%10==0 ? 0 : 1);
			
		if(result>0){
			msg="삭제 완료";
			if(pageCount<pageNum){
				url="list.jsp?pageNum="+(pageNum-1);						
			} else {
				url="list.jsp?pageNum="+pageNum;
			}
		} else if(result==-2){
			msg="작성자만 삭제 가능합니다.";
			url="content.jsp?num="+num+"&pageNum="+pageNum;
		} else {
			msg="삭제 실패.";
			url="content.jsp?num="+num+"&pageNum="+pageNum;		
		}
	} else{
		msg="로그인 후 이용 가능합니다.";
		url="content.jsp?num="+num+"&pageNum="+pageNum;		
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
