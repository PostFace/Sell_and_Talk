<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	   //alert(1);
	   
	   var use;
	   var isCheck = false;
	   
	   
	   $('form').find('#id_check').click(function() {
	      //alert(2);
	      isCheck = true;
	      $('input[name="isCheck"]').val(isCheck);
	      
	      if($('input[name="id"]').val().length == 0) {
	         alert("아이디를 입력하세요(중복체크)");
	         $('input[name="id"]').focus();
	         return;
	      }
	      
	      $.ajax({
	            url: "../../id_check_proc.jsp",
	            data :{
	                  userid :  $('input[name="id"]').val()
	            },
	            success : function(data){ 
	               if($.trim(data)=='YES'){
	                  $('#idmessage').html("<font color=blue>사용 가능합니다.</font>");
	                  use = "possible";
	                  $('#idmessage').show(); 
	               }else{
	                  $('#idmessage').html("<font color=red>이미 있는 아이디입니다.</font>");
	                  use = "impossible";
	                  $('#idmessage').show();
	               }
	            }//success
	      }); // ajax
	      
	   }); //id_check click

	   $('#sub').click(function(){
	      
	      if(use =="impossible"){
	         alert("이미 사용중인 아이디입니다.");
	         return false;
	      }
	      else if(isCheck==false){
	         alert("중복체크 먼저 하세요");
	         return false;
	      }
	   
	      else if($('input[name="id"]').val().length == 0) {
	         alert("아이디를 입력하세요(submit)");
	         $('input[name="id"]').focus();
	         return false;
	      }
	      if($('input[name="password"]').val()==""){
				alert('비번 입력하세요.');
				 $('input[name="password"]').focus();
				return false;
			}
			if($('input[name="password"]').val()!=$('input[name="repassword"]').val()){
				alert('비밀번호가 일치하지 않습니다.');
				 $('input[name="repassword"]').focus();
				return false;
			}
			if($('input[name="email"]').val()==""){
				alert('이메일을 입력해주세요.');
				 $('input[name="email"]').focus();
				return false;			
			}
			if($('input[name="name"]').val()==""){
				alert('이름을 입력해주세요.');
				 $('input[name="name"]').focus();
				return false;			
			}
			if($('input[name="rrn1"]').val()==""){
				alert('주민등록번호를 입력해주세요(앞자리).');
				 $('input[name="rrn1"]').focus();
				return false;			
			}
			if($('input[name="rrn2"]').val()==""){
				alert('주민등록번호를 입력해주세요(뒷자리).');
				 $('input[name="rrn2"]').focus();
				return false;			
			}
			if($('input[name="hp2"]').val()==""){
				alert('전화번호를 입력해주세요(앞자리).');
				 $('input[name="hp2"]').focus();
				return false;			
			}
			if($('input[name="hp3"]').val()==""){
				alert('전화번호를 입력해주세요(뒷자리).');
				 $('input[name="hp3"]').focus();
				return false;			
			}
			if($('input[name="joindate"]').val()==""){
				alert('가입일자를 입력해주세요.');
				 $('input[name="joindate"]').focus();
				return false;			
			}
			
	   }); // 가입하기
	   

	}); // ready

	function pwcheck(){
		//alert(1);
		pw=document.forms[0].password.value
		if(pw==""){
			alert('비번 입력하세요.');
			return;
		}
		var chk_num=pw.search(/[0-9]/);
		var chk_eng=pw.search(/[a-z]/);
		//alert(chk_num+","+chk_eng); /* 가장 먼저 앞에 있는 문자의 자릿수,입력을 안하면 -1이 된다. */
		if(chk_num<0||chk_eng<0){
			alert('비번은 숫자와 영문자 조합으로 입력하세요.');
			return;
		}
		var regex =/^[a-z0-9]{3,8}$/;
		
		if(pw.search(regex)==-1){
			alert('3~8자리만 입력 가능합니다.');
			return;
		}		
	}
	function repwcheck(){
		//alert(2);
		if($('input[name=password]').val() != $('input[name=repassword]').val()){
			$('#pwmessage').html("<font color=red>비번 불일치</font>");
			$('#pwmessage').show();
			pwsame="nosame";
		}
		else{ // 값이 같다면
			$('#pwmessage').html("<font color=blue>비번 일치</font>");
			$('#pwmessage').show();
			pwsame="same";
		}
	}	
</script>
<%@ include file="/Main_top2.jsp" %>

<br>
<form action="registerPro.jsp" method="post"
	onsubmit="return writeSave()" name='myform'>

	<table border="1" cellspacing=0 class="table">
		<tr>
			<td colspan="2" align="center"><font size="3"
				color="#5D1900"><b>◈ 기본 정보 ◈</b></font></td>
		</tr>
		<tr>
			<th align="center">* 회원 아이디</th>
			<td class="text-left"><input type="text" name="id">

				<button type="button" id="id_check" name='id_check' class="btn">중복체크</button> <!-- 알아서 하시오 --> <span
				id="idmessage" style="display: none;"></span></td>
		</tr>
		<tr>
			<th align="center">* 비밀 번호</th>
			<td class="text-left"><input type="password" name="password" onblur="pwcheck()">
				영문 소문자/숫자 조합 3~8자</td>
			<!-- focus를 잃었을때 실행할 명령어:onblur="" -->
		</tr>
		<tr>
			<th align="center">* 비밀 번호 확인</th>
			<td class="text-left"><input type="password" name="repassword" id="repassword"
				onkeyup="repwcheck()"> <span id="pwmessage"
				style="display: none;"></span></td>
		</tr>
		<tr>
			<th align="center">* 회원 닉네임</th>
			<td class="text-left"><input type="text" name="nickname" placeholder="nickname">
		</td>
		<tr>
			<th align="center">E-Mail</th>
			<td class="text-left"><input type="text" name="email" placeholder="gildong@naver.com">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><font size="3"
				color="#5D1900"><b>◈ 개인 신상 정보 ◈</b></font></td>
		</tr>
		<tr>
			<th align="center">한글 이름</th>
			<td class="text-left"><input type="text" name="name" placeholder="홍길동"></td>
		</tr>
		<tr>
			<th align="center">주민 등록 번호</th>
			<td class="text-left"><input type="text" name="rrn1" maxlength="6" size="6"
				 placeholder="123456"> - <input type="text" name="rrn2"
				maxlength="7" size="7"  placeholder="1234567"></td>
		</tr>
		<tr>
			<th align="center">휴대 전화 번호</th>
			<td class="text-left"><select name="hp1">
					<option value="010">010</option>
					<option value="011">011</option>
			</select> - <input type="text" name="hp2" size="4" maxlength="4" placeholder="1234">
				- <input type="text" name="hp3" size="4" maxlength="4" placeholder="5678">
				</td>
		</tr>
		<tr>
			<td colspan="2" align="center"><input
				type="submit" value="가입 하기" id="sub" onclick="return writeSave()" class="btn">&nbsp;&nbsp; <input
				type="reset" value="취소" class="btn"></td>
		</tr>
	</table>
</form>
<%@ include file="/Main_bottom.jsp" %>