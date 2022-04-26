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
<title>visitorChartDetail</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	$(function() {

	});
	function getDetailChart() {
		let startDate = new Date($("#startDate").val());
		let endDate = new Date($("#endDate").val());
		let searchType = $("#searchType").val();
		console.log(searchType)
		console.log(startDate);
		console.log(endDate);
		if (startDate <= endDate) {
			$("#validDate").empty();
			console.log("시작일이 종료일보다 작다")

			let sendData = JSON.stringify({
				searchType : searchType,
				startDate : startDate,
				endDate : endDate
			});

			let url = "${contextPath}/chart/getVisitorDetailChart"

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
					console.log(data);
					drawVisitorChart(data);
				},
				error : function(e) {
					console.log(e.responseText);
				}

			});
		} else {
			$("#validDate").empty();
			let output = '<div class="alert alert-danger alert-dismissible" role="alert">유효하지 않은 날짜입니다.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
			$("#validDate").html(output);
		}
	}
	function drawVisitorChart(parseData){
		

		$("#myChart").remove();
		$("#myChartDiv").html('<canvas id="myChart" width="300px" height="300px"></canvas>');
		
		parseData = parseData.visitorDetail;
		 let labels = [];
			let chartData =[]; 
			let backgroundColor='rgb(255, 105, 108)';
			for(let i=0;i< parseData.length;i++){
				if($("#searchType").val() == "week"){
					let repackLabel = "";
					let year = parseData[i].dateSort.split("-")[0];
					let month = parseData[i].dateSort.split("-")[1];
					let day = parseData[i].dateSort.split("-")[2]
					let week = parseData[i].dateSort.split(" ")[1]; 
					console.log(repackLabel);
				}else{
					labels.push(parseData[i].dateSort);
				}
				
				chartData.push(parseData[i].visitor);
			}
			
			let data = {
					  labels: labels,
					  datasets: [{
					    label: '날짜별 방문자',
					    backgroundColor: backgroundColor,
					    borderColor: backgroundColor,
					    data: chartData
					  }]
					};
			
			let config = {
					  type: 'line',
					  data,
					  options: {
						  
						  responsive : true,
							plugins : {
								legend : {
									display : true,
									position : 'bottom',
								}
							},scales: {
					            y: {
					                beginAtZero: true
					            }
					        }
						  
						  
					  }
					};
		
				
				  let myChart = new Chart(
						    document.getElementById('myChart'),
						    config
						  );
	}
</script>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
	<div class="container mt-3 ">
		<h1 style="margin-top: 5%;">방문자 통계 상세조회</h1>

		<div style="display: flex; margin-top: 5%;">
			<div class="input-group" style="width: 10%;">
				<div style="height: auto; width:100%;">단위</div>
				<select class="form-select" id="searchType"
					name="searchType">
				
					<option value="day">일</option>
					<option value="week">주</option>
					<option value="month">월</option>
							<option value="year">년</option>
				</select>
			</div>
			<div style="margin: 0% 2%;">
			
		
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
			<div style="display: flex; align-items: flex-end;">
				<button type="button" class="btn btn-outline-primary"
					style="height: 38px;" onclick="getDetailChart();">검색</button>
			</div>
		</div>
		<div id="validDate"></div>
		<div id="myChartDiv" class="card" style="margin: 2% 0%; ">
		<canvas id="myChart" width="300px" height="300px"></canvas>
		</div>
	</div>
	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>