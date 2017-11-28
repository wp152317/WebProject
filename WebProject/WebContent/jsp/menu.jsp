<%@page import="org.stoad.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/css/button.css">
<nav class="navbar sticky-top navbar-expand-xl navbar-dark bg-dark">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarTogglerDemo01"
			aria-controls="navbarTogglerDemo01" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarTogglerDemo01">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-item active"><a class="nav-link" 
				href="${contextPath}/">Home</a></li>
				<li class="nav-item"><a class="nav-link" 
				href="${contextPath}/base.do">야구게임</a></li>
				<li class="nav-item"><a class="nav-link" 
				href="${contextPath}/mine.do">지뢰찾기</a></li>
				<li class="nav-item"><a class="nav-link" 
				href="${contextPath}/rank.do">게임랭킹</a></li>
			</ul>
			<%
			UserVo uv=(UserVo)session.getAttribute("user");
			if(uv==null){ %>
			<button class="btn btn-outline-success"
				onclick="location.href='${contextPath}/jsp/login.jsp'">Sign In</button>
			<button class="btn btn-outline-success"
				onclick="location.href='${contextPath}/jsp/signup.jsp'"
				style="margin-left:5px;">Sign Up</button>
			<%}else{ %>
			<div class="btn-group" style="width:170px;">
				<button type="button" class="btn btn-outline-light dropdown-toggle"
				 data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
				 style="width:200px;text-align:right;display:table-cell;">
				   <div style="float:left;text-align:left;"><%= uv.getNickname() %> 님
				  </div>
				    &nbsp;
				</button>
				<div class="dropdown-menu" style="max-width:170px;width:170px;text-align:center;">
					<a class="dropdown-item" href="${contextPath}/jsp/updatenick.jsp" 
					style="padding-top:5px;padding-botton:5px;">Update Nickname</a>
					
					<a class="dropdown-item" href="${contextPath}/logout.do"
					style="padding-top:5px;padding-botton:5px;">Sign out</a>
				</div>
			</div>
			<%} %>
		</div>
	</nav>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	