<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	});
	function insertVisitor() {

		/* 	let ip = (Math.floor(Math.random() * 255) + 1)+"."+(Math.floor(Math.random() * 255))+"."+(Math.floor(Math.random() * 255))+"."+(Math.floor(Math.random() * 255));
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
		
		 }); */

	}

	function drowLinearChart() {
		$.ajax({
			url : "${contextPath}/chart/getVisitorInfo",
			dataType : "json",
			async : false,
			success : function(data) {
				visitorChart(data);
				console.log(data);
				for (let i = 0; i < data.length; i++) {

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
					}
				}

			}

		});
	}

	function visitorChart(tableData) {

		console.log(tableData);

		const labels = [];
		let values = [];
		$.each(tableData, function(i, e) {

			labels.push(e.monthSort);
			values.push(e.visitor);

		});

		console.log(labels)

		const data = {
			labels : labels,
			datasets : [ {
				label : '월별 방문자수',
				backgroundColor : 'rgb(255, 102, 102)',
				borderColor : 'rgb(255, 102, 102)',
				data : values,

			} ]
		};

		const config = {

		};

		const myChart = new Chart(document.getElementById('myChart'), {
			type : 'line',
			data : data,
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
			async : false,
			success : function(data) {
				console.log(data);

			}

		});
	}
</script>
<style type="text/css">
#myChart {
	width: 350px !important;
	height: 200px !important;
}

#visitorChart {
	margin: 2%;
}

.visitorMain {
	display: inline-block;
}

.visitorToday {
	width: 33% !important;
	display: inline-block;
}
</style>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
	<div class="chartContainer">

		<div class="col-lg-8 mb-4 order-0 visitorMain">
			<div class="card">
				<div class="d-flex align-items-end row">
					<div class="col-sm-7">
						<div class="card-body">

							<p class="mb-4">
								이달의 방문자 수는 지난달보다 <span class="fw-bold visitorDiff"></span>명 <span
									class="moreOrLess"></span>습니다!
							</p>
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
		<div class="col-12 mb-4 visitorToday">
			<div class="card">
				<div class="card-body">
					<div
						class="d-flex justify-content-between flex-sm-row flex-column gap-3"
						style="position: relative;">
						<div
							class="d-flex flex-sm-column flex-row align-items-start justify-content-between">
							<div class="card-title">
								<h5 class="text-nowrap mb-2">Today's Visitor</h5>
								<span class="badge bg-label-warning rounded-pill today"></span>
							</div>
						
					</div>
					<div></div>
				</div>
			</div>
		</div>


		<!--    <div id="chart_div"></div> -->


		<!--   <button type="button" onclick="insertVisitor();">방문자 인풋</button> -->
	</div>

	</div>
	<jsp:include page="managerFooter.jsp"></jsp:include>
</body>
</html>