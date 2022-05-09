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
<title>비회원 주문 조회</title>
<script type="text/javascript">
	$(function(){
		getOrderStatus();
	});
	
	function orderConfirm(orderNo){
		alert(orderNo);
		$.ajax({
			url : "${contextPath}/order/confirmOrder",
			data : {
				orderNo : orderNo
			},
			type : "post",
			success : function(data){
				console.log(data);
				getOrderStatus();
			},error : function(data){
				console.log(data);
			}
		})
	}
	function parsingOrder(data){
		console.log(data);
		let output2 = '';
			$.each(data, function(i, e) {
				output2 += '<tr><td>'+e.orderNo+'</td>'
				output2 += '<td><div class="media"><div class="d-flex" style="width:200px"><img src="'+e.cover+'" style="width: 150px"></div><div class="media-body"><p>'+e.title+ '</p></div></div></td>'
				output2 += '<td>'+e.productQtt+'</td>'
				output2 += '<td nowrap><h5 id = "price'+e.cartNo+'">'+ e.price.toLocaleString()+'원</td>'
				output2 +='<td nowrap>';
				if(e.orderState_code == 1){
					output2 += '출고 준비중';
				}else if(e.orderState_code ==2){
					output2 += '배송중';
				}else if(e.orderState_code ==3){
					output2 += '배송완료';
				}else if(e.orderState_code == 4){
					output2 += '주문 취소';
				}else if(e.orderState_code == 5){
					output2 += '상품 환불';
				}
				output2 +='</td>';
				output2 += '<td nowrap>';
				if(e.orderState_code == 5){
					output2 += 'Y';
				}else{
					output2 += '<button type="button" id="refundBtn" onclick="refund();" class="button" value="'+e.orderNo+'">환불신청</button>';
				}
				output2 += '</td>';
				output2 += '<td nowrap>';
				if(e.confirm == 'Y'){
					output2 += "Y";
				}else if(e.orderState_code == 5 && e.confirm == 'N'){
					output2 += "환불 대기중";
				}else if(e.orderState_code == 4){
					output2 += "주문 취소";
				}
				else{
					output2 += '<button type="button" id="cofirmBtn" class="button" onclick="orderConfirm(this.value);" value="'+e.orderNo+'">확정하기</button>';
				}
				output2 += '</td></tr>';
				});
			
		$("#output").html(output2);
	}
	
	function getOrderStatus(){
		console.log("${orderBundle}");
		$.ajax({
			url : "${contextPath}/order/orderCheck",
			type : "get",
			data : {
				orderBundle : "${orderBundle}",
				orderPwd : "${orderPwd}"
			},
			success : function(data) {
				parsingOrder(data);
			},
			error : function(data){
				console.log(data);
			}
		});
	}
</script>
<style type="text/css">
#refundBtn, #cofirmBtn{
	padding: 12px 12px;
}
</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include><!-- ================ start banner area ================= -->
	<section class="blog-banner-area">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>비회원 주문조회</h1>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->
	<!--================Cart Area =================-->
	<section class="cart_area">
		<div class="container">
			<div class="cart_inner" style="width: 1300px;">
				<div class="table-responsive">
					<div class="container" style="width: 2000px;">
						<div>
							<div class="table-responsive">
								<table class="table">
									<thead>
										<tr>
											<th scope="col" nowrap>주문 번호</th>
											<th scope="col" nowrap style="width: 500px;">상품</th>
											<th scope="col" nowrap>수량</th>
											<th scope="col" nowrap>가격</th>
											<th scope="col" nowrap>상태</th>
											<th scope="col" nowrap>환불</th>
											<th scope="col" nowrap>확정</th>
										</tr>
									</thead>
									<tbody id="output">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Cart Area =================-->
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>