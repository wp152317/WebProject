<%@page import="org.stoad.vo.RecordVo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Game Ranking</title>
</head>
<link rel="stylesheet" href="${contextPath}/css/position.css">
<link rel="stylesheet" href="${contextPath}/css/ranking.css">
<script type="text/javascript">
var ranks=new Array();
var recds=new Array();
var rank;
var ntype='base';
<%
ArrayList<ArrayList<ArrayList<RecordVo>>> list=
(ArrayList<ArrayList<ArrayList<RecordVo>>>)request.getAttribute("rank");
for(int i=0;i<2;i++){%>
	ranks[<%=i%>]=new Array();
	<%for(int j=0;j<3;j++){%>
		ranks[<%=i%>][<%=j%>]=new Array();
		<%for(int k=0;k<5;k++){%>
			ranks[<%=i%>][<%=j%>][<%=k%>]=new Array();
			ranks[<%=i%>][<%=j%>][<%=k%>][0]
			='<%=list.get(i).get(j).get(k).getId()%>';
			ranks[<%=i%>][<%=j%>][<%=k%>][1]
			='<%=list.get(i).get(j).get(k).getNickname()%>';
			ranks[<%=i%>][<%=j%>][<%=k%>][2]
			=<%=list.get(i).get(j).get(k).getScore()%>;
			console.log(ranks[<%=i%>][<%=j%>][<%=k%>]);
		<%}%>
	<%}%>
<%}
list=
(ArrayList<ArrayList<ArrayList<RecordVo>>>)request.getAttribute("recd");
for(int i=0;i<2;i++){%>
	recds[<%=i%>]=new Array();
	<%for(int j=0;j<3;j++){%>
		recds[<%=i%>][<%=j%>]=new Array();
		<%for(int k=0;k<5;k++){%>
			recds[<%=i%>][<%=j%>][<%=k%>]=new Array();
			recds[<%=i%>][<%=j%>][<%=k%>][0]
			='<%=list.get(i).get(j).get(k).getId()%>';
			recds[<%=i%>][<%=j%>][<%=k%>][1]
			='<%=list.get(i).get(j).get(k).getNickname()%>';
			recds[<%=i%>][<%=j%>][<%=k%>][2]
			=<%=list.get(i).get(j).get(k).getScore()%>;
			console.log(recds[<%=i%>][<%=j%>][<%=k%>]);
		<%}%>
	<%}%>
<%}%>
function change(idx){
	for(var i=0;i<3;i++){
		for(var j=0;j<5;j++){
			var rankerId=document.getElementById("id"+i+"_"+j);
			var rankerNick=document.getElementById("nick"+i+"_"+j);
			var rankerRecord=document.getElementById("rcd"+i+"_"+j);
			var check1=rank[idx][i][j][0].substring(0,2);
			var check2=rank[idx][i][j][0].substring(2,3);
			if(rank[idx][i][j][0].length==3&&check1=='NO'&&(0<=check2*1&&check2*1<=4)){
				rankerId.innerHTML="No Record";
				rankerNick.innerHTML="-";
				rankerRecord.innerHTML="-";
			}
			else{
				rankerId.innerHTML=rank[idx][i][j][0];
				rankerNick.innerHTML=rank[idx][i][j][1];
				rankerRecord.innerHTML=rank[idx][i][j][2];
				if(idx==1){
					var k=1*rankerRecord.innerHTML;
					var min=parseInt(k/60);
					var sec=k%60;
					rankerRecord.innerHTML=(min<10 ? '0'+min : min)+':'
					+(sec<10 ? '0'+sec : sec);
				}
			}
		}
	}
}
function showBase(){
	ntype='base';
	console.log("base");
	for(var i=0;i<3;i++){
		var title=document.getElementById("title"+i);
		title.innerHTML="<b>야구게임 - "+(i+3)+ "숫자</b>";
	}
	change(0);
}
function showMine(){
	ntype='mine';
	console.log("mine");
	var str=["초급","중급","고급"];
	for(var i=0;i<3;i++){
		var title=document.getElementById("title"+i);
		title.innerHTML="<b>지뢰찾기 - "+str[i]+"</b>";
	}
	change(1);
}
function show(){
	if(ntype=='base')
		showBase();
	else
		showMine();
}
function setAll(){
	var k=document.getElementById("title");
	k.innerHTML="<b>전체 랭킹</b>";
	console.log("all");
	rank=ranks;
	show();
}
function setOnly(){
	var k=document.getElementById("title");
	k.innerHTML="<b>개인 랭킹</b>";
	console.log("only");
	rank=recds;
	show();
}
window.onload=function(){
	var k=document.getElementById("base");
	k.setAttribute('class','btn btn-secondary active');
	k=document.getElementById("all");
	k.setAttribute('class','btn btn-secondary active');
	setAll();
}

</script>
<body onselectstart="return false">
<%@include file="menu.jsp" %>
<div class="poscenter" style="position:absolute;top:0;left:0;width:100%;height:100%;display:table;">
	<div style="text-align:center;display:table-cell;vertical-align:middle;">
		<div class="btn-group poscenter" data-toggle="buttons" style="display:table;">
			<label class="btn btn-secondary" onclick="showBase()" id="base"> <input type="radio"
				name="options" id="option1" autocomplete="off" checked> 야구게임
			</label> <label class="btn btn-secondary " onclick="showMine()" id="mine"> <input type="radio"
				name="options" id="option2" autocomplete="off" > 지뢰찾기
			</label>
		</div>
		<div class="btn-group poscenter" data-toggle="buttons" style="display:table;margin-bottom:100px;">
			<label class="btn btn-secondary" onclick="setAll()" id="all"> <input type="radio"
				name="options" id="option1" autocomplete="off" checked> 전체랭킹
			</label> <label class="btn btn-secondary " onclick="setOnly()" id="only"> <input type="radio"
				name="options" id="option2" autocomplete="off" > 개인랭킹
			</label>
		</div>
		<div class="boardElement" id=title><b>TITLE</b></div>
		<div class="out poscenter" style="width:100%;margin-bottom:180px;">
			<div class="wrap rankGap"></div>
			<%for(int i=0;i<3;i++){ %>
				<div class="wrap poscenter rankBoard">
					<div class="boardElement" id=title<%=i %>><b>BOARD</b></div>
					<div class="line"></div>
					<div class="boardTitle out">
						<div class="wrap boardNum"><b>#</b></div>
						<div class="wrap boardId"><b>ID</b></div>
						<div class="wrap boardNick"><b>Nick</b></div>
						<div class="wrap boardRecord"><b>P</b></div>
					</div>
					<div class="line"></div>
					<%for(int j=0;j<5;j++){ %>
					<div class="boardElement out">
						<div class="wrap boardNum"><b><%=j+1%></b></div>
						<div class="wrap boardId" id="id<%=i%>_<%=j%>">Test</div>
						<div class="wrap boardNick" id="nick<%=i%>_<%=j%>">Test</div>
						<div class="wrap boardRecord" id="rcd<%=i%>_<%=j%>">Test</div>
					</div>
					<div class="line"></div>
					<%} %>
				</div>
				<div class="wrap rankGap"></div>
			<%} %>
		</div>
	</div>
</div>
</body>
</html>