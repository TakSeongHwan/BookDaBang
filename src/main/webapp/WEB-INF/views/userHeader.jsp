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
	console.log("${sessionId}");
	console.log("${ipAddr}");
    $.ajax({
        url :"/userCart/loginCart",
        type: "post",
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
function refund() {
	let userRefund = "${ sessionId}";
	
	if (userRefund != '') {
		// 로그인 했을 때
		console.log("로그인 했슈")
		location.href='${contextPath }/userRefundBoard/board/?sessionId=' + userRefund;
	} else {
		alert("로그인이 되지 않았습니다.")
		location.href='${contextPath }/login.html';
		
	 }
}

	function showSearch() {
		if ($("#mc_embed_signup").length == 0) {
			parseSearch();
		} else {
			$('#mc_embed_signup').slideToggle(200, 'swing', function() {
				$("#searchWord").val("");
	        });
		}
	}
	
	function parseSearch() {
		let output = '<div id="mc_embed_signup" style="padding-bottom: 20px; display:none;"><form class="subscribe-form form-inline">'
				   + '<div class="form-group ml-sm-auto"><input id ="searchWord" class="form-control mb-1 searchArea" type="text"'
				   + ' autocomplete="off" placeholder="Search Book" style="width: 500px;"></div>';
		output += '<button class="button button-subscribe mr-auto mb-1" onclick="return searchBook();">도서 검색</button></form></div>';
					
		$(".main_menu").after(output);
		$("#mc_embed_signup").slideDown(200);
		autoComplete();
	}
	
	function searchBook() {
		let searchWord = $("#searchWord").val();
		if (searchWord == "") {
			alert("검색어를 입력해주세요!");
			return false;
		} else {
			location.href = "${contextPath}/product/list?pageNo=1&searchWord=" + searchWord;
			return false;
		}
	}
	
	function autoComplete() {
		$(document).on("input", "#searchWord", function(){
			let searchWord = $("#searchWord").val();
			if (searchWord != "") {
				let url = "/product/search";
				$.ajax({
					url : url,
					data : {
						searchWord : searchWord
					},
					dataType : "json",
					type : "POST",
					success : function(data) {
						console.log(data);
						if(data.length != 0) {
							parseBox(data);
						} else {
							$("#searchBox").hide();
						}
					}
				});
			}
		});
	}
	
	function parseBox(list) {
		let output = '<table style="width:635px;"><tbody><tr><td style="width=350px; height: 360px; border-right: 1px dotted #ccc;" valign="top">';
		output += '<div id="ac_div_list" class="searchArea" style="display:block; padding-top:3px; padding-bottom:3px;"><ul>';
		
		$.each(list, function(i, e) {
			output += '<li class ="searchList" value="' + i + '"><a href="${contextPath}/product/detail?no=' + e.product_no + '">' + e.title + '</a></li>';
		});
		output += '</ul></div></td><td class="searchArea" width="200" valign="top" id="preview">';
		output += '</td></tr></tbody></table>';
		
		$("#searchBox").html(output);
		parsePreview(list,0);
		$("#searchBox").show();
		
		$(".searchList").on("mouseover", function(){
			let i = $(this).attr("value");
			parsePreview(list,i);
			$(".searchList").css("background-color", "white");
			$(this).css("background-color", "#E9F4FF");
		});
		
		$(".searchList").on("click", function(){
			$("#searchWord").val($(this).text());
		});
		
		$("html").on("click", function(e){
			if(!$(e.target).hasClass('searchArea')){
				$("#searchBox").hide();
			}
		});
	}
	
	function parsePreview(list,i) {		
		let output = '<div style="height: 320px;"><div class="card text-center card-product searchArea" style="width: 195px;">' +
		  			  '<div class="card-product__img" style="max-width:110px; max-height:150px; height:150px; align-self:center; margin-top:45px; margin-bottom: 20px;">';
		output += '<img class="card-img" style="height: 150px;" src="' + list[i].cover + '" alt="">';
		output += '<ul class="card-product__imgOverlay" style="width:150px; position:absolute; left:-24px;">' +
				  '<li><a href="${contextPath}/product/detail?no=' + list[i].product_no + '"><button><i class="ti-search"></i></button></a></li>'
			    + '<li><button class="searchArea" onclick="insertCart(' + list[i].product_no + ')"><i class="ti-shopping-cart searchArea"></i></button></li>'
			    + '<li><button onclick="goOrder(' + list[i].product_no + ')"><i class="ti-money"></i></button></li></ul></div>';
		output += '<div class="card-body" style="padding:5px; margin-top:17px;">' + 
				  '<p style="padding-left:20px; padding-right:20px; max-height:50px; text-overflow:ellipsis; overflow:auto;">'
		  		+ list[i].author + ' | ' + list[i].publisher + '</p>';
		output += '<h4 class="card-product__title" style="margin-bottom:0; padding-top:5px; font-size:18px;">'
		  		+ '<a href="${contextPath}/product/detail?no=' + list[i].product_no + '" style="width: 130px; text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">' 
		  		+ list[i].title + '</a></h4>';
		let price = list[i].sell_price.toString().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		output += '<p class="card-product__price" style="vertical-align:top; font-size:18px;">' + price + '원</p>';
		output += '</div></div></div>';
		$("#preview").html(output);
	}
	
	function insertCart(no){
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : 1
			},
			success : function(data) {
				console.log(data);
				$("#cartBox").show();
				setTimeout(function() {
					$("#cartBox").fadeOut(1500);
				}, 3000);
			},
			error : function(data){
				console.log(data);
			}
		});
	}
	
	function goOrder(no){
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : 1
			},
			success : function(data) {
				console.log(data);
			},
			error : function(data){
				console.log(data);
			}
		});
		location.href = "${contextPath}/order/checkOut"
	}
	
</script>
<style>
	#searchBox {
		width: 635px;
		background-color: white;
    	display: none;
    	position: fixed;
   		top: 150px;
    	left: 35%;
    	z-index: 15000;
    	border: 1px solid #ccc;
	}
	
	.searchList {
		margin: 7px;
	}
	
	.searchList a{
		width: 410px;
    	height: 23px;
    	text-overflow: ellipsis;
    	overflow: hidden;
    	white-space: nowrap;
	}
	
	.searchList:hover {
		cursor: pointer;
	} 
</style>
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
                 <li class="nav-item active"><a class="nav-link" href="${contextPath}/product/list?pageNo=1">도서</a></li>
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
                     aria-expanded="true">Pages</a>
                   <ul class="dropdown-menu">
                        <li class="nav-item"><a class="nav-link" href="${contextPath }/loginPage">Login</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath }/loginPage">Register</a></li>
                        <!-- <li class="nav-item"><a class="nav-link" href="tracking-order.html">Tracking</a></li>  -->
                   </ul>
                 </li>
                 <!-- <li class="nav-item"><a class="nav-link" href="contact.html">Contact</a></li>  -->
  				
  				 <li class="nav-item submenu dropdown">
                   <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">게시판</a>
                   <ul class="dropdown-menu">
                  		<li class="nav-item"><a class="nav-link" href="${contextPath }/notice/listAll">공지사항</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/board/listAllFreeBoard">자유게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/event/allEventList">이벤트게시판</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath}/event/allBestList">베스트 게시글</a></li>
                        <li class="nav-item"><a class="nav-link" onclick="refund();">환불/교환</a></li>
                        <li class="nav-item"><a class="nav-link" href="${contextPath }/cs/">고객센터</a></li>
                        
                        <!-- <li class="nav-item"><a class="nav-link" href="single-blog.html"></a></li>  -->
                   </ul>
            </li>
            </ul>
<!-- 마이페이지 -->
            <ul class="nav-shop">
              <li class="nav-item"><button onclick="showSearch();"><i class="ti-search"></i></button></li>
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
   
	<div id = "searchBox" class="searchArea">
	</div>

	<div id="cartBox" class="searchArea" style="width: 290px; height: 140px; background-color: white; display: none; position: fixed;
    	top: 15%; left: 42.4%; z-index: 15000; border: 1px solid #ccc; text-align: -webkit-center;">
		<h5 class="searchArea" style="margin-top: 28px; margin-bottom: 20px;">장바구니에 담았습니다</h5>
		<button class="button button-login" style="padding-left: 15px; padding-right: 15px;"
		onclick="location.href='${contextPath}/cart/userCart'" >장바구니 가기</button>
		<button class="button button-header searchArea" style="padding: 7px 15px 7px 15px; width: 70px; margin-left: 15px;"
		onclick="$('#cartBox').hide();">닫기</button>
	</div>
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