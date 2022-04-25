<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
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
  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
  <script src="resources/vendors/jquery/jquery-3.2.1.min.js"></script>
  <script src="resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
  <script src="resources/vendors/skrollr.min.js"></script>
  <script src="resources/vendors/owl-carousel/owl.carousel.min.js"></script>
  <script src="resources/vendors/nice-select/jquery.nice-select.min.js"></script>
  <script src="resources/vendors/jquery.ajaxchimp.min.js"></script>
  <script src="resources/vendors/mail-script.js"></script>
  <script src="resources/js/main.js"></script>
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

<%
    String clientId = "_MSPMGBQvc3RTySfYdhS";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://127.0.0.1:8085", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
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

								<label for="forgotPwd"><a href="#">아이디/ 비밀번호 찾기</a></label>
							</div>
						</form>
														<div>
								 	<div id="button_area">
        								<div id="naverIdLogin">
        								<a id="naverIdLogin_loginButton">
        					<button style="background-color: #03c75a; color : #fff; width:300px; border:none; margin-top:10px; height : 45px; text-align:left; border-radius: 5px"><img src="/resources/img/etc/btnG_naver.png" width="40"><div style="width:230px; text-align: center; display: inline-block; font-size: 16px; ">네이버 로그인</div></button>
        								</a>
        								</div>
      								</div>
      								
								 	
								 	<img src="/resources/img/etc/kakao_login_medium_wide.png" style="margin-top: 10px" >
								 	
								 	
								 </div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>








  <script type="text/javascript">
  
  let naverMember = {
		  userId : "",
		  userPwd : "",
		  nickName : "",
		  userEmail  :"",
		  isAdmin  :"",
		  gender  :"",
		  birth  :"",
		  phoneNum  :"",
		  memberWhen  :"",
		  lastLogin  :"",
		  isDraw :"",
		  userName : "",
		  sessionId: ""
  }
  
  const naverLogin = new naver.LoginWithNaverId(
   {
    clientId: "_MSPMGBQvc3RTySfYdhS",
    callbackUrl: "http://localhost:8085/login",
    callbackHandle: true
   
    }
   );
  

    naverLogin.init();
    naverLogin.getLoginStatus(function (status) {
      if (status) {
          const nickName=naverLogin.user.getNickName();
          const age=naverLogin.user.getAge();
          const birthday=naverLogin.user.getBirthday();
          console.log(naverLogin.user);
			insertOutsider(naverLogin.user);
          if(nickName===null||nickName===undefined ){
            alert("별명이 필요합니다. 정보제공을 동의해주세요.");
            naverLogin.reprompt();
            return ;  
         }else{
          setLoginStatus();
         }
	}
    });
    console.log(naverLogin);

    function setLoginStatus(){
    
      const button_area=document.getElementById('button_area');
      button_area.innerHTML='<button id="btn_logout" style="background-color: #03c75a; color : #fff; width:300px; border:none; margin-top:10px; height : 45px; text-align:left; border-radius: 5px"><img src="/resources/img/etc/btnG_naver.png" width="40"><div style="width:230px; text-align: center; display: inline-block; font-size: 16px;">로그아웃</div></button>'
    

      const logout=document.getElementById('btn_logout');
      logout.addEventListener('click',(e)=>{
        naverLogin.logout();
        
		location.replace("http://localhost:8085/login");
      });
    }
    
    
    function insertOutsider(user) {
    	/*  userId = "",
		  userPwd = "",
		  nickName = ""
		  userEmail  ="",
		  isAdmin  ="",
		  gender  ="",
		  birth  ="",
		  phoneNum  ="",
		  memberWhen  ="",
		  lastLogin  ="",
		  isDraw ="",
		  userName = "",
		  sessionId= "" */
    	
    	naverMember.userId =user.id;
    	naverMember.nickName = user.nickname;
    	naverMember.nickEmail = user.email;
    	naverMember.isAdmin = "N"
    	if(user.gender== "M") {
    		naverMember.gender = "male";	
    	} else {
    		naverMember.gender = "female";
    	}
    	naverMember.birth = user.birthyear + "-" +  user.birthday;
    	naverMember.phoneNum = user.mobile;
    	naverMember.userName = user.name;
    	
    	
    	console.log(naverMember);
    }
    
   

  </script>
	<!--================End Login Box Area =================-->
<jsp:include page="userFooter.jsp"></jsp:include>

</body>
</html>