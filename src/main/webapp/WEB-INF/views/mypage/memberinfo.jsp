<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>My Page</title>
<link rel="icon" href="img/Fevicon.png" type="image/png">
<link rel="stylesheet" href="resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="resources/vendors/linericon/style.css">
<link rel="stylesheet"
	href="resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/vendors/owl-carousel/owl.carousel.min.css">

<link rel="stylesheet" href="resources/css/style.css">
<script src="resources/vendors/jquery/jquery-3.2.1.min.js"></script>
<script src="resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="resources/vendors/skrollr.min.js"></script>
<script src="resources/vendors/owl-carousel/owl.carousel.min.js"></script>
<script src="resources/vendors/nice-select/jquery.nice-select.min.js"></script>
<script src="resources/vendors/jquery.ajaxchimp.min.js"></script>
<script src="resources/vendors/mail-script.js"></script>
<script src="resources/js/main.js"></script>
</head>
<style>
.col-lg-4 {
	margin-left: -18%;
}
</style>


<body>

	<jsp:include page="../userHeader.jsp"></jsp:include>
	<!-- ================ start banner area ================= -->

	<section class="blog-banner-area" id="blog">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>My page</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Blog
								Details</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->
	<!--================Blog Area =================-->
	<section
		class="blog_area single-post-area py-80px section-margin--small">
		<div class="container">
			<div class="row">
				<div class="col-lg-4">
					<div class="blog_right_sidebar">
						<aside class="single_sidebar_widget author_widget">

							<img class="author_img rounded-circle" src="img/blog/author.png"
								alt="">
							<h4>환영합니다</h4>
							<p>${loginMember.userName} 고객님</p>
							<div class="social_icon"></div>
						</aside>

						<aside class="single_sidebar_widget post_category_widget">
							<h4 class="widget_title">Post Catgories</h4>
							<div class="br"></div>
							<ul class="list cat-list">
								<li><a href="mypage/modifyinfo"
									class="d-flex justify-content-between">
										<p>회원 정보 수정</p>

								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>주문 현황</p>
								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>구매 내역</p>

								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>내 게시물 조회</p>
								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>내가 좋아요/신고한 게시물</p>

								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>적립금 조회</p>

								</a></li>
								<li><a href="javascript:withdrawMember()" class="d-flex justify-content-between">
										<p>회원 탈퇴</p>
								</a>
								</li>
							</ul>
							<br> <br>
						</aside>
						<aside class="single_sidebar_widget popular_post_widget">
							<h3 class="widget_title">최근 본 상품</h3>
							<div class="media post_item">
								<img src="img/blog/popular-post/post1.jpg" alt="post">
								<div class="media-body">
									<a href="blog-details.html">
										<h3>Space The Final Frontier</h3>
									</a>
									<p>02 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="img/blog/popular-post/post2.jpg" alt="post">
								<div class="media-body">
									<a href="blog-details.html">
										<h3>The Amazing Hubble</h3>
									</a>
									<p>02 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="img/blog/popular-post/post3.jpg" alt="post">
								<div class="media-body">
									<a href="blog-details.html">
										<h3>Astronomy Or Astrology</h3>
									</a>
									<p>03 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="img/blog/popular-post/post4.jpg" alt="post">
								<div class="media-body">
									<a href="blog-details.html">
										<h3>Asteroids telescope</h3>
									</a>
									<p>01 Hours ago</p>
								</div>
							</div>
							<div class="media post_item">
								<img src="img/blog/popular-post/post2.jpg" alt="post">
								<div class="media-body">
									<a href="blog-details.html">
										<h3>The Amazing Hubble</h3>
									</a>
									<p>02 Hours ago</p>
								</div>
							</div>
							<div class="br"></div>
						</aside>
					</div>
				</div>
				<div class="col-lg-8 posts-list">
					<div class="single-post row">
						<div class="col-lg-3  col-md-3">
							<div class="blog_info text-right">야호</div>
						</div>


					</div>
				</div>
			</div>
		</div>
		<!--================Blog Area =================-->
	</section>
</body>
</html>