<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"
	integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>salesDataDetail</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<script>

function getDetailChart(){
	let searchType = $("#searchType").val();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();
	if(startDate == "" || startDate == null){
		startDate = new Date();
		startDate.setDate(startDate.getDate() - 7);
	}
	if(endDate == "" || endDate == null){
		endDate = new Date();
	}
	console.log(searchType + " - " + startDate + " - " + endDate);
	let sendData = JSON.stringify({
		startDate : startDate,
		endDate : endDate
	});
	if (new Date(startDate) <= new Date(endDate)) {
		$("#validDate").empty();
	let url = "${contextPath}/chart/periodSalesDetail"
	
	$.ajax({
		url : url,
		dataType : "json",
		type : "POST",
		headers : {
			"content-type" : "application/json",
			"x-HTTP-Method-Override" : "POST"
		},
		data : sendData,
		success : function(data) {
			console.log(data)
			drawChart(data)
		},error: function(e){
			console.log(e.responseText);
		}

	});
	} else {
		$("#validDate").empty();
		let output = '<div class="alert alert-danger alert-dismissible" role="alert">유효하지 않은 날짜입니다<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
		$("#validDate").html(output);
	}
	
	
}
function drawChart(perseData){
	
	$("#drawChart").remove();
	$("#drawChartDiv").html('<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>');
	
	perseData = perseData.periodSalesDetail;
	
	let labels = [];
	let values = [];
	let color = 'rgb('+Math.floor(Math.random()*255+1)+', '+Math.floor(Math.random()*255+1)+', '+Math.floor(Math.random()*255+1)+')';
	$.each(perseData, function(i, e) {

		labels.push(e.date);
		values.push(e.totalSales/100000);

	});

	console.log(labels);

	let linedata = {
		labels : labels,
		datasets : [ {
			label : '날짜별 총매출(단위 : 10만)',
			backgroundColor : color,
			borderColor : color,
			data : values,

		} ]
	};

	let myChart = new Chart(document.getElementById('drawChart'), {
		type : 'line',
		data : linedata,
		options : {
			maintainAspectRatio: false,
			responsive : true,
			plugins : {
				legend : {
					display : true,
					position : 'bottom',
				}
			}
		}
	});
	
}
</script>


</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>

	<div class="container mt-3">
		<h1 style="margin-top: 2%;">총 매출 상세조회</h1>

		<div style="display: flex; margin-top: 2%;">
			<div style="margin:0% 2%;">
				<div style="height: auto;">조회할 기간</div>
				<div style="display: flex; justify-content: space-between;">
					<div class="input-group" style="width: 45%;">

						<input type="date" class="form-control" id="startDate"
							name="startDate">

					</div>
					<div>~</div>
					<div class="input-group" style="width: 45%;">

						<input type="date" class="form-control" id="endDate"
							name="endDate">

					</div>
				</div>
			</div>
			<div id="buttonDiv" style="display: flex; align-items: flex-end; width:50%;">
			<button type="button" class="btn btn-outline-primary" style="height: 38px;width:20%;" onclick="getDetailChart();">검색</button>
			</div>
		</div>
		<h6 style="margin-top:1%;  margin-left:2%;">기간을 입력하지 않을 시, 최근 7일간의 총 판매량을 출력합니다</h6>
		<div id="validDate"></div>
		<div class="card" style="margin: 5% 0%;">
			<div id="drawChartDiv" style="width:80%; height:80%;">
			<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>
			</div>
			
		
		</div>
	</div>



		

	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>