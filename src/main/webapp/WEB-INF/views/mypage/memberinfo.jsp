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
<title>My Page</title>

<link rel="icon" href="../resources/img/Fevicon.png" type="image/png">
<link rel="stylesheet"
	href="../resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet"
	href="../resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet"
	href="../resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="../resources/vendors/linericon/style.css">
<link rel="stylesheet"
	href="../resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
	href="../resources/vendors/owl-carousel/owl.carousel.min.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="../resources/css/style.css">
<script src="../resources/vendors/jquery/jquery-3.2.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="../resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="../resources/vendors/skrollr.min.js"></script>
<script src="../resources/vendors/owl-carousel/owl.carousel.min.js"></script>
<script src="../resources/vendors/nice-select/jquery.nice-select.min.js"></script>
<script src="../resources/vendors/jquery.ajaxchimp.min.js"></script>
<script src="../resources/vendors/mail-script.js"></script>
<script src="../resources/js/main.js"></script>
</head>
<script>

	function loginOrNot() {
		// 세션 아이디 가져오란다.
		//  로그인을 안했는데 왜 뜨지
		// 로그인을 안해도 세션 ID 뜨는데?
		let loginMember = "${ sessionId}";
		console.log(loginMember);

		if (loginMember != '') {
			// 로그인 했을 때
			console.log("로그인 했슈")
			//location.href='/ljs/mypage/';
		} else {
			console.log("로그인 안했슈")
			//location.href='/ljs/returnPrePage';

		}
	}

	function withdrawMember() {

		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라

		let url = "withdrawMember.do";

		$.ajax({
					url : url,
					dataType : "text",
					type : "POST",
					data : {
						ses : ses
					},
					success : function(data) { // 통신 성공시 실행될 콜백 함수
						console.log(data)
						if (data == 1) {
							console
									.log(document.getElementById('confirm').innerHTML);
							document.getElementById('confirm').innerHTML = "<p>탈퇴가 완료되었습니다. 삭제 후 30일 이내에 복구 신청시, 계정을 다시 사용하실 수 있습니다.</p>";
							$(".yesButton").remove();

							// 예 / 아니오를 모달창  확인 버튼 하나로 바꾸기.
							document.getElementsByClassName('buttonCon')[0].innerHTML = "확인"
						}

					}
				});
	}
	
	function pointHistory() {
		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라
		let url = "${ contextPath}/mypage/viewPoint.do";	
		$.ajax({
			url : url,
			dataType : "json",
			//contentType :"application/json; charset=utf-8", 
			type : "GET",
			data : {
				ses : ses
			},
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".contentsBox").empty();
				let output = '<h3> 포인트 적립 내역</h3><div class = "table-responsive"><table class="table"><thead><tr><th>Point</th><th>적립 사유</th><th>적립 일시</th></tr></thead><tbody>';
				
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td>'+ e.point + '</td><td>' + e.pointWhy + '</td><td>' + e.pointWhen + '</td></tr>'
				})
				output += '</tbody></table></div>'
				$(".contentsBox").html(output);
				}, error : function() {
			}
		});		
	}
	
	function confirmModifyPwd() {
		
		let pwd1 = $("#pwd1").val();
		let pwd2 =$("#pwd2").val();
		let ses = "${ sessionId}"
		let url = "${ contextPath}/mypage/changePassword.do"
		console.log(url);
		console.log(ses);
		if (pwd1 == pwd2) {
			console.log("비밀번호 일치함 ajax로 통신")
			$.ajax({
				url : url,
				dataType : "json",
				//contentType :"application/json; charset=utf-8", 
				type : "POST",
				data : {
					ses : ses,
					pwd1 : pwd1
				},
				success : function(data) { // 통신 성공시 실행될 콜백 함수
					if (data == 1) {
						$("#yesButton").remove();
						$(".buttonCon").text('확인');
						
						$(".modal-footer").prepend("<p style = 'text-align : left;'>비밀번호 변경이 완료되었습니다.</p>");
			
					} else {
						console.log("백단에서 뭔가가 잘못되었다.")
					}
				}
			});	
		} else {
			let p = document.createElement("p")
			p.innerText = "변경할 비밀번호와 확인이 다릅니다. 확인해주세요."
			$("#pwdModi").append(p);
		}
	} 
	
	function confirmPwd(e) {
		
		let ses = "${ sessionId}"
		
		let oldPwd = document.getElementById('originalPwd').value; // 현재 모달창에 입력한 패스워드 - 계속 보내서 DB에 확인
		//document.getElementById('correctOrNot').innerHTML = oldPwd;
		
		let url = "${ contextPath}/mypage/confirmPassword.do";
		
		$.ajax({
					url : url,
					dataType : "json", 
					type : "POST",
					data : {
						ses : ses,
						oldPwd : oldPwd
					},
					success : function(data) { // 통신 성공시 실행될 콜백 함수
						
						if (data == true) {
							document.getElementById('correctOrNot').innerHTML = "<span style = 'color: green;'> ● 일치</span>";
							document.getElementById("yesButton").onclick = confirmModifyPwd;
							
							
						} else {
							// 확인 버튼 안넘어가게 하기.
							document.getElementById('correctOrNot').innerHTML = "<span style = 'color: red;'> ● 불일치</span>";
							document.getElementById("yesButton").onclick = null;

							
						}
						

						}, error : function() {
					}
				});	
	}
	
	function showMyPosts(e) {
		
		let ses = "${ sessionId}";
		
		
		let url = "${ contextPath}/mypage/myposts/?u="+ ses;
		
		console.log(url);
		
		$.ajax({
					url : url,
					dataType : "json", 
					type : "GET",
					success : function(data) { // 통신 성공시 실행될 콜백 함수
							console.log("내 게시물 조회 통신 성공");
						}
				});	

	}
	

	function modifyInfo(e) {
		
			let url = "${ contextPath}/mypage/?u="+ "${ sessionId}";
			console.log(url);
			$.ajax({
						url : url,
						dataType : "json", 
						type : "GET",
						success : function(data) { // 통신 성공시 실행될 콜백 함수
								console.log("통신 성공");
							}
					});	
	}
	
	
	
	
	window.onload = function () {
		
		
		
		
		document.getElementById('originalPwd').addEventListener ("keyup", confirmPwd);
		document.getElementById('modifyInfo').addEventListener ("click", modifyInfo);
		document.getElementById('showAllMyPosts').addEventListener("click", showMyPosts);
		
		
		    $('#pwdModi i').on('click',function(){
		    	
		        $('input').toggleClass('active');
		        if($('input').hasClass('active')){
		            $(this).attr('class',"fa fa-eye-slash fa-lg")
		            .prev('input').attr('type',"text");
		        } else{
		            $(this).attr('class',"fa fa-eye fa-lg")
		            .prev('input').attr('type','password');
		        }	
		    });
		
	}
	
</script>
<style>

div.pwdModi i{
    position: absolute;
    left: 75%;
    top: 27px;
    color: orange;
}

.deleteMember {
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1090;
	display: none;
	width: 100%;
	height: 100%;
	overflow-x: hidden;
	overflow-y: auto;
	outline: 0;
}

.modal-dialog {
	position: relative;
	width: auto;
	margin: 1.5rem;
	pointer-events: none;
}

.modal.fade .modal-dialog {
	transition: transform 0.15s ease-out;
	transform: translateY(-100px) scale(0.8);
}

@media ( prefers-reduced-motion : reduce) {
	.modal.fade .modal-dialog {
		transition: none;
	}
}

.modal.show .modal-dialog {
	transform: translateY(0) scale(1);
}

.modal.modal-static .modal-dialog {
	transform: scale(1.02);
}

.modal-dialog-scrollable {
	height: calc(100% - 3rem);
}

.modal-dialog-scrollable .modal-content {
	max-height: 100%;
	overflow: hidden;
}

.modal-dialog-scrollable .modal-body {
	overflow-y: auto;
}

.modal-dialog-centered {
	display: flex;
	align-items: center;
	min-height: calc(100% - 3rem);
}

.modal-content {
	position: relative;
	display: flex;
	flex-direction: column;
	width: 100%;
	pointer-events: auto;
	background-color: #fff;
	background-clip: padding-box;
	border: 0px solid rgba(67, 89, 113, 0.2);
	border-radius: 0.5rem;
	outline: 0;
}

.modal-backdrop {
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1089;
	width: 100vw;
	height: 100vh;
	background-color: #435971;
}

.modal-backdrop.fade {
	opacity: 0;
}

.modal-backdrop.show {
	opacity: 0.5;
}

.modal-header {
	display: flex;
	flex-shrink: 0;
	align-items: center;
	justify-content: space-between;
	padding: 1.5rem 1.5rem 0.25rem;
	border-bottom: 0px solid #d9dee3;
	border-top-left-radius: calc(0.5rem - 0px);
	border-top-right-radius: calc(0.5rem - 0px);
}

.modal-header .btn-close {
	padding: 0.125rem 0.75rem;
	margin: -0.125rem -0.75rem -0.125rem auto;
}

.modal-title {
	margin-bottom: 0;
	line-height: 1.53;
}

.modal-body {
	position: relative;
	flex: 1 1 auto;
	padding: 1.5rem;
}

.modal-footer {
	display: flex;
	flex-wrap: wrap;
	flex-shrink: 0;
	align-items: center;
	justify-content: flex-end;
	padding: 1.25rem;
	border-top: 0px solid #d9dee3;
	border-bottom-right-radius: calc(0.5rem - 0px);
	border-bottom-left-radius: calc(0.5rem - 0px);
}

.modal-footer>* {
	margin: 0.25rem;
}

@media ( min-width : 576px) {
	.modal-dialog {
		max-width: 35rem;
		margin: 1.75rem auto;
	}
	.modal-dialog-scrollable {
		height: calc(100% - 3.5rem);
	}
	.modal-dialog-centered {
		min-height: calc(100% - 3.5rem);
	}
	.modal-sm {
		max-width: 22.5rem;
	}
}

@media ( min-width : 800px) {
	.col-lg-4 {
		margin-left: -18%;
	}
}

.form-control {
	display: flex;
	width: 70%;
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
							<p>${loginMember.userName}고객님</p>
							<div class="social_icon"></div>
						</aside>

						<aside class="single_sidebar_widget post_category_widget">
							<h4 class="widget_title">Post Catgories</h4>
							<div class="br"></div>
							<ul class="list cat-list">
								<li><span id = "modifyInfo">회원 정보 수정</span></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>주문 현황</p>
								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>구매 내역</p>

								</a></li>
								<li><span id = "showAllMyPosts">내 게시물 조회</span>
								</a></li>
								<li><a href="#" class="d-flex justify-content-between">
										<p>내가 좋아요/신고한 게시물</p>
								</a></li>
								<li onclick = "pointHistory();"><p>적립금 조회</p></li>
								<li><a href="#" class="d-flex justify-content-between"
									data-bs-toggle="modal" data-bs-target="#modalCenter">
										<p>회원 탈퇴</p>
								</a></li>
							</ul>
							<br> <br>
						</aside>
						<aside class="single_sidebar_widget popular_post_widget">
							<h3 class="widget_title">최근 본 상품</h3>
							<c:forEach items="${ recentSeenProd}" var="prod">
							<div class="media post_item">
								<img style = 'width : 180px;' src="${prod.cover }" alt="post">
								<div class="media-body">
									<a href="http://localhost:8001/${contextPath }/product/detail?no=${prod.lastSeenProd}">
									<h3>${prod.title}</h3></a>					
									<p>${prod.lastSeenDate}</p>
								</div>
							</div>			
						</c:forEach>
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

				<div class="col-lg-8 posts-list contentsBox">
					<h2>회원 정보 수정</h2>
					<div class="single-post row">
						아이디 : <input type="text" class="form-control"
							value="${loginMember.userId}" />
						비밀번호 : <input type="hidden" id ="password" value="${loginMember.userPwd }" />
						<button data-bs-toggle="modal" data-bs-target="#modalPwd">비밀번호
							변경</button>
						이름 : <input type="text" class="form-control"
							value="${loginMember.nickName }" /> 	
						닉네임 : <input type="text" class="form-control"
							value="${loginMember.nickName }" /> 
						핸드폰 번호 : <input type="text" class="form-control" value="${loginMember.phoneNum}" />
						이메일 : <input type="text" class="form-control" value="${loginMember.userEmail}" /> 
						생일 : <div>"${loginMember.birth }" </div>
						
						주소 : 
						
					</div>
					<!-- Modal -->
					<div class="modal fade" id="modalCenter" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalCenterTitle">북다방 회원 탈퇴</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="confirm">
									<p>정말로 탈퇴하시겠습니까?</p>
								</div>
								<div class="modal-footer">
									<button type="button"
										class="btn btn-outline-secondary yesButton"
										onclick="withdrawMember();">예</button>
									<button type="button" class="btn btn-primary buttonCon"
										data-bs-dismiss="modal">아니오</button>
								</div>
							</div>
						</div>
					</div>

					<!-- 비밀번호 변경 모달 -->
					<div class="modal fade" id="modalPwd" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalCenterTitle">비밀번호 변경</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="pwdModi">
									현재 비밀번호 : <input type = "password" class="form-control" id ="originalPwd" placeholder="현재 비밀번호를 입력해주세요." />
								<i class="fa fa-eye fa-lg" ></i>
									<span id="correctOrNot"></span>
									변경할 비밀번호 :  <input type="text" class="form-control" id ="pwd1" placeholder="변경할 비밀번호를 입력해주세요." />
									변경할 비밀번호 확인 :  <input type="text" class="form-control" id ="pwd2"  placeholder="변경할 비밀번호를 다시 확인해주세요." />
									
								</div>
								<div class="modal-footer">
									<button type="button"
										class="btn btn-outline-secondary" id = "yesButton"
										onclick="confirmModifyPwd(); ">확인</button>
									<button type="button" class="btn btn-primary buttonCon"
										data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		</div>
		</div>
		<!--================Blog Area =================-->
	</section>
</body>
</html>