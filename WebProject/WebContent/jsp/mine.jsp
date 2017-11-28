<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<% 
String difficult=request.getParameter("difficult");
int dfct=difficult==null ? 1 : Integer.parseInt(difficult);
if(dfct<1||dfct>3)dfct=1;
int x=10,y=10,mines=10;
switch(dfct){
case 2:x=16;y=16;mines=40;break;
case 3:x=30;y=16;mines=99;break;}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Mine Sweeper</title>
<link rel="stylesheet" href="${contextPath}/css/position.css">
<link rel="stylesheet" href="${contextPath}/css/minesweeper.css">
<script type="text/javascript" src="${contextPath}/js/queue.js">
</script>
<script type="text/javascript">
var flag=false;
var time=0;
var tId;
var plate;
var gone;
var flags;
var goneCnt;
var x;
var y;
var mines;
var win;
var Color=['#ffffff','blue','green','red','black','brown','skyblue','purple','gray'];
	function replay(){
		x=<%=x%>;y=<%=y%>;mines=<%=mines%>;
		win=0;
		goneCnt=0;
		document.getElementById("nom").innerHTML=mines;
		flag=false;
		plate=new Array();
		gone=new Array();
		flags=new Array();
		time=0;
		document.getElementById("clock").innerHTML='00 : 00';
		for(var i=0;i<y;i++){
			plate[i]=new Array();
			gone[i]=new Array();
			flags[i]=new Array();
			for(var j=0;j<x;j++){
				plate[i][j]=0;
				gone[i][j]=0;
				flags[i][j]=0;
				var thisbtn=document.getElementById("btn"+i+"_"+j);
				thisbtn.disabled=false;
				thisbtn.innerHTML='<b></b>';
				thisbtn.setAttribute('class',"poscenter closebutton wrap");
			}
			console.log(plate[i]);
		}
	}
	window.onload=function(){
		console.log(replay);
		replay();
	};
	function re(i){
		var url='${contextPath}'+"/jsp/mine.jsp";
		location.replace(url+"?difficult="+i);
	};
	function timeCheck(){
		if(flag)return;
		flag=true;
		tId=setInterval("changeTime()",1000);
		setInterval("checkClear()",10);
	}
	function checkClear(){
		if(!flag){
			clearInterval(tId);
			time=0;
		}
	}
	function changeTime(){
		if(flag){
			var clk=document.getElementById("clock");
			if(time<3599)
				time++;
			var second=time%60;
			var min=parseInt(time/60);
			clk.innerHTML=(min%10==min ? "0" : "")+min+" : "
			+(second%10==second ? "0" : "") + second;
		}
		else{
			clearInterval(tId);
			time=0;
		}
	}
	function spreadMine(r,c){
		for(var k=0;k<mines;k++){
			var i=Math.floor(Math.random()*y);
			var j=Math.floor(Math.random()*x);
			if(plate[i][j]<0){
				k--;
				continue;
			}
			if(i==r&&j==c){
				k--;
				continue;
			}
			plate[i][j]=-1;
		}
		for(var i=0;i<y;i++){
			for(var j=0;j<x;j++){
				if(plate[i][j]<0)
					continue;
				if(i-1>=0&&j-1>=0&&plate[i-1][j-1]<0)
					plate[i][j]++;
				if(i-1>=0&&plate[i-1][j]<0)
					plate[i][j]++;
				if(i-1>=0&&j+1<x&&plate[i-1][j+1]<0)
					plate[i][j]++;
				
				if(j-1>=0&&plate[i][j-1]<0)
					plate[i][j]++;
				if(j+1<x&&plate[i][j+1]<0)
					plate[i][j]++;

				if(i+1<y&&j-1>=0&&plate[i+1][j-1]<0)
					plate[i][j]++;
				if(i+1<y&&plate[i+1][j]<0)
					plate[i][j]++;
				if(i+1<y&&j+1<x&&plate[i+1][j+1]<0)
					plate[i][j]++;
			}
		}
		for(var i=0;i<y;i++)
			console.log(plate[i]);
	}
	function gameover(r,c){
		for(var i=0;i<y;i++){
			for(var j=0;j<x;j++){
				var thisbutton=document.getElementById("btn"+i+"_"+j);
				if(plate[i][j]<0&&flags[i][j]==0){					
					thisbutton.setAttribute('class',"poscenter openbutton wrap");
					thisbutton.innerHTML='<img src="${contextPath}/img/mine.png" alt="mine">';
				}
				if(flags[i][j]==1&&plate[i][j]>=0){
					thisbutton.setAttribute('class',"poscenter overclick wrap");
					thisbutton.innerHTML='<img src="${contextPath}/img/mine_.png" alt="mine_">';
				}
				thisbutton.disabled=true;
			}
		}
		var thisbtn=document.getElementById("btn"+r+"_"+c);
		console.log(thisbtn);
		thisbtn.setAttribute('class',"poscenter overclick wrap");
		flag=false;
	}
	function bfs(r,c){
		if(flags[r][c]==1)return;
		if(gone[r][c]==1)return;
		var q=new Queue();
		q.push([r,c]);
		gone[r][c]=1;
		var i,j;
		while(!q.empty()){
			var n=q.front();i=n[0];j=n[1];
			q.pop();
			goneCnt++;
			console.log(i+" "+j + "-"+goneCnt);
			var thisbutton=document.getElementById("btn"+i+"_"+j);
			thisbutton.setAttribute('class',"poscenter openbutton wrap");
			if(plate[i][j]==0){
				thisbutton.innerHTML='';
				if(flags[i][j]==1){
					gameover(r,c);
					console.log("GameOver");
				}
				for(var it=-1;it<=1;it++){
					for(var jt=-1;jt<=1;jt++){
						if(i+it>=0&&i+it<y&&j+jt>=0&&j+jt<x
								&&gone[i+it][j+jt]==0){
							q.push([i+it,j+jt]);
							gone[i+it][j+jt]=1;
						}
					}
				}
			}
			else if(plate[i][j]>0)
				thisbutton.innerHTML='<b style="color:'+Color[plate[i][j]]+'">'+plate[i][j]+'</b>'
		}
		if(goneCnt==x*y-mines){
			
			event.preventDefault();
			var id='<%=((UserVo)session.getAttribute("user")).getId()%>';
			var game="mine";
			var type=<%=dfct%>;
			var record=time;
			console.log(id,game,type,record);
			$.post("${contextPath}/change.do",
				{id: id, game : game, type : type, record : record},
				function(data){
					var myModal = $('#myModal');
					if(data.suc){
						myModal.find('.modal-title').text('Record - (d/t) - (difficult/time)');
						myModal.find('.modal-body').text((x==10 ? '초급' : x==16 ? '중급' : '고급')+' '+record + '로 기록을 세웠습니다.');
						myModal.modal('show');
					}else{
						myModal.find('.modal-title').text('Recording Error');
						myModal.find('.modal-body').text('기록갱신에 실패했습니다.');
						myModal.modal('show');
					}
				}
			);
			flag=false;
		}
	}
	function autoOpen(r,c){
		var mineCnt=0;
		for(var it=-1;it<=1;it++){
			for(var jt=-1;jt<=1;jt++){
				if(it+r>=0&&it+r<y&&jt+c>=0&&jt+c<x
						&&flags[it+r][jt+c]==1){
					if(plate[it+r][jt+c]>=0){
						gameover(it+r,jt+c);
					}
					mineCnt++;
				}
			}
		}
		if(plate[r][c]==mineCnt){
			for(var it=-1;it<=1;it++){
				for(var jt=-1;jt<=1;jt++){
					if(it+r>=0&&it+r<y&&jt+c>=0&&jt+c<x){
						bfs(it+r,jt+c);
					} 
				}
			}
		}
	}
	function check(r,c){
		if(document.getElementById('btn'+r+'_'+c).disabled)return;
		if(!flag){
			timeCheck();
			spreadMine(r,c);
		}
		if(event.button==0){
			if(flags[r][c]==1)return;
			if(gone[r][c]==1){
				if(plate[r][c]==0)return;
				autoOpen(r,c);
				return;
			}
			if(plate[r][c]<0){
				gameover(r,c);
				console.log("GameOver");
				return;
			}
			//bfs
			bfs(r,c);
		}
		else if(event.button==2){
			if(gone[r][c]==1)return;
			var btn=document.getElementById('btn'+r+'_'+c);
			var numofmines=document.getElementById("nom");
			if(flags[r][c]==0){
				flags[r][c]=1;
				btn.innerHTML='<img src="${contextPath}/img/flag.png" alt="flag">';
				numofmines.innerHTML=numofmines.innerHTML*1-1;
			}else{
				flags[r][c]=0;
				btn.innerHTML='';
				numofmines.innerHTML=numofmines.innerHTML*1+1;
			}
		}
	}
</script>
</head>
<body onselectstart="return false">
<%@include file="menu.jsp" %>
	<div
		style="position: absolute; display: table; top: 0; left: 0; width: 100%; height: 100%;">
		<div style="display: table-cell; vertical-align: middle;">
			<div style="left:0;width:50%;">
				<div class="btn-group poscenter" data-toggle="buttons" style="display:table;
				<%=dfct==1 ? "margin-bottom:"+(32*3-1)+"px" : ""%>">
					<label class="btn btn-secondary <%=dfct==1 ? "active focus" : ""%>" onclick='re(1)'> <input type="radio"
						name="options" id="option1" autocomplete="off" <%=dfct==1 ? "checked" : ""%>>
						초급
					</label> <label class="btn btn-secondary <%=dfct==2 ? "active focus" : ""%>" onclick='re(2)'> <input type="radio"
						name="options" id="option2" autocomplete="off" <%=dfct==2 ? "checked" : ""%>> 중급
					</label> <label class="btn btn-secondary <%=dfct==3 ? "active focus" : ""%>" onclick='re(3)'> <input type="radio"
						name="options" id="option3" autocomplete="off" <%=dfct==3 ? "checked" : ""%>> 고급
					</label>
				</div>
			</div> 
			<div class="poscenter" 
			oncontextmenu="return false" ondragstart="return false" 
			style="display:table;margin-top:10px;padding:10px;
			background-color:#c8c8c8;<%=dfct==1 ? "margin-bottom:"+(32*3-1)+"px" : ""%>">
				<div class="poscenter backblack" style="
				padding:1px;display:table;margin-bottom:10px;height:30px;">
					<div class="scoreboard" id="nom" style="display:table-cell;"><%=mines %></div>
					<button onclick="replay()" 
					style="background-color:#00B400;color:#ffff00;width:51px;
					border-color:#00A000;margin-left:1px;margin-right:1px;">RE</button>
					<div id="clock" class="scoreboard" style="display:table-cell;">00 : 00</div>
				</div>
				<div class="poscenter backblack" style="display:table;">
					<div class="poscenter line out"></div>
					<% for(int i=0;i<y;i++){ %>
						<div class="poscenter out backblack">
								<div class='poscenter line wrap'></div>
							<% for(int j=0;j<x;j++){ %>
								<button class="poscenter closebutton wrap" 
								onmouseup="check(<%=i %>,<%=j %>)" id="btn<%=i%>_<%=j%>"><b></b></button>
								<div class='poscenter line wrap'></div>
							<%} %>
						</div>
						<div class="poscenter line out"></div>
					<%} %>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="modal.jsp" %>
</body>
</html>