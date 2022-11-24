
<%@page import="shop.member.MemberDao"%>
<%@page import="shop.member.MemberBean"%>
<%@page import="shop.board.BoardBean"%>
<%@page import="shop.board.BoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp"  %>


    
    
<style type="text/css">
	body{
		text-align: center;
	}
	table{
		margin: auto;
	}
</style>    

<% 
	int pageSize=10;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	int currentPage=Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize+1;
	int endRow = currentPage * pageSize;
	//1페이지 => startRow:1 endRow:10 => num칼럼 값은 아니다.
	//2페이지 => startRow:11 endRow:20
	BoardDao bdao=BoardDao.getInstance();
	int count = bdao.getArticleCount();
	System.out.println("count : "+count);
	ArrayList<BoardBean> lists=null;
	if(count>0){
		lists = bdao.getArticles(startRow,endRow);
	}
	int number=count-(currentPage-1)*pageSize;
%>
	<b>잡담게시판(전체 글 : <%=count %>)</b>

<%
	if(count == 0){
%>
	<table border="1" width="700">
	<tr>
		<td align="center">
			게시글이 없습니다.
		</td>
	</tr>
</table>
<%		
	}//if
	else{
%>
	<table border="1" width="700" class="table table-striped">
	<tr class="table-dark">
		<td align="center">번호</td>
		<td align="center">제목</td>
		<td align="center">작성자</td>
		<td align="center">작성일</td>
		<td align="center">조회수</td>
	</tr>
<%

	for(int i=0;i<lists.size();i++){
		BoardBean bb = lists.get(i);
		MemberDao mdao=MemberDao.getInstance();
		MemberBean mb=mdao.getProfileByNick(bb.getWriter());		
		String[] imt={"newbie.png","gosu.png","premium.png","admin.png"};
		String imtcon=imt[2];
		if(mb!=null){
			if(mb.getExp()>100000){
				imtcon=imt[3];
			} else if(mb.getExp()<9999&&mb.getExp()>1000){
				imtcon=imt[2];
			} else if(mb.getExp()<999&&mb.getExp()>10){
				imtcon=imt[1];
			}
		} else {
			imtcon=imt[0];
		}
		//System.out.println(imtcon);
%>
		<tr>
			<td align="right"><%=number-- %></td>
			<td align="left">
				<%
				if(bb.getRe_level()>0){
				%>
				
				<img src="images/level.gif" width="<%=bb.getRe_level()*20 %>" height="15">
				↳
				<% }
					%>
			<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=currentPage%>&nick=<%=bb.getWriter()%>"><%=bb.getSubject() %></a>
			<%if(bb.getReadcount()>=10){ %>
			<img src="images/hot_icon.gif" height="10" >
			<%} %>
			</td>
			<td align="center"><img src="<%=request.getContextPath()%>/images/<%=imtcon %>" height=20 width=20><%=bb.getWriter() %></td>
			<td align="center"><%=sdf.format(bb.getReg_date())%></td>
			<td align="right"><%=bb.getReadcount() %></td>
		</tr>

<%		
	}//for
%>

		
</table>
<table width="700">
	<tr>
		<td align="right">
			<a href="writeForm.jsp?page=<%=currentPage%>" class="btn btn-default">글쓰기</a>
		</td>
	</tr>
</table>

<%				
	}//else
	
	if(count>0){
		int pageCount=count/pageSize+(count%pageSize==0 ? 0 : 1);
		//pageCount : 전체 페이지 수
		int pageBlock=10;
		
		int startPage = ((currentPage-1)/pageBlock*pageBlock)+1;
		int endPage=startPage+pageBlock-1;
		if(endPage>pageCount)
			endPage=pageCount;
		
		if(startPage>10){
	%>
			<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>		
	<% 
		}//if
		for(int i=startPage;i<=endPage;i++){
	%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>		
	<%			
		}
		if(endPage<pageCount){
	%>
			<a href="list.jsp?pageNum=<%=startPage+10%>">[다음]</a>		
	<%
		}//if
	}//if(count>0)
%>
<%@include file="/Main_bottom.jsp" %> 
