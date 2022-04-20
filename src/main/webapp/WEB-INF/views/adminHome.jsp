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
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js"
	integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<title>adminHome</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>


<script type="text/javascript">
	$(function() {
		drowLinearChart();
		getTodayVisitor();
		getYesterdayVisitor();
		getCategoryTotalSales();
	});

	function drowLinearChart() {
		$.ajax({
			url : "${contextPath}/chart/getVisitorInfo",
			dataType : "json",
			async : false,
			success : function(data) {
				visitorChart(data);
				console.log(data);
				for (let i = 0; i < data.length; i++) {

					if (i + 1 < data.length) {
						let diff = data[i].visitor - data[i + 1].visitor;
						if (diff < 0) {
							diff = -1 * diff;
							console.log(diff)
							$(".visitorDiff").html(diff);
							$(".moreOrLess").html("많");

						} else if (diff > 0) {
							console.log(diff)
							$(".visitorDiff").html(diff);
							$(".moreOrLess").html("적");
						} else {
							$("#currentMonthVisitor").html(
									"이번달의 방문자 수는 지난달과 같습니다")
						}

					}

				}

			}

		});
	}

	function visitorChart(tableData) {

		console.log(tableData);

		let labels = [];
		let values = [];
		$.each(tableData, function(i, e) {

			labels.push(e.monthSort);
			values.push(e.visitor);

		});

		console.log(labels);

		let linedata = {
			labels : labels,
			datasets : [ {
				label : '월별 방문자수',
				backgroundColor : '#03c3ec',
				borderColor : '#03c3ec',
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
						display : false,
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
	function getCategoryTotalSales(){
		$.ajax({
			url : "${contextPath}/chart/getCategoryTotalSales",
			dataType : "json",
			type : "GET",
			success : function(data) {
				console.log(data.cts);
				getOrderStatisticsChart(data.cts);
				inputTop3(data.cts);
			}

		});
	}
	function getOrderStatisticsChart(totalSalesData){
		console.log(totalSalesData);
		let labels = [];
		let data = [];
		let totalSalesSum = 0;
		$.each(totalSalesData, function(i, e) {
			labels.push(e.category_name);
			data.push(e.totalSales);
			totalSalesSum += e.totalSales
			
		});

		console.log(data);
	
		$("#totalSalesSum").html(totalSalesSum.toLocaleString());
		let doughnutData = {
				  labels: labels,
				  datasets: [{
				    label: 'My First Dataset',
				    data: data,
				    backgroundColor: [
				    	'#384AEB',
					      '#D923C2',
					      '#FF3A8C',
					      '#FF7F5F',
					      '#FFC04D',
					      '#F9F871',
					      '#FF2E44',
					      '#00C2A0',
					      '#982FAC'
				    ],
				    hoverOffset: 9
				  }]
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
	function inputTop3(data){
		let output = "";
		let color = "";
		let icon = "";

		for(let i = 0; i < 3; i++){
			
			if(i == 0){
				color = "info";
				icon = "bx bx-dice-1";
			}else if(i == 1){
				color = "warning";
				icon = "bx bx-dice-2";
			}else{
				color = "danger";
				icon = "bx bx-dice-3";
			}
		
			output += '<li class="d-flex mb-4 pb-1"><div class="avatar flex-shrink-0 me-3"><span class="avatar-initial rounded bg-label-'+color+'"><i class="'+icon+'"></i></span></div>';
			output += '<div class="d-flex w-100 flex-wrap align-items-center justify-content-between gap-2"><div class="me-2">';
			output += '<h6 class="mb-0">'+data[i].category_name+'</h6>'
			output += '<small class="fw-semibold">'+data[i].totalSales.toLocaleString()+'</small>'
			output += '</div><div class="user-progress">'
			output += '</div></div></li>';
			
			
			
		}
	
		$("#inputTop3").html(output);		

	}
</script>
<style type="text/css">
#myChart {
	width: 95% !important;
	height: 90% !important;
}

#visitorChart {
	margin: 2%;
}

.visitorMain {
	width: 55%;
	margin-top: 5%;
	top: 0px;
}

.smallCard {
	margin-top: 5%;
	display: inline-block;
	height: auto;
	width: 40%;
	margin-left: 2%;
}

.visitorCountCard {
	text-align: center;
	font-size: 36px;
	justify-content: center;
}

.innerCard {
	margin-left: 2%;
	display: inline-block;
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
	margin-top: 5%;
	display: inline-block;
	height: auto;
	width: 100%;
	top: 100%;
	right: 2%;
}

.col-xl-4 {
	width: 100% !important;
}
#myDoughnutChart{
right:2%;


}
.vCardElepsis{
text-overflow: ellipsis;
overflow: hidden;
white-space: nowrap;
  height: 10%;
  width:80%;

}
#inputTop3{
margin-top: 10%;
}
#inputTop3>li{
width: 100%
}
</style>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
	<div class="container-xxl chartContainer">
	<h1>DashBoard</h1>
		<div id="upperDiv">
			<div class="visitorMain">
				<div class="card">
					<div class="d-flex align-items-end row">
						<div id="currentMonthVisitor vCardElepsis" style="padding-left: 5%; padding-top: 5%">
							이번 달의 방문자 수는 지난달보다 <span class="fw-bold visitorDiff"></span>명 <span
								class="moreOrLess"></span>습니다!
						</div>
						<div class="col-sm-7">

							<div class="card-body">


								<div id="visitorChart">
									<canvas id="myChart"></canvas>
								</div>
							</div>
						</div>
						<div class="col-sm-5 text-center text-sm-left">
							<div class="card-body pb-0 px-0 px-md-4">
								<img
									src="${contextPath }/resources/assets/img/illustrations/man-with-laptop-light.png"
									height="140" alt="View Badge User"
									data-app-dark-img="illustrations/man-with-laptop-dark.png"
									data-app-light-img="illustrations/man-with-laptop-light.png">
							</div>
						</div>
					</div>
				</div>
				
			</div>

			<!--    <div id="chart_div"></div> -->


			<!--   <button type="button" onclick="insertVisitor();">방문자 인풋</button> -->

			<div class="smallCard">
				<div>
					<div class="mb-4" style="margin-right: 5%;">
						<div class="card innerCard">
							<div class="card-body cardMargin">
								<div
									class="card-title d-flex align-items-start justify-content-between">
									<div class="avatar flex-shrink-0">

										<img src="${contextPath }/resources/img/chart/today.png"
											alt="chart success" class="rounded">
									</div>

								</div>
								<span class="fw-semibold d-block mb-1 vCardElepsis">오늘의 방문자 수</span>
								<h2 id="todayVisitor" class="visitorCountCard"></h2>
								<small id="diff"></small>
							</div>
						</div>
					</div>

					<div class="mb-4">
						<div class="card innerCard">
							<div class="card-body cardMargin">
								<div
									class="card-title d-flex align-items-start justify-content-between">
									<div class="avatar flex-shrink-0">
										<img src="${contextPath }/resources/img/chart/yesterday.png"
											alt="chart success" class="rounded">
									</div>

								</div>
								<span class="fw-semibold d-block mb-1 vCardElepsis">어제의 방문자 수</span>
								<h2 id="yesterdayVisitor" class="visitorCountCard"></h2>
								<small><i class='text-warning fw-semibold bx bxs-cat'></i></small>
							</div>
						</div>
					</div>

				</div>
				<div id="orderStatistics">
					<div class="col-md-6 col-lg-4 col-xl-4 order-0 mb-4">
						<div class="card h-100">
							<div
								class="card-header d-flex align-items-center justify-content-between pb-0">
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
										<h2 class="mb-2" id="totalSalesSum"><</h2>
										<span>Total Orders</span>
									</div>

									<div id="orderChart">
										<canvas id="myDoughnutChart" width="200vw" height="200vh"></canvas>
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