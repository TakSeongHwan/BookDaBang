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
			startDate = new Date();
			startDate.setDate(startDate.getDate() - 7);
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
			let output = '<div class="alert alert-danger alert-dismissible" role="alert">유효하지 않은 날짜입니다<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
			$("#validDate").html(output);
		}
		
	}
	function drawDetailCategoryChart(parseData){
		console.log(parseData)
		
		$("#drawChart").remove();
		$("#modalBtn").remove();
		$("#bestSellerModal").empty();
		$("#drawChartDiv").html('<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>');
			
		
		parseData = parseData.categoryResult;
	 let labels = [
		 "철학, 심리학, 윤리학",
		 "종교",
		 "사회과학",
		 "자연과학",
		 "기술과학",
		 "예술",
		 "언어",
		 "문학",
		 "역사, 지리, 관광",
		 "미분류"
	 ];
		let chartData =[]; 
		let backgroundColor=[
			
			
			'rgba(255, 105, 108,0.5)',
			'rgba(255, 177, 105,0.5)',
			'rgba(255, 105, 183,0.5)',
			'rgba(105, 108, 255,0.5)',
			'rgba(3, 195, 236,0.5)',
			'rgba(44, 3, 236,0.5)',
			'rgba(255, 171, 0,0.5)',
			'rgba(236, 3, 78,0.5)',
			'rgba(211, 255, 0,0.5)',
			'rgba(0, 255, 171,0.5)'
			
			
		];
		
		for(let c in labels){
			let output = ""
			console.log(labels[c]);
			let flag = 0;
			let value = 0;
			output += '<div style="margin-bottom:2%;">';
			output += "<div style='font-weight:bold;'>"+labels[c]+"</div>"
			for(let i=0;i< parseData.length;i++){
				console.log(value);
					if(parseData[i].category_name == labels[c]){
						
						if(i+1 < parseData.length){
						if(flag < 3){
							value += parseData[i].sell_count;


							output+="<div>"+parseData[i].title+" :  "+parseData[i].sell_count+"권</div>"
						
							flag++;
						}else{
							value += parseData[i].sell_count;	
						}

				}
			}
			
			
		}
			output += '</div>';
			$("#bestSellerModal").append(output);

			chartData.push(value);
		}
			
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
					    document.getElementById('drawChart'),
					    config
					  );
		$("#buttonDiv").append('<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalScrollable" style="margin-left:2%; width:35%; height: 38px;">판매된 책 보기</button>');
	}
	function drawDetailAgeChart(parseData){

		
		$("#drawChart").remove();
		$("#modalBtn").remove();
		$("#bestSellerModal").empty();
		$("#drawChartDiv").html('<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>');
			
		
		parseData = parseData.ageResult;
		console.log(parseData);
	 	let labels = [];
		let chartData =[]; 
		let terminal = [];
		let backgroundColor=[
			
			'rgba(255, 105, 108,0.5)',
			'rgba(255, 177, 105,0.5)',
			'rgba(255, 105, 183,0.5)',
			'rgba(105, 108, 255,0.5)',
			'rgba(3, 195, 236,0.5)',
			'rgba(44, 3, 236,0.5)',
			'rgba(236, 3, 78,0.5)'
			
			
		];
		for(let p in parseData){
			labels.push(p+"대");
			
			
			
			if(parseData.hasOwnProperty(p)){
				terminal.push(parseData[p]);
			
			}
		}
		console.log(terminal);
		
		for(let i = 0; i<terminal.length; i++){
			let output = "";
			let sellCount = 0;
			let flag = 0;
			output += '<div style="margin-bottom:2%;">';
			output += "<div style='font-weight:bold;'>"+labels[i]+"</div>"
			if(terminal[i] != null){
				for(let j = 0; j<terminal[i].length;j++){
					if(flag < 3){
						output+="<div>"+terminal[i][j].title+" :  "+terminal[i][j].sell_count+"권</div>"
						flag++;
					}
					sellCount += terminal[i][j].sell_count;
				}
			
				
				chartData.push(sellCount);
			}else{
				chartData.push(0);
				
			}
			output += '</div>';
			$("#bestSellerModal").append(output);

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
					    document.getElementById('drawChart'),
					    config
					  );
			  $("#buttonDiv").append('<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalScrollable" style="margin-left:2%; width:35%; height: 38px;">판매된 책 보기</button>');
	}
	function drawDetailGenderChart(parseData){
		$("#drawChart").remove();
		$("#modalBtn").remove();
		$("#bestSellerModal").empty();
		$("#drawChartDiv").html('<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>');
			
		
		parseData = parseData.genderResult;
	 let labels = [];
		let chartData =[]; 
		let terminal = [];
		let backgroundColor=[];
		
		for(let p in parseData){
			labels.push(p);
			terminal.push(parseData[p]);
	
		}
		let sellCount = 0;
		for(let i = 0; i<terminal.length; i++){
			let output = "";
			let sellCount = 0;
			let flag = 0;
			output += '<div style="margin-bottom:2%;">';
			output += "<div style='font-weight:bold;'>"+labels[i]+"</div>"
			if(terminal[i] != null){
				for(let j = 0; j<terminal[i].length;j++){
					if(flag < 3){
						output+="<div>"+terminal[i][j].title+" :  "+terminal[i][j].sell_count+"권</div>"
						flag++;
					}
					sellCount += terminal[i][j].sell_count;
				}
			
				
				chartData.push(sellCount);
			}else{
				chartData.push(0);
				
			}
			output += '</div>';
			$("#bestSellerModal").append(output);
		}
		backgroundColor.push('rgba(255, 105, 108,0.5)');
		backgroundColor.push('rgba(105, 108, 255,0.5)');
		
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
					    document.getElementById('drawChart'),
					    config
					  );
			  $("#buttonDiv").append('<button type="button" id="modalBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalScrollable" style="margin-left:2%; width:35%; height: 38px;">판매된 책 보기</button>');
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
		<h1 style="margin-top: 2%;">판매량 통계 상세조회</h1>

		<div style="display: flex; margin-top: 2%;">

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
			<div id="buttonDiv" style="display: flex; align-items: flex-end; width:50%;">
			<button type="button" class="btn btn-outline-primary" style="height: 38px;width:20%;" onclick="getDetailChart();">검색</button>
			</div>
		</div>
		<h6 style="margin-top:1%; margin-left:2%;">기간을 입력하지 않을 시, 최근 7일간의 판매량 자료를 출력합니다</h6>
		<div id="validDate"></div>
		<div class="card" style="margin: 5% 0%;">
			<div id="drawChartDiv" style="width:80%; height:80%;">
			<canvas id="drawChart" style="margin:2%;" width="300vw", height="500vh"></canvas>
			</div>
			
		
		</div>
	</div>

<div class="modal fade" id="modalScrollable" tabindex="-1" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-scrollable" role="document">
                          <div class="modal-content">
                            <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel3">판매량 TOP 3</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                             <div id="bestSellerModal" class="row">
                                
                              </div>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                Close
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>

		

	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>