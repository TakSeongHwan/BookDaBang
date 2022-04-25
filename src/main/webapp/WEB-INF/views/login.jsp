<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Aroma Shop - Login</title>
	<link rel="icon" href="resources/img/Fevicon.png" type="image/png">
  <link rel="stylesheet" href="resources/vendors/bootstrap/bootstrap.min.css">
  <link rel="stylesheet" href="resources/vendors/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="resources/vendors/themify-icons/themify-icons.css">
	<link rel="stylesheet" href="resources/vendors/linericon/style.css">
  <link rel="stylesheet" href="resources/vendors/owl-carousel/owl.theme.default.min.css">
  <link rel="stylesheet" href="resources/vendors/owl-carousel/owl.carousel.min.css">
  <link rel="stylesheet" href="resources/resources/vendors/nice-select/nice-select.css">
  <link rel="stylesheet" href="resources/vendors/nouislider/nouislider.min.css">
  <link rel="stylesheet" href="resources/css/style.css">
</head>
  <script src="resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="resources/vendors/skrollr.min.js"></script>
  <script src="resources/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="resources/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="resources/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="resources/vendors/mail-script.js"></script>
  <script src="resources/js/main.js"></script>
  <script src= https://developers.kakao.com/sdk/js/kakao.js" ></script>
<body>
<script>

window.onload = function () {
	
	let status = getParameter();	
	
	if (status = "fail" ) {
		let autoLoginBox = document.getElementById('autoLoginBox');
		let incorrect = document.createElement('div');
		incorrect.innerHTML = "아이디 혹은 비밀번호를 다시 확인해주세요!"
		autoLoginBox.appendChild(incorrect);

	}


}

function kakaoLogin() {
		
	
location.href = "https://kauth.kakao.com/oauth/authorize?client_id=95a72bf8adefb359efc8431a1b86586d&redirect_uri=http://localhost:8001/kakaoLogin&response_type=code"


}


function getParameter(param) {
    let returnVal = -1; // 리턴할 값을 저장할 변수
    let url = location.href;
    console.log(url);

    let queryString = url.split("?") [1].split("&");
    console.log(queryString);

    let status= queryString[0].split("=")[1];
    console.log(status);
    
    return status;
}

function displayWarn() {
	if (document.getElementById("autoLogin").checked) {
		alert("자동 로그인 기능은 공공장소에서 사용하지 마세요!");
		return true;
	}
}


</script>
<jsp:include page="userHeader.jsp"></jsp:include>
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Login / Register</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Login/Register</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>New to our website?</h4>
							<p>There are advances being made in science and technology everyday, and a good example of this is the</p>
							
							<a class="button button-account" href="register.html">비회원 주문조회</a>
							<a class="button button-account" href="register.html">회원가입</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner">
					
						<h3>Log in to enter</h3>
						
						<form action="loginSign" method="post">
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디 " onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'">
							</div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'">
							</div>
							<div class="col-md-12 form-group">
								<div class="creat_account" id ="autoLoginBox">
									<input type="checkbox" id="autoLogin" name="autoLogin">
									<label for="f-option2">자동로그인</label>
								</div>
							</div>
							<div class="col-md-12 form-group">
								<button type="submit" class="button button-login w-100" onclick="return displayWarn();">로그인 </button>
								<div>
								 	<button style="background-color: #03c75a; color : #fff; width:300px; border:none; margin-top:10px; height : 45px; line-height : 40px; text-align:left"><img src="/resources/img/etc/btnG_naver.png" width="40"><div style="width:250px; text-align: center; display: inline-block; color:#fff">네이버 로그인</div></button>
								 	
								 	<img src="/resources/img/etc/kakao_login_medium_wide.png" onclick = "kakaoLogin();">

								 </div>
								<label for="forgotPwd"><a href="#">아이디/ 비밀번호 찾기</a></label>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Login Box Area =================-->
<jsp:include page="userFooter.jsp"></jsp:include>

</body>
</html>