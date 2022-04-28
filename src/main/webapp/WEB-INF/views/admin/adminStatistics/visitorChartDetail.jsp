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
		if(${member.isAdmin != 'Y'}){
			alert("잘못된 접근입니다!");
			location.href=history.back();
		}
	});
	function getDetailChart() {
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		let searchType = $("#searchType").val();
		console.log(searchType)
		console.log(startDate);
		console.log(endDate);
		
		if(startDate == "" || startDate == null){
			startDate = new Date();
			startDate.setDate(startDate.getDate() - 7);
			console.log(startDate);
		}
		if(endDate == "" || endDate == null){
			endDate = new Date();
		}
		if (new Date(startDate) <= new Date(endDate)) {
			$("#validDate").empty();
	

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
		$("#myChartDiv").html('<canvas id="myChart" width="300vw", height="500vh" style="margin:2%;"></canvas>');
		
		parseData = parseData.visitorDetail;
		 let labels = [];
			let chartData =[]; 
			let backgroundColor='rgb('+Math.floor(Math.random()*255+1)+', '+Math.floor(Math.random()*255+1)+', '+Math.floor(Math.random()*255+1)+')';
			let repackData = [];
			let flag = 0;
			let repackLabel = [];
			let visitor = 0;
			for(let i=0;i< parseData.length;i++){
				if($("#searchType").val() == "week"){
			
				
					if(flag==7){
						repackData.push(repackLabel);
						chartData.push(visitor);
						console.log(repackLabel)
						console.log(repackData)
						repackLabel = [];
						flag=0;
						visitor = 0;
					}else if(flag != 0 && i == parseData.length-1){
						repackData.push(repackLabel);
						chartData.push(visitor);
					}
					
					repackLabel.push(parseData[i].dateSort);
					visitor += parseData[i].visitor;
			
					
					
					flag++;
				
				}else{
					labels.push(parseData[i].dateSort);
					chartData.push(parseData[i].visitor);
				}
				
				
			}
			console.log(chartData)
			console.log(repackData);
			if($("#searchType").val() == "week"){
			for(let i = 0; i<repackData.length; i++){
				
				if(repackData[i].length != 7){
					let j = repackData[i].length -1
					labels.push(repackData[i][0] + " ~ "+repackData[i][j]);
				}else{
					labels.push(repackData[i][0] + " ~ "+repackData[i][6]);
				}
				
				
			}
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
						  maintainAspectRatio: false,
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
		<h1 style="margin-top: 2%;">방문자 통계 상세조회</h1>

		<div style="display: flex; margin-top: 2%;">
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
		<h6 style="margin-top:1%;  margin-left:2%;">기간을 입력하지 않을 시, 최근 7일간의 방문자 수를 출력합니다</h6>
		<div id="validDate"></div>
		<div class="card" style="margin: 2% 0%;">
		<div id="myChartDiv" style="width:80%; height:80%;">
		<canvas id="myChart" style="margin:2%;" width="300vw", height="500vh"></canvas>
		</div>
		</div>
	</div>
	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>