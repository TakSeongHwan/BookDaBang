<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" href="${contextPath}/resources/img/Fevicon.png" type="image/png">
<link rel="stylesheet" href="${contextPath}/resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="${contextPath}/resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="${contextPath}/resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="${contextPath}/resources/vendors/nice-select/nice-select.css">
<link rel="stylesheet" href="${contextPath}/resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="${contextPath}/resources/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="${contextPath}/resources/css/style.css">
<title>userFooter</title>

<style>


.footerContent{
margin-right:auto;
margin-left:auto;

}
.quickList{
display: flex;
margin:auto;
}
.quickList>ul{

display: inline-block;
width: 120px;
margin: auto;

}
.quickList>ul>li{
text-align: center;
}
.quickList>ul>li>a>img{

width:50px;
}
.footer_title{

text-align: center;

}
.quickManuText{
color: #fff;
text-align: center; 
font-weight: bolder;
}

.contactUsIcon>img{
width: 15px;
text-align: center; 
}
</style>
</head>
<body>

	<!--================ Start footer Area  =================-->	
	<footer class="footer">
		<div class="footer-area">
			<div class="container">
				<div class="row section_gap">
					<!-- 
					<div class="col-lg-3 col-md-6 col-sm-6">
				
						<div class="single-footer-widget tp_widgets">
							<h4 class="footer_title large_title">Our Mission</h4>
							<p>
								So seed seed green that winged cattle in. Gathering thing made fly you're no 
								divided deep moved us lan Gathering thing us land years living.
							</p>
							<p>
								So seed seed green that winged cattle in. Gathering thing made fly you're no divided deep moved 
							</p>
							
						</div>
						
					</div>
					 -->
					<div class="col-lg-3 col-md-6 col-sm-6 footerContent">
						<div class="single-footer-widget tp_widgets">
							<h2 class="footer_title">Quick Links</h2>
							<div class="quickList">
							<ul class="list">
							<li><a href="${contextPath }/">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickHome.png"/>
							<div class="quickManuText">홈</div></a></li>
							<li><a href="${contextPath }/product/list">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickProduct.png"/>
							<div class="quickManuText">상품페이지</div></a></li>
							<li><a href="${contextPath }/board/listAllFreeBoard">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickFreeboard.png"/>
							<div class="quickManuText">자유게시판</div></a></li>
							<li><a href="${contextPath }/event/allEventList">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickEvent.png"/>
							<div class="quickManuText">이벤트게시판</div></a></li>
								
							</ul>
					
							<ul class="list">
							<li>	
							<c:choose>
								<c:when test="${loginUser != null }">
									<a href="${contextPath }/logout">
									<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickLogin.png"/>
									<div class="quickManuText">로그아웃</div></a>
								</c:when>
								<c:otherwise>
									<a href="${contextPath }/login">
									<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickLogin.png"/>
									<div class="quickManuText">로그인</div></a>
								</c:otherwise>
							</c:choose>
							</li>
							<c:choose>
								<c:when test="${loginUser != null }">
									<li><a href="${contextPath }/mypage/">
									<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickmyPage.png"/>
									<div class="quickManuText">마이페이지</div></a></li>
								</c:when>
								<c:otherwise>
									<li><a href="${contextPath }/member/registerMember">
									<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickRegister.png"/>
									<div class="quickManuText">회원가입</div></a></li>
								
								</c:otherwise>
							</c:choose>

							<li><a href="${contextPath }/cs/">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickCS.png"/>
							<div class="quickManuText">고객센터</div></a></li>
							<li><a href="${contextPath }/notice/listAll?pageNo=1">
							<img src="${contextPath }/resources/img/footerQuickMenu/footerQuickNotice.png"/>
							<div class="quickManuText">공지사항</div></a></li>
							</ul>
							</div>
						</div>
					</div>
					<!-- 
					<div class="col-lg-2 col-md-6 col-sm-6">
						<div class="single-footer-widget instafeed">
							<h4 class="footer_title">Gallery</h4>
							<ul class="list instafeed d-flex flex-wrap">
								<li><img src="${contextPath}/resources/img/gallery/r1.jpg" alt=""></li>
								<li><img src="${contextPath}/resources/img/gallery/r2.jpg" alt=""></li>
								<li><img src="${contextPath}/resources/img/gallery/r3.jpg" alt=""></li>
								<li><img src="${contextPath}/resources/img/gallery/r5.jpg" alt=""></li>
								<li><img src="${contextPath}/resources/img/gallery/r7.jpg" alt=""></li>
								<li><img src="${contextPath}/resources/img/gallery/r8.jpg" alt=""></li>
							</ul>
						</div>
					</div>
					 -->

					<div class="col-lg-3 col-md-6 col-sm-6 footerContent">
						<div class="single-footer-widget tp_widgets">
						
							<h2 class="footer_title">Contact Us</h2>
							<div class="ml-40">
								<p class="sm-head">
									<span class="fa fa-location-arrow"></span>
									Goott Academy </br>
									&nbsp;6th ClassRoom
								</p>
								<p>Juho Tower 3F,</br>33 Siheung-daero 163-gil,</br>Guro-gu, Seoul</p>
	
								<p class="sm-head">
									<span class="fa fa-phone"></span>
									Phone Number
								</p>
								<p>
								+82 02-837-9922
								</p>
	
								<p class="sm-head">
									<span class="fa fa-envelope"></span>
									Email
								</p>
								<p style="font-size: 14px">
								강명진 ppiyace@gmail.com <br/>
							  	김한나 hanna010510@gmail.com <br/>
								이보련 leebo6198@gmail.com <br/>
								이정선 jsjs21302@gmail.com <br/>
								이최상 chltkd10@gmail.com <br/>
								이한솔 lhshl246@gmail.com <br/>
								최윤호 krke98ss@gmail.com <br/>
								탁성환 xkrtjdghks33@naver.com
							
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="footer-bottom">
			<div class="container">
				<div class="row d-flex">
					<p class="col-lg-12 footer-text text-center">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
				</div>
			</div>
		</div>
	</footer>
	<!--================ End footer Area  =================-->
  <script src="${contextPath}/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="${contextPath}/resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="${contextPath}/resources/vendors/skrollr.min.js"></script>
  <script src="${contextPath}/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="${contextPath}/resources/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="${contextPath}/resources/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="${contextPath}/resources/vendors/mail-script.js"></script>
  <script src="${contextPath}/resources/js/main.js"></script>
</body>
</html>