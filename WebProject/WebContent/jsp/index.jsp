<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Index</title>
<style type="text/css">
.glow{
					text-shadow: #ffffc8 0px 0px 3px;
					text-shadow: white 0px 0px 5px 5px;
}
</style>
</head>
<% 
final int sn=3;
final String[] text={"C++ 개발자","Piano 연주","Game 플레이"};
final String[] pText={"OpenGL, Cocos2d, WinAPI"
		,"Tales Weaver, Fairy Tail, Under Tale",
		"Girls Frontline, StarCraft, Witch Spring, League Of Legends"};
%>
<body onselectstart="return false" style="background-color:rgba(0,0,0,0.7);">
	<%@ include file="menu.jsp" %>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel" style="max-width:1000px;margin-left:auto;margin-right:auto;">
		<ol class="carousel-indicators">
			<% for(int i=0;i<sn;i++){%>
			<li data-target="#carouselExampleIndicators" data-slide-to="<%=i%>"
			<%=i==0 ? "class='active'" : "" %>></li>
			<% } %>
		</ol>
		<div class="carousel-inner"
			style="width:100%; height:auto;">
			<% for(int i=0;i<sn;i++){%>
			<div class="carousel-item <%=i==0 ? "active" : "" %>">
				<img class="d-block w-100" src="${contextPath}/img/background<%=i %>.jpg"
					alt="First slide">
				<div class="carousel-caption d-none d-md-block">
					<h3 class="text-dark glow"><%=text[i] %></h3>
					<p class="text-dark glow"><%=pText[i] %></p>
				</div>
				<div style="position:absolute;top:0;left:0;width:100%;height:100%;
				background-color:rgba(255,255,255,0.3);">
				</div>
			</div>
			<%} %>
		</div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<%@ include file="modal.jsp" %>
<script type="text/javascript">
$('.carousel').carousel({
	  interval: 2000
})
<% if(request.getAttribute("error")!=null){ %>
	var myModal=$('#myModal');
	myModal.find('.modal-title').text('Nickname Update Error');
	myModal.find('.modal-body').text('<%=request.getAttribute("error")%>');
	myModal.modal('show');
<%}%>
</script>
</body>
</html>