<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Sign Up</title>
<link rel="stylesheet" href="${contextPath}/css/card.css" />
<link rel="stylesheet" href="${contextPath}/css/signup.css" />
<script type="text/javascript">
	function checkPwd(){
		var pwdCheck=document.getElementById("pwdCheckHelp");
		if(document.getElementById("pwd").value==document.getElementById("prd").value){
			pwdCheck.setAttribute('class',"form-text accept");
			pwdCheck.innerHTML='Password is checked';
		}else{
			pwdCheck.setAttribute('class',"form-text error");
			pwdCheck.innerHTML='Password is not checked';
		}
	}
</script>
</head>
<body onselectstart="return false">
	<%@ include file="menu.jsp"%>
	<div class='cardout'>
		<div class='cardwrap'>
			<div class='cardin card' style="display: inline-block;">
				<form id="signupForm" style="margin: 5%;">
					<h1>Sign Up</h1>
					<div class="form-group" style="text-align: left; margin-bottom: 0;">
						<label for="id">Email address</label> <input type="email"
							class="form-control" id="id" name='id' maxlength=25
							aria-describedby="emailHelp" placeholder="abc@abc.com" required>
					</div>
					<div class="form-group" style="text-align: left; margin-top: 0;margin-bottom:0;">
						<label for="pwd">Password</label> 
						<input type="password"
							class="form-control" id="pwd" name='pwd' onkeyup="checkPwd()" onchange="checkPwd()"
							aria-describedby="passwordHelp" placeholder="Password" maxlength=25
							style="border-bottom:0;border-radius: 0.25em 0.25em 0 0 ;" required>
							<input type="password"
							class="form-control" id="prd" name='prd' onkeyup="checkPwd()" onchange="checkPwd()"
							aria-describedby="pwdCheckHelp" placeholder="Password Check" maxlength=25
							style="border-radius: 0 0 0.25em 0.25em;" required> <small
							id="pwdCheckHelp" class="form-text basic">Enter
							Password Again</small>
					</div>
					<div class="form-group" style="text-align: left; margin-top: 0;">
					<label for="name">Name</label> 
						 <input type="text"
							class="form-control" id="name" name='name'
							aria-describedby="nameHelp" placeholder="Name"
							style="border-bottom:0;border-radius: 0.25em 0.25em 0 0 ;" required
							maxlength=30>
						<input type="text"
							class="form-control" id="nickname" name='nickname'
							aria-describedby="nicknameHelp" placeholder="Nickname"
							style="border-radius: 0 0 0.25em 0.25em;" maxlength=10>
					</div>
					<button type="submit" class="btn btn-success btn-lg btn-block">Sign
						Up</button>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="modal.jsp" %>
<script>
$(document).ready(function (){
	$('#signupForm').submit(function(event){
		event.preventDefault();
		var id=$('#id').val();
		var pwd=$('#pwd').val();
		var prd=$('#prd').val();
		var name=$('#name').val();
		var nickName=$('#nickname').val();
		if(pwd!=prd){
			var myModal = $('#myModal');
			myModal.find('.modal-title').text('Sign Up Error');
			myModal.find('.modal-body').text('비밀번호가 확인되지 않습니다.');
			myModal.modal();
			return;
		}
		$.post("${contextPath}/signup.do",
			{id: id, pwd : pwd, name : name , nickname : nickName},
			function(data){
				if(data.suc){
					location.href="${contextPath}/jsp/login.jsp";
				}
				else{
					var myModal = $('#myModal');
					myModal.find('.modal-title').text('Sign Up Error');
					myModal.find('.modal-body').text('E-mail이 이미 존재합니다.');
					myModal.modal();
				}
			}
		);
	})
})
</script>
</body>
</html>