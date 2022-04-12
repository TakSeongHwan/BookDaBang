<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<script>
	
</script>
<style>


.prodImg{
position: absolute;
bottom: 0px;
}
.card-product__img{
height: 500px;
object-fit: cover;
}

</style>

<body>
	<jsp:include page="userHeader.jsp"></jsp:include>


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
				</div>
			</div>
		</div>

		<div class="section-intro" style="margin-top: 100px;">
          <h2>Best Sellers</h2>
        </div>
		<div class="owl-carousel owl-theme owl-loaded owl-drag"
			id="bestSellerCarousel" >

			<div class="owl-stage-outer">
				<div class="owl-stage"
					style="transform: translate3d(-2850px, 0px, 0px); width: 4560px;">

					<c:forEach var="prod" items="${product }">
						<div class="owl-item active"
							style=" margin-right: 30px;">
							<div class="card text-center card-product">
								<div class="card-product__img" >

									<img class="img-fluid prodImg" src="${prod.cover}"/>
									
								</div>
								<div class="card-body">
									<h4 class="card-product__title">
										<a href='${contextPath }/product/detail?no=${prod.product_no }'>${prod.title }</a>
									</h4>
									<p class="card-product__price">${prod.sell_price }</p>
								</div>
							</div>
						</div>





					</c:forEach>




				</div>
			</div>
		</div>

	</div>

	<jsp:include page="userFooter.jsp"></jsp:include>
</body>
</html>