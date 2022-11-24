<%@page import="shop.sell.ProductDao"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
prod_delete.jsp<br>
<% 
	request.setCharacterEncoding("UTF-8");
	String pnum=request.getParameter("pnum");
	String pimage=request.getParameter("pimage");
	String[] pimages=pimage.split("/");
	String delPath= config.getServletContext().getRealPath("/shop/images");
	for(int i=0;i<pimages.length;i++){
		File delFile=new File(delPath,pimages[i]);//1. 폴더 위치의 2. 파일로 객체생성
		if(delFile.exists()){ //존재하면 true
			if(delFile.delete()){
%>
<script type="text/javascript">
	alert("<%=i+1%>번 이미지 삭제 완료");
</script>
<% 			}
		}
	}
	ProductDao pdao=ProductDao.getInstance();
	int result=pdao.deleteProduct(pnum);
	String msg;
	if(result>0){
		msg="삭제 성공";
	} else {
		msg="삭제 실패";
	}
%>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="prod_list.jsp";
</script>