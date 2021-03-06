<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
<script>
	//	function insertBoard() {
	//		location.href = "insertBoard";
	//	}
</script>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container">
		<h4 class="fw-bold py-3 mb-4">
			<span class="text-muted fw-light"></span> 환불/교환
		</h4>

		<div class="card">
			<h5 class="card-header">환불/교환</h5>

			<table class="table">
				<thead>
					<tr>
						<th>게시글번호</th>
						<th>주문번호</th>
						<th>구매자</th>
						<th>환불신청일</th>
						<th>환불사유</th>
						<th>환불처리날짜</th>
						<th>환불요청</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="Refund" items="${userRefund }" varStatus="status">
						<tr>
							<td><c:out value="${Refund.refundNo}" /></td>
							<td><c:out value="${Refund.orderNo}" /></td>
							<td><c:out value="${Refund.userId}" /></td>
							<td><fmt:formatDate value="${Refund.refundDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><c:choose>
									<c:when test="${Refund.refundReason == 1}">배송지연</c:when>
									<c:when test="${Refund.refundReason == 2}">단순변심</c:when>
									<c:when test="${Refund.refundReason == 3}">상품파손</c:when>
								</c:choose></td>
							<td><fmt:formatDate value="${Refund.refundProcessdate}"
									pattern="yyyy-MM-dd" /></td>
														<c:choose>
								<c:when test="${Refund.isRefund !='yes' }">
									<td>환불대기</td>
								</c:when>
								<c:otherwise>
									<td>환불완료</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>