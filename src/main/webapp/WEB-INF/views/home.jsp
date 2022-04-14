
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BookDaBang</title>


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>



<script>
let width = window.innerWidth;
let items = 8;
	$(function() {
	
		drawCarousel();
		window.addEventListener('resize', function() {
			resizeWidth(); 
			console.log(width);
			if(width <= 1200 && width > 800){
				items = 6;				
			}
			if(width <= 800 && width >400){
				items = 4; 
			}
			if(width <= 400 && width > 200){
				items = 2;
			}
			if(width <= 200){
				items = 1;
			}
			console.log(items);
			drawCarousel();
	
			
			});



		
		
	});
	function drawCarousel(){
		let owl = $('#bestSellerCarousel');
		let owl2 = $('#randomCarousel');
		let data = {
				items : items,
				loop : true,
				margin : 20,
				autoplay : true,
				autoplayTimeout : 2000,
				autoplayHoverPause : true
			};
		
		
		//owl.trigger('replace.owl.carousel',html).trigger('refresh.owl.carousel');
		//owl2.trigger('replace.owl.carousel',html).trigger('refresh.owl.carousel');
	
		console.log("왜 안바뀌어")
		owl.owlCarousel(data);
		
		owl2.owlCarousel(data);
		
		
		
	}
	function resizeWidth(){
		
		width = window.innerWidth;
	}
</script>
<style>
.owl-stage-outer{
height: 250px;
margin-top:20px;
}
.card-product__img>img{
max-width:auto;
min-width:auto;
max-height:150px;
min-height: 150px;


}
.owl-item{
	height: 150px;

}

.card-product__title>a{
text-overflow: ellipsis;
overflow: hidden;
white-space: nowrap;
  height: 25px;
  width:130px;
text-align: center;
}
.my-card-body{
padding-top: 10px;
}
.owl-dots{
visibility: hidden !important;
}


</style>


</head>


<body>
	<jsp:include page="userHeader.jsp"></jsp:include>
	<section class="hero-banner">
	<div class="container">
		<div class="row no-gutters align-items-center pt-60px"
			style="matgin-bottom: 10px;">
			<div class="col-5 d-none d-sm-block">
				<div class="hero-banner__img">
					<img class="img-fluid"
						src="${contextPath}/resources/img/bookwithcoffee.jpg">
				</div>
			</div>
			<div class="col-sm-7 col-lg-6 offset-lg-1 pl-4 pl-md-5 pl-lg-0">
				<div class="hero-banner__content">
					<h4>Team Project</h4>
					<h1>BookDaBang</h1>
					<h5>2022.11 - 2022.05. goott Academy 6th classroom.</h5>
					<a class="button button-hero" href="${contextPath}/product/list">See More</a>
				</div>
			</div>
		</div>
		</div>
</section>
	<section class="section">
		<div class="container">
		<div class="section-intro" style="margin-top: 100px;">
			<h2>Best Sellers</h2>
		</div>
		
		
		<div class="owl-carousel owl-theme owl-loaded owl-drag"
			id="bestSellerCarousel">
			<div class="owl-stage-outer">
				<div class="owl-stage"
					style="transform: translate3d(-2850px, 0px, 0px); width: 4560px;">

					<c:forEach var="prod" items="${product }">
						<div class="owl-item active" style="margin-right: 30px;">
							<div class="card text-center card-product">
								<div class="card-product__img">

									<img class="img-fluid prodImg" src="${prod.cover}" />

								</div>
								<div class="my-card-body">
									<div class="card-product__title">
										<a
											href='${contextPath }/product/detail?no=${prod.product_no }'>${prod.title }</a>
									</div>
									<div class="card-product__price"><fmt:formatNumber value="${prod.sell_price }" pattern="#,###" />원</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
	</div>
		<div class="container">
		<div class="section-intro" style="margin-top: 50px;">
			<h2>Recommendation</h2>
		</div>
		<div class="owl-carousel owl-theme owl-loaded owl-drag"
			id="randomCarousel">
			<div class="owl-stage-outer">
				<div class="owl-stage"
					style="transform: translate3d(-2850px, 0px, 0px); width: 4560px;">

					<c:forEach var="random" items="${randomBook }">
						<div class="owl-item active" style="margin-right: 30px;">
							<div class="card text-center card-product">
								<div class="card-product__img">

									<img class="img-fluid prodImg" src="${random.cover}" />

								</div>
								<div class="my-card-body">
									<div class="card-product__title">
										<a
											href='${contextPath }/product/detail?no=${random.product_no }'>${random.title }</a>
									</div>
									<div class="card-product__price"><fmt:formatNumber value="${random.sell_price }" pattern="#,###" />원</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		</div>
		</section>
<%--
<%
    String clientId = "_MSPMGBQvc3RTySfYdhS";//애플리케이션 클라이언트 아이디값";
    String clientSecret = "shRTidyY12";//애플리케이션 클라이언트 시크릿값";
    String code = request.getParameter("code");
    String state = request.getParameter("state");
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8085", "UTF-8");
    String apiURL;
    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    apiURL += "client_id=" + clientId;
    apiURL += "&client_secret=" + clientSecret;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&code=" + code;
    apiURL += "&state=" + state;
    String access_token = "";
    String refresh_token = "";
    System.out.println("apiURL="+apiURL);
    try {
      URL url = new URL(apiURL);
      HttpURLConnection con = (HttpURLConnection)url.openConnection();
      con.setRequestMethod("GET");
      int responseCode = con.getResponseCode();
      BufferedReader br;
      System.out.print("responseCode="+responseCode);
      if(responseCode==200) { // 정상 호출
        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
      } else {  // 에러 발생
        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
      }
      String inputLine;
      StringBuffer res = new StringBuffer();
      while ((inputLine = br.readLine()) != null) {
        res.append(inputLine);
      }
      br.close();
      if(responseCode==200) {
        out.println(res.toString());
      }
    } catch (Exception e) {
      System.out.println(e);
    }
  %>
   --%>
	<jsp:include page="userFooter.jsp"></jsp:include>



</body>
</html>