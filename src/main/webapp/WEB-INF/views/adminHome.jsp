<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js" integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
	 
		 	
		 		visitorChart(data);
	 			
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
	
/* 	var tData = google.visualization.arrayToDataTable($.parseJSON(tableData));

    var options = {title: '월별 방문자수',
            legend: { position: 'bottom' },
            vAxis:{title:'방문자수', maxValue:100, minValue:0},
            hAxis:{title:'날짜', format:'none', maxValue:4, minValue:1}
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
    chart.draw(tData, options); */
    
const labels = [];
let values = [];	
	$.each(tableData, function(i,e){
		
		labels.push(e.monthSort);
		values.push(e.visitor);
		
	});

	console.log(labels)
	

	
	
	
      const data = {
        labels: labels,
        datasets: [{
          label: '월별 방문자수',
          backgroundColor: 'rgb(255, 99, 132)',
          borderColor: 'rgb(255, 99, 132)',
          data: values,
          
        }]
      };

      const config = {
        type: 'line',
        data: data,
        options: {
        	 responsive: true,
             legend: {
                 position: 'bottom',
             }, scales: {
                 xAxes: [{
                     display: true,
                     scaleLabel: {
                         display: true,
                         labelString: 'Month'
                     }
                 }],
                 yAxes: [{
                     ticks: {
                         min: 0,
                         max: 100,
                         stepSize: 20
                     }
                 }]
         }
        	
        }
      };
    
      const myChart = new Chart(
    		    document.getElementById('myChart'),
    		    config
    		  );
	
	
}

</script>
<style type="text/css">
#chart_div{
width: 300px;
}

</style>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
<div class="chartContainer">
   <div id="chart_div"></div>
   <div>
  <canvas id="myChart"></canvas>
</div>
 
   <button type="button" onclick="insertVisitor();">방문자 인풋</button>
</div>
	<jsp:include page="managerFooter.jsp"></jsp:include>
</body>
</html>