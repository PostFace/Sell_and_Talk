<%@page import="shop.member.MemberBean"%>
<%@page import="shop.member.MemberDao"%>
<%@page import="shop.board.DailyBoardBean"%>
<%@page import="shop.board.DailyBoardDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="shop.sell.ProductBean"%>
<%@page import="shop.sell.ProductDao"%>
<%@page import="shop.board.BoardBean"%>
<%@page import="shop.board.BoardDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="Main_top.jsp" %>
<style type="text/css">
 .container{
	width: 1080px;
}
</style>
<br>
<head> 
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>세상의 모든 신발 Sell and Talk!</title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/kfonts2.css" rel="stylesheet">
    
  </head>
<body>
 <div class="container">   
        <div id="carousel-example-generic" class="carousel slide">
        
            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
            <ol class="carousel-indicators">
             <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
              <li data-target="#carousel-example-generic" data-slide-to="3"></li>
              <li data-target="#carousel-example-generic" data-slide-to="4"></li>
              <li data-target="#carousel-example-generic" data-slide-to="5"></li>
            </ol>
             <!-- Carousel items -->
             <div class="carousel-inner"> 
                <div class="item active">
                   <img src="./images/banner7.jpg" alt="First slide" width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">
                </div>
                <div class="item">
                   <img src="./images/banner8.jpg" alt="Second slide" width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">               
                </div>
                <div class="item">
                   <img src="./images/banner9.jpg" alt="Third slide"  width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">                 
                </div>
                <div class="item">
                   <img src="./images/banner13.jpg" alt="Fourth slide"  width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">                 
                </div>
                <div class="item">
                   <img src="./images/banner11.jpg" alt="Fifth slide"  width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">                 
                </div>
                <div class="item">
                   <img src="./images/banner12.jpg" alt="Sixth slide"  width=1200 height=800 onclick="location.href='<%=request.getContextPath()%>/shop/display/mall.jsp'">                 
                </div>
             </div>
            <!-- Controls -->
              <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                <span class="icon-prev"></span>
              </a>
              <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                <span class="icon-next"></span>
              </a>
          </div>
  </div>
  
  <table>
  	<tr>
  		
  	
  		<td><%
request.setCharacterEncoding("UTF-8");
ProductDao pdao= ProductDao.getInstance();
String imgPath=request.getContextPath()+"/shop/images/";
String[] spec={"HIT","NEW","BEST","NORMAL"};
int count=0;
DecimalFormat df=new DecimalFormat("###,###");
%>


<b></b>
<%for(int i=0;i<spec.length;i++){ 
			ArrayList<ProductBean> prodList=pdao.getProductBySpec(spec[i],"new"); %> 
<hr  width="80%">
<font color='red'><strong><%=spec[i] %></strong></font>
<hr  width="80%">
<%if(prodList.size()==0){%>
	<%=spec[i] %>상품이 없습니다.
	<% }else{	count=0;%>
<table width='600' align='center'>
	<tr align='center'>
		<% for(ProductBean pb :prodList){ 
			String[] images= new String[4];
			if(pb.getPimage().contains("/")){
				images=pb.getPimage().split("/");
			}else{
				images[0]=pb.getPimage();
			}
					count++;
					if(count%3==1){
						out.print("</tr><tr align='center'>");
					}
					%>
		<td><a href="<%=request.getContextPath()%>/shop/display/mall_prodView.jsp?pnum=<%=pb.getPnum()%>"><img src="<%=imgPath+images[0]%>" width='80' height='80'><br>
			<%=pb.getPname() %><br> <font color='red'><%=df.format(pb.getPrice()) %></font>원<br>
			<font color='blue'>[<%=df.format(pb.getPoint()) %>]
		</font>포인트<br></a>
		<br></td>
		<%} %>
	</tr>
</table>
<% }
				} %></td>
				<td valign="top"><% 
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
	count = bdao.getArticleCount();
	System.out.println("count : "+count);
	ArrayList<BoardBean> lists=null;
	if(count>0){
		lists = bdao.getArticles(startRow,endRow);
	}
	int number=count-(currentPage-1)*pageSize;
%>
	<br><br><a href="<%=cPath%>/shop/board/list.jsp"
							style="color: #121517"><b>잡담게시판</b></a><br><br>

<%
	if(count == 0){
%>
	<table border="1" width="150" height="150">
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
	<table border="1"  width="150" height="150" class="table table-striped">
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
		
%>
		<tr>
			<td align="right"><%=number-- %></td>
			<td align="left">
				<%
				if(bb.getRe_level()>0){
				%>
				
				<img src="shop/board/images/level.gif" width="<%=bb.getRe_level()*20 %>" height="15">
				↳
				<% }
					%>
			<a href="<%=cPath%>/shop/board/content.jsp?num=<%=bb.getNum()%>&pageNum=<%=currentPage%>"><%=bb.getSubject() %></a>
			<%if(bb.getReadcount()>=10){ %>
			<img src="shop/board/images/hot_icon.gif" height="15" >
			<%} %>
			</td>
			<td align="center"><%=bb.getWriter() %></td>
			<td align="center"><%=sdf.format(bb.getReg_date())%></td>
			<td align="right"><%=bb.getReadcount() %></td>
		</tr>

<%		
	}//for
%>

		



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
			<a href="<%=cPath%>/shop/board/list.jsp?pageNum=<%=startPage-10%>">[이전]</a>		
	<% 
		}//if
		for(int i=startPage;i<=endPage;i++){
	%>
			<a href="<%=cPath%>/shop/board/list.jsp?pageNum=<%=i%>">[<%=i %>]</a>		
	<%			
		}
		if(endPage<pageCount){
	%>
			<a href="<%=cPath%>/shop/board/list.jsp?pageNum=<%=startPage+10%>">[다음]</a>		
	<%
		}//if
	}//if(count>0)
%>
  	
  </table>
</td>
</tr></table>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="./js/bootstrap.min.js"></script>
    <script>
      $('.carousel').carousel()  /* 1 */
      
    </script>
</body>
<%@ include file="Main_bottom.jsp" %>