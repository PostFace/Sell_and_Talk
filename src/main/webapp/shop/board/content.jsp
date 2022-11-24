<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDao"%>
<%@page import="shop.board.ReBoardBean"%>
<%@page import="shop.board.ReBoardDao"%>
<%@page import="shop.board.BoardBean"%>
<%@page import="shop.board.BoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/Main_top.jsp" %>    

<%

	request.setCharacterEncoding("UTF-8");
	String num=request.getParameter("num"); //부모번호(선택한 글)
	String pageNum=request.getParameter("pageNum");
	String nick=request.getParameter("nick");
	BoardDao bdao=BoardDao.getInstance();
	BoardBean article= bdao.getArticle(num);
	System.out.println("num:"+article.getNum());
	System.out.println("Ref:"+article.getRef()); //부모정보
	System.out.println("Re_step:"+article.getRe_step()); //부모정보
	System.out.println("Re_level:"+article.getRe_level()); //부모정보
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	MemberDao mdao=MemberDao.getInstance();
	MemberBean mb=mdao.getProfileByNick(nick);		
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
%>
<form name="myform">
	<table width="500" border="1" cellspacing="0" cellpadding="0"  
      align="center">  
  <tr height="30">
    <td align="center" width="125">글번호</td>
    <td align="center" width="125"> <%=article.getNum()%></td>
    <td align="center" width="125">조회수</td>
    <td align="center" width="125"> <%=article.getReadcount()%></td>
  </tr>
  <tr height="40">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125"> <img src="<%=request.getContextPath()%>/images/<%=imtcon %>" height=20 width=20>
    <%=article.getWriter()%></td>
    <td align="center" width="125" >작성일</td>
    <td align="center" width="125"> <%= sdf.format(article.getReg_date()) %></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="375" colspan="3"> <%=article.getSubject()%></td>
  </tr>
  <tr height="160">
    <td align="center" width="125">글내용</td>
    <td align="left" height="160" colspan="3"><pre ><%=article.getContent()%></pre></td>
  </tr> 
  <tr>
  	<td colspan="4" align="center" height="30">
  		<input type="button" value="글수정"class="btn btn-info" onclick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">  
  		<input type="button" value="글삭제"class="btn btn-info" onclick="location.href='deletePro.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">  
  		<input type="button" value="답글쓰기" class="btn btn-info"
  		onclick="location.href='replyForm.jsp?ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>&pageNum=<%=pageNum%>'">  
  		<input type="button" value="글목록"class="btn btn-info" onclick="location.href='list.jsp?pageNum=<%=pageNum%>'">  
  </tr>
</table>  
</form>

<form action="replePro.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>">
	<table>
		<tr>
			<td colspan="4">
				<textarea rows="4" cols="40" name="content" placeholder="댓글 작성하기"></textarea>
				<input type="hidden" name="renum" value="<%=article.getNum() %>">
				<input type="hidden" name="num" value="<%=num %>">
				<input type="hidden" name="pageNum" value="<%=pageNum %>">
			</td>
			<td colspan="2">
				<input type="submit" value="댓글 달기" class="btn btn-info">
			</td>
		</tr>
	</table>
	</form>
	<table >	
		<%
		ReBoardDao rd= ReBoardDao.getInstance();
		ArrayList<ReBoardBean> lists=rd.getRepleByRenum(article.getNum());
		if(lists.size()==0){
			%>
		<tr>
			<th colspan="6">아직 댓글이 없습니다. 첫번째 댓글을 작성해보세요!</th>
		</tr>
		
			
		<%
		} else{
			for(ReBoardBean rb : lists){
				mb=mdao.getProfileByNick(rb.getWriter());
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
				%>
		<tr>
			<th width="20%" align="left"><img src="<%=request.getContextPath()%>/images/<%=imtcon %>" height=20 width=20>
			<%=rb.getWriter()%><hr color="black"></th>
			<td width="60%" align="left"><%=rb.getContent()%><hr color="black"></td>
			<td width="20%" align="left">
				<input type="button" value="삭제" onclick="">
				<input type="button" value="수정" onclick="">	<hr color="black">		
			</td>
		</tr>
		<%	}		
		}
		%>
	</table>
	
<%@include file="/Main_bottom.jsp" %>  