<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>registerMember</title>
<script>
	let userPwdCheck = false;
	let emailCheck = false;
	let idCheck = false;
	let nickCheck = false;
	// 비밀번호 확인
	$(function() {
		$("#pwdOK").blur(function() {
			let userPwd = $("#userPwd").val();
			let userPwdOK = $("#pwdOK").val();

			if (userPwd == userPwdOK) {
				userPwdCheck = true;
				outputErrMsg($("#pwdOK"), "비밀번호가 맞습니다")
			} else {
				outputErrMsg($("#pwdOK"), "비밀번호가 서로 맞지 않습니다")
			}
		})
	});
	// 아이디 중복확인
	function userIdCheck(value, dataName) {
		let userId = $("#userId").val(); // id가 userId(text값)의 값을 가져온다
		let url = "/member/userIdCheck";
		if(userId != ""){
			$.ajax({
				url : url, // ajax와 통신할곳
				dataType : "text", // 수신 받을 데이터의 타입
				type : "POST",
				data : {
					userId : userId
				},
				success : function(data) {  // 통신 성공시 실행될 콜백 함수
					console.log(data);
					if (data == "success") {
						idCheck = true;
						alert("사용할수 있는 ID입니다")

					} else{
						alert("중복되는 ID입니다")

					}
				}
		});
		}else{
			alert("아이디를 입력해주세요");
		}
	}
	// 닉네임 중복확인
	function nickNameCheck() {
		let nickName = $("#nickName").val();
		let url = "/member/nickNameCheck"
		if(nickName != ""){
			$.ajax({
				url : url,
				dataType : "text",
				type : "POST",
				data : {
					nickName : nickName
				},
				success : function(data) {
					console.log(data)
					if (data == "success") {
						nickCheck = true;
						alert("사용할수 있는 닉네임 입니다")

					} else {
						alert("중복되는 닉네임 입니다")

					}

				}
			});
		} else {
			alert("닉네임을 입력하세요")
		}
		
	}
	// 이메일 인증코드 받기
	function insertEmailCode() {
		let userEmail = $("#userEmail").val();
		let url = "/member/sendCode"

		$.ajax({
			url : url,
			dataType : "JSON",
			type : "POST",
			data : {
				userEmail : userEmail
			},
			success : function(data) {
				if (data.status == "success") {
					emailCheck = true;
					alert("인증번호 전송 성공")

				} else {
					alert("인증번호 전송 실패")

				}
			}
		});
	}
	// 이메일 인증 부분
	function ConfirmCode() {
		let confirmCode = $("#emailConfirm").val();
		let url = "/member/confirmEmailCode"
		$.ajax({
			url : url,
			dataType : "json",
			type : "POST",
			data : {
				confirmCode : confirmCode
			},
			success : function(data) {
				if (data.status == "success") {
					emailCheck = true;
					alert("성공")
				} else if (data.status == "fail") {
					alert("실패")
				}
			}
		});
	}
	function validate() {
		if (idCheck && nickCheck && userPwdCheck && emailCheck) {
			$("#register_form").submit();
			return true;
		} else {
			alert("회원가입실패");
			return false;
		}

	}

	function outputErrMsg(obj, errMsg) {
		$("#errorMsg").remove(); // 메세지 삭제
		$("<div id='errorMsg'>").insertAfter(obj);
		$("#errorMsg").html(errMsg);// 표기
		$("#errorMsg").css("color", "red");
	}
</script>
</head>
<style>
.col-md-12 form-group {
	width: 350px;
	height: 40px;
}

input[type="text"] {
	width: 70%;
	height: 100%;
	border: none;
	font-size: 1em;
	padding-left: 5px;
	font-style: oblique;
	display: inline;
	outline: none;
	box-sizing: border-box;
	color: black;
}

input[type=button] {
	width: 30%;
	height: 100%;
	background-color: lightgray;
	border: none;
	background-color: white;
	font-size: 1em;
	color: #042AaC;
	outline: none;
	display: inline;
	margin-left: -10px;
	box-sizing: border-box;
}

input[type=button]:hover {
	background-color: lightgray;
}
</style>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container">

		<!-- ================ start banner area ================= -->
		<section class="blog-banner-area" id="category"
			style="width: 1040px; margin: 0px auto;">
			<div class="container h-100">
				<div class="blog-banner">
					<div class="text-center">
						<h1>Register</h1>
						<nav aria-label="breadcrumb" class="banner-breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Register</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<!-- ================ end banner area ================= -->

		<!--================Login Box Area =================-->
		<section class="login_box_area section-margin" , style="margin: 20px;">
			<div class="container">
				<div class="row">
					<div class="col-lg-6">
						<div class="login_box_img" , style="height: 915px;">
							<div class="hover">
								<h4>이미 계정이 있나요?</h4>
								<p>There are advances being made in science and technology
									everyday, and a good example of this is the</p>
								<a class="button button-account" href="${contextPath }/loginPage">로그인 하기</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="login_form_inner register_form_inner">
							<h3>계정 생성</h3>
							<form class="row login_form" action="/member/insertMember"
								id="register_form" method="post">
								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="userId"
										name="userId" placeholder="UserId"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'UserId'"> <input
										type="button" name="userId" value="중복확인"
										onclick="userIdCheck();">
								</div>

								<div class="col-md-12 form-group">
									<input type="password" class="form-control" id="userPwd"
										name="userPwd" placeholder="Password"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Password'">
								</div>
								<div class="col-md-12 form-group">
									<input type="password" class="form-control"
										placeholder="Confirm Password" onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Confirm Password'" id="pwdOK">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control " style="width: 100%"
										id="userName" name="userName" placeholder="UserName"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'UserName'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control " id="nickName"
										name="nickName" placeholder="NickName"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'NickName'"> <input
										type="button" name="nickName" value="중복확인"
										onclick="nickNameCheck();">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}"
										maxlength="13" class="form-control" id="phoneNum"
										name="phoneNum" placeholder="PhoneNum" onfocus="phoneNum"
										onblur="this.placeholder = 'PhoneNum'" style="width: 100%">
								</div>

								<div class="col-md-12 form-group">
									<input type="date" class="form-control" id="birth" name="birth"
										placeholder="Birth yyyy-MM-dd" onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Birth yyyy-MM-dd'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="userEmail"
										name="userEmail" placeholder="Email Address"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Email Address'"> <input
										type="button" name="emailCode" value="인증코드받기" id="sendCode"
										onclick="insertEmailCode();">
									<div>
										<input type="text" class="form-control" id="emailConfirm"
											placeholder="발송된 코드를 확인하여 입력하기"> <input type="button"
											onclick="ConfirmCode();" id="confirmCode" value="코드 인증">
									</div>
								</div>
								<div class="col-md-12 form-group">
									<input type="text" class="form-control " style="width: 100%"
										id="recommend" name="recommend" placeholder="Recommendation"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Recommendation'">
								</div>

								<div class="form-check">
									<span style="margin-right: 30px;">
										<input class="form-check-input" type="radio" name="gender"
											id="gender" value="male"> <label
											class="form-check-label" for="flexRadioDefault1"> 남자</label>
									</span>
									<span style="margin-left: 20px">
										<input class="form-check-input" type="radio" name="gender"
											id="gender" value="female"> <label
											class="form-check-label" for="flexRadioDefault2"> 여자
										</label>
									</span>
								</div>

								<div class="col-md-12 form-group" style="margin-top: 30px">
									<button class="button button-register w-100" type="button"
										onclick="validate();">회원가입</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--================End Login Box Area =================-->
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>