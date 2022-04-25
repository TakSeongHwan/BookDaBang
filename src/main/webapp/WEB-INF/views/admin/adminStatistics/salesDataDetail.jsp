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
	$(function() {
	
	});
	function getDetailChart(){
		let searchType = $("#searchType").val();
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		
		if(startDate == "" || startDate == null){
			startDate = new Date('1970-01-01');
		}
		if(endDate == "" || endDate == null){
			endDate = new Date();
		}
		console.log(searchType + " - " + startDate + " - " + endDate);
		let sendData = JSON.stringify({
			searchType : searchType,
			startDate : startDate,
			endDate : endDate
		});
		if (new Date(startDate) <= new Date(endDate)) {
			$("#validDate").empty();
		let url = "${contextPath}/chart/getDetailChart"
		
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

				if(data.categoryResult != null){
					console.log("카테고리!")
					drawDetailCategoryChart(data);
				}else if(data.ageResult != null){
					console.log("나이!")
					drawDetailAgeChart(data);
				}else if(data.genderResult != null){
					console.log("성별!")
					drawDetailGenderChart(data);
				}
			},error: function(e){
				console.log(e.responseText);
			}

		});
		} else {
			$("#validDate").empty();
			let output = '<div class="alert alert-danger alert-dismissible" role="alert">시작일은 종료일보다 늦을 수 없습니다.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
			$("#validDate").html(output);
		}
		
	}
	function drawDetailCategoryChart(parseData){
		
		
		$("#drawChart").remove();
		$("#drawChartDiv").html('<canvas id="drawChart" width="400px" height="400px"></canvas>');
			
		
		parseData = parseData.categoryResult;
	 let labels = [];
		let chartData =[]; 
		let backgroundColor=[];
		
		for(let i=0;i< parseData.length;i++){
			labels.push(parseData[i].category_name);
			chartData.push(parseData[i].totalSales);
		backgroundColor.push('rgba('+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+',0.5)');
		}
		console.log(labels);
		console.log(chartData);
		console.log(backgroundColor);
		let data = {
				  labels: labels,
				  datasets: [{
				    label: '카테고리별 판매량',
				    backgroundColor: backgroundColor,
				    borderColor: backgroundColor,
				    data: chartData,
				    borderWidth:1
				  }]
				};
		
		let config = {
				  type: 'bar',
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
					    document.getElementById('drawChart'),
					    config
					  );
		
	}
	function drawDetailAgeChart(parseData){

		
		$("#drawChart").remove();
		$("#drawChartDiv").html('<canvas id="drawChart" width="400px" height="400px"></canvas>');
			
		
		parseData = parseData.ageResult;
		console.log(parseData);
	 	let labels = [];
		let chartData =[]; 
		let backgroundColor=[];
		for(let p in parseData){
			labels.push(p+"대");
			console.log(p)
			if(p.length == 0){
				chartData.push(0);
				console.log("이 데이터는 비어있다")
			}else{
				chartData.push(p.length);
			}
			backgroundColor.push('rgba('+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+',0.5)');
		}
		
		console.log(labels);
		console.log(chartData);
		console.log(backgroundColor);
		let data = {
				  labels: labels,
				  datasets: [{
				    label: '연령대별 판매량',
				    backgroundColor: backgroundColor,
				    borderColor: backgroundColor,
				    data: chartData,
				    borderWidth:1
				  }]
				};
		
		let config = {
				  type: 'bar',
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
					    document.getElementById('drawChart'),
					    config
					  );
		
	}
	function drawDetailGenderChart(parseData){
		$("#drawChart").remove();
		$("#drawChartDiv").html('<canvas id="drawChart" width="400px" height="400px"></canvas>');
			
		
		parseData = parseData.genderResult;
	 let labels = [];
		let chartData =[]; 
		let backgroundColor=[];
		
		for(let i=0;i< parseData.length;i++){
			labels.push(parseData[i].category_name);
			chartData.push(parseData[i].totalSales);
		backgroundColor.push('rgba('+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+','+Math.floor((Math.random()*255+1))+',0.5)');
		}
		console.log(labels);
		console.log(chartData);
		console.log(backgroundColor);
		let data = {
				  labels: labels,
				  datasets: [{
				    label: '성별별 판매량',
				    backgroundColor: backgroundColor,
				    borderColor: backgroundColor,
				    data: chartData,
				    borderWidth:1
				  }]
				};
		
		let config = {
				  type: 'bar',
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
					    document.getElementById('drawChart'),
					    config
					  );
		
	}
</script>

<style>
.ellipsis {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	height: 40px;
	width: 10%;
}

.titleWidth {
	width: 100px;
}
</style>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>

	<div class="container mt-3">
		<h1 style="margin-top: 5%;">판매량 통계 상세조회</h1>

		<div style="display: flex; margin-top: 5%;">

			<div class="input-group" style="width: 10%;">
				<div style="height: auto; width:100%;">조회할 자료</div>
				<select class="form-select" id="searchType"
					name="searchType">
				
					<option value="category">카테고리</option>
					<option value="age">연령대</option>
					<option value="gender">성별</option>
				</select>
			</div>
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
			<div style="display: flex; align-items: flex-end;">
			<button type="button" class="btn btn-outline-primary" style="height: 38px;" onclick="getDetailChart();">검색</button>
			</div>
		</div>
		<div id="validDate"></div>
		<div id="drawChartDiv" style="margin-top: 2%;">
			<canvas id="drawChart" width="400px" height="400px"></canvas>
		
		</div>
	</div>

	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>