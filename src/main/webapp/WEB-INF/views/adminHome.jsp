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
		getTodayVisitor();
		getYesterdayVisitor();
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
					
					if(i+1 < data.length){
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
						}else{
							$("#currentMonthVisitor").html("이번달의 방문자 수는 지난달과 같습니다")
						}
						
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

		console.log(labels);

		const data = {
			labels : labels,
			datasets : [ {
				label : '월별 방문자수',
				backgroundColor : '#03c3ec',
				borderColor : '#03c3ec',
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
			type:"GET",
			success : function(data) {
				console.log(data);
				$("#todayVisitor").text(data.todayVisitor);
			}

		});
	}
	function getYesterdayVisitor() {
		$.ajax({
			url : "${contextPath}/chart/getYesterdayVisitor",
			dataType : "json",
			type:"GET",
			success : function(data) {
				console.log(data);
				$("#yesterdayVisitor").text(data.yesterdayVisitor);
				let diff = data.yesterdayVisitor - $("#todayVisitor").html();
				let output = "";
				console.log(diff);
				if(diff > 0){
					output = "<i class='text-danger fw-semibold bx bx-down-arrow-alt'>"+diff+"</i>"
				}else if(diff < 0){
					output = "<i class='text-success fw-semibold bx bx-up-arrow-alt'>"+diff+"</i>"
				}else{
					output = "<i class='text-secondary fw-semibold bx bx-minus'>"+diff+"</i>"
				}
				$("#diff").html(output);
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
	width:55%;
	display: inline-block;
	margin-top: 5%;
	position: absolute;
top:0px;
}

.smallCard {
margin-top: 5%;
	display: inline-block;
	height: auto;
	width: 40%;
position: absolute;
top:0px;
right: 2%;
}
.visitorCountCard{
text-align: center;
font-size: 36px;
justify-content: center;
}
.innerCard{
margin-left : 2%;
display: inline-block;
}
.cardMargin{
margin-top:15px;
}
.mb-4{
margin-right:auto;
margin-right:left;
width: 45%;
display: inline-block;
}
#upperDiv{
width:100%;
height: auto;
position: relative;
}
#currentMonthVisitor{
width: 100%;
margin: 5%;
}
</style>
</head>

<body>
	<jsp:include page="managerHeader.jsp"></jsp:include>
	<div class="container-xxl chartContainer">
	<div id="upperDiv">
		<div class="visitorMain" >
			<div class="card">
				<div class="d-flex align-items-end row">
					<p id="currentMonthVisitor">
								이번 달의 방문자 수는 지난달보다 <span class="fw-bold visitorDiff"></span>명 <span
									class="moreOrLess"></span>습니다!
							</p>
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
	
			<div class="smallCard" >
				<div class="mb-4 ">
                      <div class="card innerCard">
                        <div class="card-body cardMargin">
                  <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                            
                              <img src="${contextPath }/resources/img/chart/today.png" alt="chart success" class="rounded">
                            </div>
         
                          </div>
                          <span class="fw-semibold d-block mb-1">오늘의 방문자 수</span>
                          	<h2 id="todayVisitor" class="visitorCountCard"></h2>
                         <small id="diff"></small>
                        </div>
                      </div>
                    </div>
				
				<div class="mb-4">
                      <div class="card innerCard">
                        <div class="card-body cardMargin">
                   <div class="card-title d-flex align-items-start justify-content-between">
                            <div class="avatar flex-shrink-0">
                              <img src="${contextPath }/resources/img/chart/yesterday.png" alt="chart success" class="rounded">
                            </div>
         
                          </div>
                          <span class="fw-semibold d-block mb-1 ">어제의 방문자 수</span>
                          	<h2 id="yesterdayVisitor" class="visitorCountCard"></h2>
                    		<small><i class='text-warning fw-semibold bx bxs-invader'></i></small>
                        </div>
                      </div>
                    </div>

			</div>
				
	<div id="midDiv">
	
	</div>
		</div>
	</div>

	
	<jsp:include page="managerFooter.jsp"></jsp:include>
</body>
</html>