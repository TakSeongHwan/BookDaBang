<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Aroma Shop - Checkout</title>
<link rel="icon" href="${contextPath}/resources/img/Fevicon.png"
	type="image/png">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/nice-select/nice-select.css">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
	href="${contextPath}/resources/vendors/owl-carousel/owl.carousel.min.css">

<link rel="stylesheet" href="css/style.css">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let addressNo = "";
	function proceedToPay() {
		let addr = $("#address");
		console.log($("#first").val())
		console.log(address.value)
		console.log($("#f-option5").prop("checked"))
		console.log($("#f-option6").prop("checked"))
		console.log(telValidator($("#phoneNumber").val()));
		if ($("#first").val().length > 0 && address.value != "") {
			if(telValidator($("#phoneNumber").val())){
				if($("#f-option5").prop("checked") && $("#f-option6").prop("checked"))	{
					if (addressNo.length < 1) {
						insertAddress();
					} else {
						updateAddress();
					}
				}else{
					alert("필수 동의를 해주세요");
				}
			}else{
				alert("전화번호를 확인해주세요")
			}
		}else{
			alert("주소와 이름을 확인해주세요");
		}
	}
	function telValidator(phoneNumber) {
		if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(phoneNumber)) {
			return true;
		}
		return false;
	}
	function insertAddress() {
		let sendData = JSON.stringify({
			recipient : $("#first").val(),
			postalcode : $("#postcode").val(),
			mainAddress : $("#address").val(),
			remainaddress : $("#detailAddress").val(),
			phonenumber : $("#phoneNumber").val(),
			deliverymessage : $("#message").val()
		});
		console.log(sendData);
		$.ajax({
			url : "/address/",
			type : "POST",
			data : sendData,
			contentType : "application/json",
			success : function(data) {
				if (data == 'success') {

				}
			}
		})
	}
	function updateAddress(){
		console.log(addressNo);
		let sendData = JSON.stringify({
			address_no : addressNo,
			recipient : $("#first").val(),
			postalcode : $("#postcode").val(),
			mainAddress : $("#address").val(),
			remainaddress : $("#detailAddress").val(),
			phonenumber : $("#phoneNumber").val(),
			deliverymessage: $("#message").val()
		});
		console.log(sendData);
		$.ajax({
			url : "/address/"+addressNo,
			type : "PUT",
			data : sendData,
			headers : {
				"X-HTTP-Method-Override" : "POST"
			},
			contentType : "application/json",
			success : function(data) {
				if (data == 'success') {
					console.log("update성공");
				}
			}
		})
	}
	$(function() {
		cartInfo();
		getAddress();
	})

	function getAddress() {
		$.ajax({
			url : "/address/all",
			type : "GET",
			success : function(data) {
				parseAddress(data);
			},error: function(data) {
				if("${loginMember.userId}".length<1){
					let output = '<input type="password" class="form-control" id="orderPwd"placeholder="주문 비밀번호를 입력하세요">'
					$("#pwdDiv").append(output);
				}
				
			}
		})

	}

	function parseAddress(data) {
		console.log(data);
		addressNo = data.address_no;
		$("#first").val(data.recipient);
		$("#postcode").val(data.postalcode);
		$("#address").val(data.mainAddress);
		$("#detailAddress").val(data.remainaddress);
		$("#phoneNumber").val(data.phonenumber)
		$("#message").text(data.deliverymessage);
	}

	function cartInfo() {
		$.ajax({
			url : "/userCart/all",
			type : "GET",
			success : function(data) {
				parseOrderInfo(data);
			}
		})
	}

	function parseOrderInfo(data) {
		console.log(data);
		sum = 0;
		let output = '<li><h4>Product <span>Total</span></h4></li>';
		$
				.each(
						data,
						function(i, e) {
							console.log(e);
							output += '<li><div style="float:left; width:150px; height:25px; overflow:hidden; text-overflow: ellipsis; white-space: nowrap;">'
									+ e.title
									+ '</div><span class="middle" style="margin-left:30px; width:30px; display:inline-block;">x'
									+ e.productQtt
									+ '</span><span class="last" style="float:right;">'
									+ (parseInt(e.productQtt) * parseInt(e.sell_price))
											.toLocaleString() + '원</span></li>'
							sum += parseInt(e.productQtt)
									* parseInt(e.sell_price);
						})
		output += '</ul><ul class="list list_2"><li><a href="javascript:void(0)">Total <span>'
				+ sum.toLocaleString() + '원</span></a></li>'
		$("#output").append(output);
	}

	function daumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("extraAddress").value = extraAddr;

				} else {
					document.getElementById("extraAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('postcode').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailAddress").focus();
			}
		}).open();
	}
</script>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>

	<!-- ================ start banner area ================= -->
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Product Checkout</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Checkout</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->


	<!--================Checkout Area =================-->
	<section class="checkout_area section-margin--small">
		<div class="container">
			<div class="billing_details">
				<div class="row">
					<div class="col-lg-8">
						<h3>Billing Details</h3>
						<form class="row contact_form" action="#" method="post"
							novalidate="novalidate">
							<div class="col-md-12 form-group p_star">
								<input type="text" class="form-control" id="first" name="name"
									placeholder="이름을 입력하세요">
							</div>
							<div class="col-md-12 form-group p_star">
								<input type="text" id="postcode" class="form-control"
									placeholder="우편번호" onclick="daumPostcode();">
							</div>
							<div class="col-md-12 form-group p_star">
								<input type="text" class="form-control" id="address" disabled
									placeholder="">
							</div>
							<div class="col-md-12 form-group p_star">
								<input type="text" class="form-control" id="detailAddress"
									placeholder="상세주소">
							</div>

							<div class="col-md-12 form-group p_star">
								<input type="text" class="form-control" id="extraAddress"
									placeholder="참고항목">
							</div>

							<div class="col-md-12 form-group p_star">
								<input type="text" class="form-control" id="phoneNumber"
									placeholder="010-1234-5678">
							</div>

							<div class="col-md-12 form-group mb-0">
								<textarea class="form-control" name="message" id="message"
									rows="1" placeholder="배송 요청사항"></textarea>
							</div>
							<div class="col-md-12 form-group p_star" id="pwdDiv"></div>
						</form>
					</div>
					<div class="col-lg-4">
						<div class="order_box">
							<h2>Your Order</h2>
							<ul class="list" id="output">

							</ul>
							<div class="payment_item">
								<div class="creat_account">
									<input type="checkbox" id="f-option5" name="selector"><label
										for="f-option5">개인정보 수집 및 이용동의(필수)</label>
									<div class="check"></div>
								</div>
								<p>수집하는 개인정보의 항목, 수집/이용목적, 개인정보 보유기간에 동의합니다.</p>
							</div>
							<div class="payment_item active">
								<div class="creat_account">
									<input type="checkbox" id="f-option6" name="selector">
									<label for="f-option6"> 주문내역확인 동의(필수) </label> <img
										src="img/product/card.jpg" alt="">
									<div class="check"></div>
								</div>
								<p>
									주문시 입력하신 배송정보는 배송을 위한 목적으로 사용됩니다.<br /> 주문할 상품의 상품명, 가격, 배송정보
									등을 최종 확인하였으며, 구매에 동의하십니까? (전자상거래법 제 8조 2항)
								</p>
							</div>
							<div class="text-center">
								<a class="button button-paypal" href="javascript:void(0);"
									onclick="proceedToPay();">Proceed to Pay</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Checkout Area =================-->


	<jsp:include page="../userFooter.jsp"></jsp:include>


	<script
		src="${contextPath}/resources/vendors/jquery/jquery-3.2.1.min.js"></script>
	<script
		src="${contextPath}/resources/vendors/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${contextPath}/resources/vendors/skrollr.min.js"></script>
	<script
		src="${contextPath}/resources/vendors/owl-carousel/owl.carousel.min.js"></script>
	<script
		src="${contextPath}/resources/vendors/nice-select/jquery.nice-select.min.js"></script>
	<script src="${contextPath}/resources/vendors/jquery.ajaxchimp.min.js"></script>
	<script src="${contextPath}/resources/vendors/mail-script.js"></script>
	<script src="${contextPath}/resources/js/main.js"></script>
</body>
</html>;