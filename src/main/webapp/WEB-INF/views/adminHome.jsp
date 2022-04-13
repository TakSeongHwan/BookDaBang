<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>adminHome</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	  
	  
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drowLinearChart);

$(function(){

	
	
});
function insertVisitor(){
	
	let ip = (Math.floor(Math.random() * 255) + 1)+"."+(Math.floor(Math.random() * 255))+"."+(Math.floor(Math.random() * 255))+"."+(Math.floor(Math.random() * 255));
	console.log(ip);
	let year = "2022"
	let month = Math.floor(Math.random()*4+1);
	if(month < 10){
		month = "0"+month
	}
	let date = Math.floor(Math.random()*30+1);
	if(date < 10){
		date = "0"+date
	}
	console.log(year)
	console.log(month)
	console.log(date)

	let ad = year+"-"+month+"-"+date;
	console.log(ad);
	let sendData = JSON.stringify({
		ipaddr : ip,
		accessdate : ad	
		
		
	});
	
	$.ajax({
		url : "${contextPath}/chart/autoInsertVisitor",
		dataType : "json",
		type : "post",
		data: sendData,
		contentType : "application/json; charset=UTF-8",
	 	success: function(data){
	 		console.log(data)
	 		}
	 	
	});
	
	
}
function drowLinearChart(){
	$.ajax({
		url : "${contextPath}/chart/getVisitorInfo",
		dataType : "json",
		async : false,
	 	success: function(data){
	 		let tableData = '[["Date","Count"]';
		 		$.each(data, function(i,e){
					console.log(e.monthSort)
		 			tableData += ",["+e.monthSort+","+e.visitor+"]"
		 		});
	 			tableData +="]"
		 		visitorChart(tableData);
	 			
	 		}
	 	
	});
}

function dateFormat(accessdate){
	console.log(accessdate);
	let year = accessdate.getFullYear();
	let month = accessdate.getMonth()+1;
	if(month < 10){
		month = "0"+month
	}
	let date = accessdate.getDate();
	if(date < 10){
		date = "0"+date
	}
	
	return year+""+month+""+date;
}

function visitorChart(tableData){

	console.log(tableData);
	
	var tData = google.visualization.arrayToDataTable($.parseJSON(tableData));

    var options = {title: '월별 방문자수',
            curveType: 'function',
            legend: { position: 'bottom' },
            vAxis:{title:'방문자수', maxValue:100, minValue:0},
            hAxis:{title:'날짜', format:'none', maxValue:4, minValue:1}
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
    chart.draw(tData, options);
	
}

</script>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
		<div>여기에 내용</div>
<div class="chartContainer">
   <div id="chart_div"></div>
   
   <button type="button" onclick="insertVisitor();">방문자 인풋</button>
</div>
	<jsp:include page="managerFooter.jsp"></jsp:include>
</body>
</html>