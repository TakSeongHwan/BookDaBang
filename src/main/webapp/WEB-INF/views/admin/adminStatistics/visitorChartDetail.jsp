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
		console.log(startDate);
		console.log(endDate);
		if (startDate <= endDate) {
			$("#validDate").empty();
			console.log("시작일이 종료일보다 작다")

			let sendData = JSON.stringify({
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
				},
				error : function(e) {
					console.log(e.responseText);
				}

			});
		} else {
			$("#validDate").empty();
			let output = '<div class="alert alert-danger alert-dismissible" role="alert">시작일은 종료일보다 늦을 수 없습니다.<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
			$("#validDate").html(output);
		}
	}
</script>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
	<div class="container mt-3">
		<h1 style="margin-top: 5%;">방문자 통계 상세조회</h1>

		<div style="display: flex; margin-top: 5%;">
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
	</div>
	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>