
<%@page import="shop.board.DailyBoardBean"%>
<%@page import="shop.board.DailyBoardDao"%>
<%@page import="shop.member.MemberDao"%>
<%@page import="shop.member.MemberBean"%>
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
	int pageSize=9;
	SimpleDateFormat sdf=new SimpleDateFormat("MM-dd HH:mm");
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	int currentPage=Integer.parseInt(pageNum);
	int startRow = (currentPage-1) * pageSize+1;
	int endRow = currentPage * pageSize;
	//1페이지 => startRow:1 endRow:10 => num칼럼 값은 아니다.
	//2페이지 => startRow:11 endRow:20
	DailyBoardDao bdao=DailyBoardDao.getInstance();
	int count = bdao.getArticleCount();
	System.out.println("count : "+count);
	ArrayList<DailyBoardBean> lists=null;
	if(count>0){
		lists = bdao.getArticles(startRow,endRow);
	}
	int number=count-(currentPage-1)*pageSize;
	int listcount=0;
%>
	<b>데일리룩 게시판(전체 글 : <%=count %>)</b>

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
	<table border="1" width="700">
		<tr align='center'>
<%
String imgPath=request.getContextPath()+"/shop/images/";
	for(int i=0;i<lists.size();i++){
		DailyBoardBean bb = lists.get(i);
		MemberDao mdao=MemberDao.getInstance();
		MemberBean mb=mdao.getProfileByNick(bb.getWriter());
		listcount++;
		if(listcount%3==1){
			out.print("</tr><tr align='center'>");
		}
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
		
			<td width='33%' height='33%'>
			<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=currentPage%>&nick=<%=bb.getWriter()%>">
			<img src="<%=imgPath+bb.getImage()%>" width='150' height='150'><br>
			<%=bb.getSubject() %></a>
			<%if(bb.getReadcount()>=10){ %>
			<img src="images/hot_icon.gif" height="10" >
			<%} %>
			
			<br><img src="<%=request.getContextPath()%>/images/<%=imtcon %>" height=20 width=20><%=bb.getWriter() %>
			<br><%=sdf.format(bb.getReg_date())%>
			<%=bb.getReadcount() %></td>
		

<%		
	}//for
%>

</tr>		
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
