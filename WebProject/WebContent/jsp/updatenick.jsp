<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Nickname Update</title>
<link rel="stylesheet" href="${contextPath}/css/card.css" />
<link rel="stylesheet" href="${contextPath}/css/signup.css" />
<script type="text/javascript">
<%UserVo uvo=((UserVo)session.getAttribute("user"));%>
	function checkPwd(){
		var pwdCheck=document.getElementById("pwdCheckHelp");
		var k=document.getElementById("pwd").value;
		if(k==document.getElementById("prd").value&&k=='<%=uvo.getPwd()%>'){
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
				<form id="updateForm" style="margin: 5%;" method=post
				action="${contextPath}/upnick.do">
					<h1>Update Nick</h1>
					<div class="form-group" style="text-align: left; margin-bottom: 0;">
						<label for="nickname">Nickname</label> <input type="text"
							class="form-control" id="nickname" name='nickname' maxlength=10
							aria-describedby="nicknameHelp" placeholder="NickName" required><small
							id="nicknameHelp" class="form-text basic">Nickname that change</small>
					</div>
					<div class="form-group" style="text-align: left; margin-top: 0;margin-bottom:0;">
						<label for="pwd">Password Check</label> 
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
					<button type="submit" class="btn btn-success btn-lg btn-block">Complete</button>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="modal.jsp" %>
<script>
$(document).ready(function (){
	$('#updateForm').submit(function(event){
		event.preventDefault();
		var pwd=$('#pwd').val();
		var prd=$('#prd').val();
		var nickName=$('#nickname').val();
		if(pwd!=prd&&pwd!='<%=uvo.getPwd()%>'){
			var myModal = $('#myModal');
			myModal.find('.modal-title').text('Sign Up Error');
			myModal.find('.modal-body').text('비밀번호가 확인되지 않습니다.');
			myModal.modal();
			return;
		}
		document.getElementById('updateForm').submit();
	})
})
</script>
</body>
</html>