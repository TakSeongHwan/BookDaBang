<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="icon" type="image/x-icon" href="${contextPath}/resources/assets/img/favicon/favicon.ico" />
<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
   rel="stylesheet" />
<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/fonts/boxicons.css" />
<!-- Core CSS -->
<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/css/core.css"
   class="template-customizer-core-css" />
<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/css/theme-default.css"
   class="template-customizer-theme-css" />
<link rel="stylesheet" href="${contextPath}/resources/assets/css/demo.css" />
<!-- Vendors CSS -->
<link rel="stylesheet"
   href="${contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet"
   href="${contextPath}/resources/assets/vendor/libs/apex-charts/apex-charts.css" />
<!-- Page CSS -->
<!-- Helpers -->
<script src="${contextPath}/resources/assets/vendor/js/helpers.js"></script>
<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="${contextPath}/resources/assets/js/config.js"></script>

<meta charset="UTF-8">
<title>ISBN 상품 수정</title>
<script>
	window.onload = function() {
		
		$(".searchBtn").click(function(){
			
			let searchText = $(".searchText").val();
			console.log(searchText);
			
			$(".cotatiner").fadeOut(500);
			
		setTimeout(function() {
			
			$(".container3").html("페이지로 이동합니다");
			$(".container3").fadeIn(500);
		},500);
			
			setTimeout(function() {
				$(".container2").animate({
					width : '100%'
				});
			}, 1500);
			
			setTimeout(function() {
			location.href="/prodManager/prodUpdate?prodNo="+searchText;
			
			}, 2500);
			
		});
		
		
		
			
		
		
	}
</script>
<style>
body{width :100%}
</style>
</head>
<body>

<div class="container2" style="height:100%; width:0px; background-color : #B4C6F7; position: absolute; z-index:999;">

</div>

<div style="height : 300px"></div>
<div class="cotatiner">
<div style ="text-align: center; font-size : 36px;"  >
	ISBN으로 수정하실 상품을 검색하세요!
</div>
<div style ="width:650px; margin:0 auto; margin-top:30px" >

<input type="text" class="form-control searchText" style ="width:560px; height : 50px; display: inline-block;">
<button type="button" class="btn btn-primary searchBtn"  style="height :50px; margin-bottom: 3px">검색</button>
</div>
</div>
<div class="container3" style ="width:420px; margin:0 auto; margin-top:30px; font-size : 42px; display: none;">페이지로 이동합니다</div>

  <!-- build:js assets/vendor/js/core.js -->
    <script src="${contextPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${contextPath}/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${contextPath}/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${contextPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${contextPath}/resources/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="${contextPath}/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="${contextPath}/resources/assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="${contextPath}/resources/assets/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>