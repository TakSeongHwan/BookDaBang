<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>registerMember</title>
<script>
	
</script>
</head>
<style>
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
						<div class="login_box_img" , style="height: 815px;">
							<div class="hover">
								<h4>이미 계정이 있나요?</h4>
								<p>There are advances being made in science and technology
									everyday, and a good example of this is the</p>
								<a class="button button-account" href="login.html">로그인 하기</a>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="login_form_inner register_form_inner">
							<h3>계정 생성</h3>
							<form class="row login_form" action="#/" id="register_form">
								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="userId"
										name="userId" placeholder="UserId"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'UserId'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="password"
										name="password" placeholder="Password"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Password'">
								</div>
								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="confirmPassword"
										name="confirmPassword" placeholder="Confirm Password"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Confirm Password'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="name" name="name"
										placeholder="UserName" onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'UserName'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="nickName"
										name="nickName" placeholder="NickName"
										onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'NickName'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}"
										maxlength="13" class="form-control" id="phoneNum"
										name="phoneNum" placeholder="PhoneNum" onfocus="phoneNum"
										onblur="this.placeholder = 'PhoneNum'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="birth" name="birth"
										placeholder="Birth yyyy-MM-dd" onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Birth yyyy-MM-dd'">
								</div>

								<div class="col-md-12 form-group">
									<input type="text" class="form-control" id="email" name="email"
										placeholder="Email Address" onfocus="this.placeholder = ''"
										onblur="this.placeholder = 'Email Address'">
								</div>

								<div class="form-check"
									style="margin-right: 20px; margin-left: 15px">
									<input class="form-check-input" type="radio"
										name="flexRadioDefault" id="flexRadioDefault1"> <label
										class="form-check-label" for="flexRadioDefault1"> 남자</label>
								</div>
								<div class="form-check" style="margin-letf: 20px">
									<input class="form-check-input" type="radio"
										name="flexRadioDefault" id="flexRadioDefault2"> <label
										class="form-check-label" for="flexRadioDefault2"> 여자 </label>
								</div>

								<div class="col-md-12 form-group">
									<div class="creat_account">
										<input type="checkbox" id="f-option2" name="selector">
										<label for="f-option2">자동로그인</label>
									</div>
								</div>
								<div class="col-md-12 form-group">
									<button type="submit" value="submit"
										class="button button-register w-100">회원가입</button>
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