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
<title>adminHome</title>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">
	jQuery(function($) {
		drowLinearChart();
		getTodayVisitor();
		getYesterdayVisitor();
		getCategoryTotalSales();
		getWeekVisitor();

	});

	function drowLinearChart() {
		$.ajax({
			url : "${contextPath}/chart/getVisitorInfo",
			dataType : "json",
			async : false,
			success : function(data) {
				visitorChart(data);
				console.log(data);
				let diff = 0;
				let moreOrLess = "";
				for(i = 0; i<data.length; i++){
		
					if(i+1 < data.length){
						let prev = data[i].visitor  
						let curr = data[i+1].visitor 
						console.log(curr)
						diff = prev - curr;
						if(diff > 0){
							moreOrLess = "적게"
						}else if(diff < 0){
							diff = diff*-1
							moreOrLess = "많이"
						}else{
							$("#visitorCheck").html("이번 달의 방문자 수는 저번 달의 방문자 수와 같습니다.");
						}
						
					}
					
					
				}
				$("#moreOrLess").html(moreOrLess);
				$("#diffVisitor").html(diff);
			}

		});
	}

	function visitorChart(tableData) {

		console.log(tableData);

		let labels = [];
		let values = [];
		$.each(tableData, function(i, e) {

			labels.push(e.dateSort);
			values.push(e.visitor);

		});

		console.log(labels);

		let linedata = {
			labels : labels,
			datasets : [ {
				label : '월별 방문자수',
				backgroundColor : '#ff66a3',
				borderColor : '#ff66a3',
				data : values,

			} ]
		};

		let myChart = new Chart(document.getElementById('myChart'), {
			type : 'line',
			data : linedata,
			options : {
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

	function getTodayVisitor() {
		$.ajax({
			url : "${contextPath}/chart/getTodayVisitor",
			dataType : "json",
			type : "GET",
			success : function(data) {
				console.log(data);
				$("#todayVisitor").text(data.todayVisitor);
			}

		});
	}
	function getYesterdayVisitor() {
		$
				.ajax({
					url : "${contextPath}/chart/getYesterdayVisitor",
					dataType : "json",
					type : "GET",
					success : function(data) {
						console.log(data);
						$("#yesterdayVisitor").text(data.yesterdayVisitor);
						let diff = data.yesterdayVisitor
								- $("#todayVisitor").html();
						let output = "";
						console.log(diff);
						if (diff > 0) {
							output = "<i class='text-danger fw-semibold bx bx-down-arrow-alt'>"
									+ diff + "</i>"
						} else if (diff < 0) {
							diff = diff*-1
							output = "<i class='text-success fw-semibold bx bx-up-arrow-alt'>"
									+ diff + "</i>"
						} else {
							output = "<i class='text-secondary fw-semibold bx bx-minus'>"
									+ diff + "</i>"
						}
						$("#diff").html(output);
					}

				});

	}
	function getCategoryTotalSales() {
		$.ajax({
			url : "${contextPath}/chart/getCategoryTotalSales",
			dataType : "json",
			type : "GET",
			success : function(data) {
				console.log(data);
				getOrderStatisticsChart(data);
				inputTop3(data);
			}

		});
	}
	function getOrderStatisticsChart(totalSalesData) {
		console.log(totalSalesData);
		let labels = [];
		let data = [];
		let totalSalesSum = 0;
		$.each(totalSalesData.cts, function(i, e) {
			labels.push(e.category_name);
			data.push(e.totalSales);
			totalSalesSum += e.totalSales

		});

		console.log(data);

		$("#totalSalesSum").html(totalSalesSum.toLocaleString());
		let doughnutData = {
			labels : labels,
			datasets : [ {
				label : '카테고리별 판매량',
				data : data,
				backgroundColor : [ '#ff3e1d', '#ffab00', '#71dd37', '#20c997',
						'#03c3ec', '#007bff', '#696cff', '#6610f2', '#e83e8c' ],
				hoverOffset : 9
			} ]
		};

		let myChart = new Chart(document.getElementById('myDoughnutChart'), {
			type : 'doughnut',
			data : doughnutData,
			options : {
				responsive : true,
				plugins : {
					legend : {
						display : false,
						position : 'bottom',
					}
				}
			}
		});

	}
	function inputTop3(data) {
		data = data.cts;
		let output = "";
		let color = "";
		let icon = "";
		console.log(data)
		for (let i = 0; i < 6; i++) {

			if (i == 0) {
				color = "danger";
				icon = "<i class='bx bx-dice-1'></i>";
			} else if (i == 1) {
				color = "warning";
				icon = "<i class='bx bx-dice-2'></i>";
			} else if (i == 2){
				color = "success";
				icon = "<i class='bx bx-dice-3'></i>";
			} else if (i == 3){
				color = "info";
				icon = "<i class='bx bx-dice-4' ></i>";
			}
			 else if (i == 4){
					color = "blue";
					icon = "<i class='bx bx-dice-5' ></i>";
				}
			 else if (i == 5){
					color = "primary";
					icon = "<i class='bx bx-dice-6' ></i>";
				}
			output += '<li class="d-flex mb-4 pb-1"><div class="avatar flex-shrink-0 me-3"><span class="avatar-initial rounded bg-label-'+color+'">'
					+ icon + '</span></div>';
			output += '<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2"><div class="me-2">';
			output += '<h6 class="mb-0">' + data[i].category_name + '</h6>'
			output += '<small class="fw-semibold">'
					+ data[i].totalSales.toLocaleString() + '</small>'
			output += '</div><div class="user-progress">'
			output += '</div></div></li>';

		}

		$("#inputTop3").html(output);

	}
	/* function getRecentBestSellerInSalesData() {
		$.ajax({
			url : "${contextPath}/chart/getRecentBestSellerInSalesData",
			dataType : "json",
			type : "GET",
			success : function(data) {
				console.log(data);
				viewRecentBestSeller(data);

			}

		});

	}
	function viewRecentBestSeller(data) {
		data = data.recentBestSeller;
		data = data[0];
		console.log(data);
		let coverOutput = "<img src ='" + data.cover + "'style='width:100%;'/>";
		$("#rbsCover").html(coverOutput);
		let titleOutput = data.title;
		$("#rbsTitle").text(titleOutput);
	} */

	function getWeekVisitor() {
		$.ajax({
			url : "${contextPath}/chart/getWeekVisitor",
			dataType : "json",
			type : "GET",
			success : function(data) {
				console.log(data);
				drawWeekVisitorChart(data);
			}

		});
	}
	function drawWeekVisitorChart(data) {
		data = data.weekVisitor;
		let labels = [];
		let chartData = [];
		$.each(data, function(i, e) {
			labels.push(e.dateSort);
			chartData.push(e.visitor);

		});

		let linedata = {
			labels : labels,
			datasets : [ {
				label : '일별 방문자수',
				backgroundColor : '#a2b9ad',
				borderColor : '#a2b9ad',
				data : chartData,

			} ]
		};

		let myChart = new Chart(document.getElementById('myWeekChart'), {
			type : 'line',
			data : linedata,
			options : {
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
<style type="text/css">
.chartContainer{
margin-bottom: 5%;
}
.bg-label-blue{
    background-color:#dbecff !important;
    color: #007bff !important;
}
#visitorChart {
	margin: 2%;
}

.visitorMain {
	width: 55%;
	top: 0px;
}

.cardIcon {
	text-align: center;
}

.smallCard {
	display: inline-block;
	height: auto;
	width: 40%;
	margin-left: 2%;
}

.visitorCountCard {
	text-align: center;
	font-size: 24px;
	justify-content: center;
}

.innerCard {
	display: inline-block;
	text-align: center;
	width: 45%
}

.cardMargin {
	margin-top: 15px;
}

.mb-4 {
	margin-right: auto;
	margin-right: left;
	width: 45%;
	display: inline-block;
}

#upperDiv {
	width: 100%;
	height: auto;
	display: flex;
	flex-wrap: wrap;
}

#currentMonthVisitor {
	width: 100%;
	margin: 5%;
}

#midDiv {
	width: 100%;
	height: auto;
}

#orderStatistics {
	display: inline-block;
	height: auto;
	width: 100%;
	top: 100%;
	right: 2%;
}

.col-xl-4 {
	width: 100% !important;
}

#myDoughnutChart {
	right: 2%;
}

.vCardElepsis {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	height: 20%;
	width: 80%;
}

#inputTop3 {
	margin-top: 10%;
}

#inputTop3>li {
	width: 100%
}

.owl-stage-outer {
	height: 250px;
	margin-top: 20px;
}

.card-product__img>img {
	max-width: auto;
	min-width: auto;
	max-height: 150px;
	min-height: 150px;
}

.owl-item {
	height: 150px;
}

.card-product__title {
	
}

.card-product__title>a {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
	height: 25px;
	width: 100px;
	margin: auto;
}

.my-card-body {
	padding-top: 10px;
}

.owl-dots {
	visibility: hidden !important;
}

.owl-nav {
	visibility: hidden !important;
}
</style>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
	<div class="container-xxl chartContainer">
		<h1 style="margin-top: 5%;">DashBoard</h1>
		<div id="upperDiv">
			<div class="visitorMain">
				<div class="card">
			
					<div class="d-flex align-items-end row">
						<div class="col-sm-7" style="width: 100%;">

							<div class="card-body">
								<div id="visitorChart">
									<canvas id="myChart"></canvas>
								</div>
							</div>
						</div>
						<div class="col-sm-7" style="width: 100%;">

							<div class="card-body">
								<div id="visitorWeekChart">
									<canvas id="myWeekChart"></canvas>
								</div>
							</div>
						</div>
						
						<div class="col-sm-7" style="width: 100%;">
						<div class="text-center text-sm-left" style="display: flex; justify-content: flex-end;">
						<div style="margin: auto;">
						<h5 class="card-title text-primary" id="visitorCheck">이번 달은 저번 달보다<br/> <span id="diffVisitor"></span>명 더 <span id="moreOrLess"></span> 방문했습니다</h5>
						</div>
                        <div >
                          <img src="${contextPath }/resources/assets/img/illustrations/man-with-laptop-light.png" height="140" alt="View Badge User" data-app-dark-img="illustrations/man-with-laptop-dark.png" data-app-light-img="illustrations/man-with-laptop-light.png">
                        </div>
                      </div>
                      </div>

					</div>
						
						<button type="button" class="btn btn-outline-primary"  style="border-color:transparent; border-top-left-radius:0; border-top-right-radius:0;" onclick="location.href='${contextPath}/admin/adminStatistics/visitorChartDetail'">더보기</button>
				
				</div>


			</div>

			<!--    <div id="chart_div"></div> -->


			<!--   <button type="button" onclick="insertVisitor();">방문자 인풋</button> -->

			<div class="smallCard">
				<div>
					<div class="mb-4"
						style="display: flex; width: 100%; justify-content: space-around;">
						<div class="card innerCard">
							<div class="card-body">
								<div class="card-title cardIcon">
									<div class="avatar" style="margin: auto;">

										<span class="avatar-initial rounded bg-label-primary">
											<i class='bx bxs-user-pin'></i>
										</span>

									</div>
								</div>
								<span class="vCardElepsis">오늘 방문자 수</span>
								<h2 id="todayVisitor" class="visitorCountCard"></h2>
								<small id="diff"></small>
							</div>
						</div>
						<div class="card innerCard">
							<div class="card-body">
								<div
									class="card-title d-flex align-items-start justify-content-between cardIcon">
									<div class="avatar" style="margin: auto;">

										<span class="avatar-initial rounded bg-label-secondary">
											<i class='bx bxs-user-pin'></i>
										</span>

									</div>

								</div>

								<span class="vCardElepsis">전날 방문자 수</span>
								<h2 id="yesterdayVisitor" class="visitorCountCard"></h2>
								<small><i class='text-warning fw-semibold bx bx-smile'></i></small>
							</div>
						</div>
					</div>

				</div>
				<div id="orderStatistics">
					<div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
						<div class="card h-100">
							<div
								class="card-header d-flex align-items-center justify-content-between pb-0" style="margin-bottom: 2%;">
								<div class="card-title mb-0">
									<h5 class="m-0 me-2">판매량 통계</h5>
									<small class="text-muted totalSales">Total Sales</small>
								</div>
	
							</div>
							<div class="card-body">
								<div
									class="d-flex justify-content-between align-items-center mb-3"
									style="position: relative;">
									<div class="d-flex flex-column align-items-center gap-1">
										<h2 class="mb-2" id="totalSalesSum"></h2>
										<span>Total Sales</span>
									</div>

									<div id="orderChart">
										<canvas id="myDoughnutChart" width="220vw" height="220vh"></canvas>
									</div>
									<div class="resize-triggers">
										<div class="expand-trigger">
											<div style="width: 254px; height: 139px;"></div>
										</div>
										<div class="contract-trigger"></div>
									</div>
								</div>
								<ul class="p-0 m-0" id="inputTop3">



								</ul>
							</div>
								<button type="button" class="btn btn-outline-warning"  style="border-color:transparent; border-top-left-radius:0; border-top-right-radius:0;" onclick="location.href='${contextPath}/admin/adminStatistics/salesDataDetail'">더보기</button>
						</div>
						
					</div>
				
				</div>
			</div>
		</div>

		<div id="midDiv"></div>

	</div>


	<jsp:include page="managerFooter.jsp"></jsp:include>
</body>
</html>