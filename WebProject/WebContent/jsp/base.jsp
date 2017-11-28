<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html PUBLIC>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>BaseBall Game</title>
<link rel="stylesheet" href="${contextPath}/css/baseball.css">
<link rel="stylesheet" href="${contextPath}/css/position.css">
</head>
<% String numStr=request.getParameter("num");
	int num=numStr==null ? 3 : Integer.parseInt(numStr);
	if(num<3)num=3;
	if(num>5)num=3;
%>
<script>
var number;
var numberArray;
var nTry=0;
window.onload=function(){
	var arr=new Array();
	var n=<%=num%>;
	numberArray=[0,0,0,0,0,0,0,0,0,0];
	for(var i=0;i<n;i++){
		arr[i]=Math.floor(Math.random()*9)+1;
		for(var j=0;j<i;j++){
			if(arr[j]==arr[i]){
				i--;break;
			}
		}
	}
	number=0;
	for(var i=0;i<n;i++){
		number=number*10;
		number=number+arr[i];
		numberArray[arr[i]]=i+1;
	}
}
	console.log(<%=num%>);
	function re(i){
		var url='${contextPath}'+"/jsp/base.jsp";
		location.replace(url+"?num="+i);
	}
	function swing(){
		var n=<%=num%>;
		var l=document.getElementById("log");
		var num=0;
		var arr=[0,0,0,0,0,0,0,0,0,0];
		for(var i=1;i<=n;i++){
			var tmp=document.getElementById("num"+i).innerHTML*1
			num*=10;
			num+=tmp;
			arr[tmp]=i;
		}
	 	var bcnt=0;
	 	var scnt=0;
	 	for(var i=1;i<10;i++){
	 		//console.log(arr[i] + " " + numberArray[i]);
	 		if(arr[i]==0)continue;
	 		if(arr[i]==numberArray[i])scnt++;
	 		else if(arr[i]*numberArray[i]!=0)bcnt++;
	 	}
	 	var result=scnt+"S"+bcnt+"B";
	 	console.log(result);
		++nTry;
		if(scnt+bcnt==0){
			result="OUT!";
		}
		if(scnt==n){
			result="HOME RUN!";
			document.getElementById("swing").disabled=true;
			for(var i=1;i<=n;i++){
				document.getElementById("up"+i).disabled=true;
				document.getElementById("down"+i).disabled=true;
			}
			//Record Save
			event.preventDefault();
			var id='<%=((UserVo)session.getAttribute("user")).getId()%>';
			var game="base";
			var type=<%=num%>;
			var record=nTry;
			console.log(id,game,type,record);
			$.post("${contextPath}/change.do",
				{id: id, game : game, type : type, record : record},
				function(data){
					var myModal=$('#myModal');
					if(data.suc){
						myModal.find('.modal-title').text('Record - (n/t) - (numbers/num of try)');
						myModal.find('.modal-body').text(n+' '+nTry + '로 기록을 세웠습니다.');
						myModal.modal('show');
					}else{
						myModal.find('.modal-title').text('Recording Error');
						myModal.find('.modal-body').text('기록 갱신에 실패하였습니다.');
						myModal.modal('show');
					}
				}
			);
		}
		var str=nTry+'';
		var addHTML='<div style="display:table;width:300px;height:30px;">'
			+'<div style="display:table-cell;padding-left:20px;'
			+'vertical-align:middle;">'
				+'<div style="display:inline-block;width:140px;">'
					+str + ' : ' + num
				+'</div>'
				+'<div style="display:inline-block;">'
					+ result 
				+'</div>'
			+'</div>' 
		+'</div>';
		l.innerHTML+=addHTML;
		l.innerHTML+='<div style="width:300px;height:1px;background-color:black;"></div>';
	}
	function checkNum(){
		var n=<%=num%>;
		for(var i=1;i<=n;i++){
			for(var j=1;j<=n;j++){
				if(i==j)continue;
				var _1=document.getElementById("num"+i).innerHTML*1;
				var _2=document.getElementById("num"+j).innerHTML*1;
				//console.log(i+" "+j + " : " + _1 + " " + _2);
				if(_1==_2){	
					return true;
				}
			}
		}
		return false;
	}
	function up(i){
		var k=document.getElementById("num"+i).innerHTML*1;
		if(k==9)return;
		document.getElementById("num"+i).innerHTML=k+1;
		document.getElementById("swing").disabled=checkNum();
	}
	function down(i){
		var k=document.getElementById("num"+i).innerHTML*1;
		if(k==1)return;
		document.getElementById("num"+i).innerHTML=k-1;
		document.getElementById("swing").disabled=checkNum();
	}
</script>
<body onselectstart="return false">
	<%@ include file="menu.jsp"%>
	<div class="poscenter" style="position:absolute;background-color:black;top:0;left:50%;width:2px;height:100%;"></div>
	<div
		style="position: absolute; display: table; top: 0; left: 0; width: 50%; height: 100%;">
		<div style="display: table-cell; vertical-align: middle;">
			<div class="btn-group poscenter" data-toggle="buttons" style="display:table;margin-bottom:100px;">
				<label class="btn btn-secondary <%=num==3 ? "active focus" : ""%>" onclick='re(3)'> <input type="radio"
					name="options" id="option1" autocomplete="off" <%=num==3 ? "checked" : ""%>>
					3 숫자
				</label> <label class="btn btn-secondary <%=num==4 ? "active focus" : ""%>" onclick='re(4)'> <input type="radio"
					name="options" id="option2" autocomplete="off" <%=num==4 ? "checked" : ""%>> 4 숫자
				</label> <label class="btn btn-secondary <%=num==5 ? "active focus" : ""%>" onclick='re(5)'> <input type="radio"
					name="options" id="option3" autocomplete="off" <%=num==5 ? "checked" : ""%>> 5 숫자
				</label>
			</div>
			<div class='out poscenter'>
				<button class='wrap basebutton' onclick="up(1)" id="up1" style="border:0;">
					<img src="${contextPath}/img/arrow.png" alt="up">
				</button>
			<% for(int i=1;i<num;i++){ %>
				<div class='wrap line'></div>
				<button class='wrap basebutton' onclick="up(<%=i+1%>)" id="up<%=i+1 %>" style="border:0;">
					<img src="${contextPath}/img/arrow.png" alt="up">
				</button>
			<%} %>
			</div>
			<div class='out poscenter line'></div>
			<div class='out poscenter'>
			<div class='wrap basecard' id="num1">1</div>
				
			<% for(int i=2;i<=num;i++){ %>
				<div class='wrap line'></div>
				<div class='wrap basecard' id="num<%=i%>"><%=i %></div>
			<% } %>
			</div>

			<div class='out poscenter line'></div>
			<div class='out poscenter'>
				<button class='wrap basebutton' onclick="down(1)" id="down1" style="border:0;">
					<img src="${contextPath}/img/arrow_.png" alt="down">
				</button>
				<% for(int i=1;i<num;i++){ %>
				<div class='wrap line'></div>
				<button class='wrap basebutton' onclick="down(<%=i+1%>)" id="down<%= i+1 %>" style="border:0;">
					<img src="${contextPath}/img/arrow_.png" alt="down">
				</button>
				<% } %>
			</div>
			<div class='out poscenter line'></div>
			<div class='out poscenter'>
				<button class='btn btn-success' id=swing onclick='swing()' style=
				"width:<%=102*num - 3 +"px" %>;margin-bottom:150px;
				border-radius:0 0 0.25em 0.25em">SWING!</button>
			</div>
		</div>
	</div>
	<div style="position: absolute; display: table; top: 0; left: 50%; width: 50%; height: 100%;">
		<div style="display: table-cell;top:30%;">
			<div style="margin-top:100px;margin-left:50px;" id="log">
				<div style="width:300px;height:1px;background-color:black;"></div>
				<div style="display:table;width:300px;height:30px;">
					<div style="display:table-cell;padding-left:20px;
					background-color:#c8c8c8;vertical-align:middle;">
						<div style="display:inline-block;"> 
							<b><i>#</i></b>
						</div>
						<div style="display:inline-block;margin-left:120px;">
							<b>Result</b>
						</div>
					</div>
				</div>
				<div style="width:300px;height:0.75px;background-color:black;"></div>
				<div style="width:300px;height:2px;background-color:white;"></div>
				<div style="width:300px;height:1px;background-color:black;"></div>
			</div>
		</div>
	</div>
	<%@ include file="modal.jsp" %>
</body>
</html>