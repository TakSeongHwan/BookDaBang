<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html lang="en">
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Aroma Shop - Cart</title>
<script type="text/javascript">
	$(function() {
		cartInfo();
	})
	
	function cartInfo(){
		$.ajax({
			url : "/userCart/all",
			type : "GET",
			success : function(data) {
				console.log(data);
				let output = "";
				let sum = 0;
				$.each(data, function(i, e) {
					output +='<tr><td><div class="media"><div class="d-flex"><img src="'+e.cover+'" style="width: 150px"></div><div class="media-body"><input type="hidden" id= "cartNo'+i+'" value="'+e.cartNo+'" /><p>'+e.title+'</p></div></div></td><td><h5 id = "sell'+i+'">'+e.sell_price.toLocaleString()+'원</h5></td><td><div class="product_count"><input type="text" name="qty" id="prductQtt'+i+'"maxlength="12" value="'+e.productQtt+'" title="Quantity:"class="input-text qty"><button onclick="addQtt('+i+');"class="increase items-count" type="button"><i class="lnr lnr-chevron-up">+</i></button><button onclick="subQtt('+i+');"class="reduced items-count" type="button"><i class="lnr lnr-chevron-down">-</i></button></div></td><td><h5 id="total'+i+'" class ="total">'+(parseInt(e.sell_price)*parseInt(e.productQtt)).toLocaleString()+'원</h5></td></tr>';
					sum += parseInt(e.sell_price)*parseInt(e.productQtt);
				})
				output += '<tr><td></td><td></td><td><h5>Subtotal</h5></td><td><h5 id="subtotal">'+sum.toLocaleString()+'원</h5></td></tr><tr class="out_button_area"><td class="d-none-l"></td><td class=""></td><td></td><td><div class="checkout_btn_inner d-flex" style="float: right"><a class="gray_btn" href="#">계속하기</a> <a class="primary-btn ml-2" href="/order/checkOut">결제하기</a></div></td></tr>';
				$("#output").append(output);
			}
		})
	}
	
	function addQtt(obj){
		let qtt = $("#prductQtt"+obj);
		qtt.val(parseInt(qtt.val())+1);
		modiQtt(obj);
	}
	function subQtt(obj){
		let qtt = $("#prductQtt"+obj);
		if(qtt.val()>1){
			qtt.val(parseInt(qtt.val())-1);	
			modiQtt(obj);
		}else{
			alert("0개 이하로 줄일 수 없습니다.");
		}
	}

	function modiQtt(obj) {
		let productQtt = $("#prductQtt"+obj).val();
		let cartNo = $("#cartNo"+obj).val();
		let url = "/userCart/"+cartNo;
		let sendData = JSON.stringify({
			cartNo : cartNo,
			productQtt : productQtt
		})
		$.ajax({
			url : url,
			data : sendData,
			dataType : "text",
			contentType : "application/json",
			type : "put",
			headers : {
				"X-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				if (data == "success") {
					$("#total"+obj).text((parseInt($("#sell"+obj).text().replace(",", ""))*productQtt).toLocaleString()+"원");
					let a = $(".total").text().replaceAll(",","").split("원");
					let sum = 0;
					for(let i = 0 ; i < a.length-1; i++){
						sum += parseInt(a[i]);
					}
					$("#subtotal").text(sum.toLocaleString()+"원");
				} else {
					alert("실패");
				}
			}
		});
	}
	function delCart(obj) {
		let url = "/userCart/7";
		$.ajax({
			url : url,
			data : {
				cartNo : 7
			},
			type : "delete",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					alert("성공");
				}
			}
		})
	}
</script>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include><!-- ================ start banner area ================= -->
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shopping Cart </h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Shopping
								Cart</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->
	<!--================Cart Area =================-->
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">Product</th>
								<th scope="col">Price</th>
								<th scope="col">Quantity</th>
								<th scope="col">Total</th>
							</tr>
						</thead>
						<tbody id="output">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</section>
	<!--================End Cart Area =================-->
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>