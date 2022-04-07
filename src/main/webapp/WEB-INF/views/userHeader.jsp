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


<!-- W3SCHOOL -->
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<title>userHeader</title>
</head>

<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    
<script>

$(function() {
    $.ajax({
        url :"/userCart/loginCart",
        type: "post",
        data: {
            userId : "${loginMember.userId}",
            ipaddr : "211.197.18.247"
        },
        success: function(data){
            console.log(data);
        }
    });
    $.ajax({
        url: "/userCart/count",
        type: "GET",
        success: function(data){
            console.log(data);
            $("#cntCart").text(data);
        }
    });
})

function loginOrNot() {
	// 세션 아이디 가져오란다.
	//  로그인을 안했는데 왜 뜨지
	// 로그인을 안해도 세션 ID 뜨는데?
	let loginMember = "${ sessionId}";
	console.log(loginMember);
	
	if (loginMember != '') {
		// 로그인 했을 때
		console.log("로그인 상태")
		location.href='${contextPath }/mypage/?u=' + loginMember;
	} else {
		console.log("로그인이 되지 않았습니다.")
		location.href='${contextPath }/login.html';
		
	 }
}

</script>
<body>
   <!--================ Start Header Menu Area =================-->
   <header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container"> <!-- resources/img/logo.png -->
          <a class="navbar-brand logo_h" href="${contextPath}/"><img src="${contextPath}/resources/LOGO3.png" alt=""></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
                 <li class="nav-item active"><a class="nav-link" href="${contextPath}/">Home</a></li>
                 <li class="nav-item active"><a class="nav-link" href="${contextPath}/product/list">도서</a></li>
                 <li class="nav-item active"><a class="nav-link" href="${contextPath}/notice/listAll">공지사항</a></li>
                 <!--  <li class="nav-item submenu dropdown">
                   <a href="/product/list" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">shop</a>               
                   <ul class="dropdown-menu">
                        <li class="nav-item"><a class="nav-link" href="category.html">Shop Category</a></li>
                        <li class="nav-item"><a class="nav-link" href="single-product.html">Product Details</a></li>
                        <li class="nav-item"><a class="nav-link" href="checkout.html">Product Checkout</a></li>
                        <li class="nav-item"><a class="nav-link" href="confirmation.html">Confirmation</a></li>
                        <li class="nav-item"><a class="nav-link" href="cart.html">Shopping Cart</a></li>
                   </ul>
             </li>-->
                 <li class="nav-item submenu dropdown">
                   <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">Blog</a>
                   <ul class="dropdown-menu">
                        <li class="nav-item"><a class="nav-link" href="blog.html">${loginMember.userId }</a></li>
                        <li class="nav-item"><a class="nav-link" href="single-blog.html">Blog Details</a></li>
                   </ul>
            </li>
            <li class="nav-item submenu dropdown">
                   <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">Pages</a>
                   <ul class="dropdown-menu">
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/login.html">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath }/loginPage">Register</a></li>
                        <!-- <li class="nav-item"><a class="nav-link" href="tracking-order.html">Tracking</a></li>  -->
                   </ul>
                 </li>
                 <!-- <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>  -->
  				
  				 <li class="nav-item submenu dropdown">
                   <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">게시판</a>
                   <ul class="dropdown-menu">
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/board/listAllFreeBoard">자유게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/event/allEventList">이벤트 게시판</a></li>
                        <!-- <li class="nav-item"><a class="nav-link" href="single-blog.html"></a></li>  -->
                   </ul>
            </li>
            </ul>
<!-- 마이페이지 -->
            <ul class="nav-shop">
              <li class="nav-item"><button><i class="ti-search"></i></button></li>
              <li class="nav-item"><form action="${contextPath }/cart/userCart" method="get"><button type="submit"><i class="ti-shopping-cart"></i><span class="nav-shop__circle" id ="cntCart"></span></button></form></li>
              <li class="nav-item"><button type="button" onclick="loginOrNot();"><img src="${contextPath }/resources/img/user_icon.png" style= "width:18px; height:17px;"/></button></li>
              
              <c:choose>
              	
              	<c:when test="${sessionId != null }">
              	<li class="nav-item"><a class="button button-header" href="${contextPath }/logout">Logout</a></li>
              	</c:when>
              	<c:otherwise>
              	<li class="nav-item"><a class="button button-header" href="${contextPath }/loginPage">Login</a></li>
              		
              	</c:otherwise>
              </c:choose>
            </ul>
          </div>
        </div>
      </nav>
    </div>
  </header>
   <!--================ End Header Menu Area =================-->
   

	<!--================ End Header Menu Area =================-->
	
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