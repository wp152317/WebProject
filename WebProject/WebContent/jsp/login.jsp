<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Sign in</title>
<link rel="stylesheet" href="${contextPath}/css/card.css" />
</head>
<body onselectstart="return false">
	<%@ include file="menu.jsp"%>
 
	<div class='cardout'>
		<div class='cardwrap'>
			<div class='cardin card' style="display:inline-block;">
				<form style="margin: 5%;" method=post
					action="${contextPath}/login.do">
					<h1>Sign In</h1>
					<div class="form-group" style="text-align: left;margin-bottom:0;">
						<label for="id">Email address</label> <input type="email"
							class="form-control" id="id" name='id'
							aria-describedby="emailHelp" placeholder="abc@abc.com"
							value="<%=(request.getParameter("id")==null ? "" : request.getParameter("id"))%>"> <small
							id="emailHelp" class="form-text text-muted">Enter Email </small>
					</div>
					<div class="form-group" style="text-align: left;margin-top:0;">
						<label for="pwd">Password</label> <input type="password"
							class="form-control" id="pwd" name='pwd'
							aria-describedby="passwordHelp" placeholder="Password"> <small
							id="passwordHelp" class="form-text text-muted">Enter
							Password </small>
					</div>
					<button type="submit" class="btn btn-success btn-lg btn-block">Sign
						In</button>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="modal.jsp" %>
<%

	if(request.getAttribute("error")!=null){%>
	<script>
	var myModal = $('#myModal');
	myModal.find('.modal-title').text('Login Error');
	myModal.find('.modal-body').text('<%=request.getAttribute("error")%>');
	myModal.modal('show');
	</script>
	<%}
%>
</body>
</html>