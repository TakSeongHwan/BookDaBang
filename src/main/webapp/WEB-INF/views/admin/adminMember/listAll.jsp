<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<script>
	window.onload = function() {
		let dormant = {
				isdormant : "",
				userId : ""
		}		

		$(document).on("change", ".dormentCk", function() {
			let url = "/admin/adminMember/dormantUpdate";
			let index = $(".dormentCk").index(this);
			dormant.userId = $(".userId").eq(index).html();
			
			if ($(".dormentCk").is(":checked")) {
				dormant.isdormant = "Y";
			} else {
				dormant.isdormant = "N";
			}
			
			console.log(dormant);

			$.ajax({
				url : url,
				dataType : "text",
				type : "POST",
				data : dormant,
				success : function(data) {

				}
			});

		});
	}
</script>
<style>
</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
	<div class="container">
		<h4 class="fw-bold py-3 mb-4">
			<span class="text-muted fw-light">관리자 /</span> 회원관리
		</h4>

		<div class="card">
			<h5 class="card-header">회원조회</h5>
			<table class="table">
				<thead>
					<tr>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이름</th>
						<th>성별</th>
						<th>생일</th>
						<th>전화번호</th>
						<th>Email</th>
						<th>가입일</th>
						<th>마지막로그인</th>
					</tr>

				</thead>
				<tbody>
					<c:forEach var="MemberVO" items="${memberList }" varStatus="status">
						<tr>
							<td><c:out value="${MemberVO.userId}" /></td>
							<td><c:out value="${MemberVO.nickName}" /></td>
							<td><c:out value="${MemberVO.userName}" /></td>
							<td><c:out value="${MemberVO.gender}" /></td>
							<td><fmt:formatDate value="${MemberVO.birth}"
									pattern="yyyy-MM-dd" /></td>
							<td style="width: 150px"><c:out value="${MemberVO.phoneNum}" /></td>
							<td><c:out value="${MemberVO.userEmail}" /></td>
							<td><fmt:formatDate value="${MemberVO.memberWhen}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${MemberVO.lastLogin}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="card">
			<h5 class="card-header">휴면/정지 계정</h5>
			<table class="table">
				<thead>
					<tr>
						<th>아이디</th>
						<th>생일</th>
						<th>전화번호</th>
						<th>Email</th>
						<th>마지막로그인</th>
						<th>휴면/정지 전환</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="MemberVO" items="${dormantMember }"
						varStatus="status">
						<tr>
							<td class="userId"><c:out value="${MemberVO.userId}" /></td>
							<td><fmt:formatDate value="${MemberVO.birth}"
									pattern="yyyy-MM-dd" /></td>
							<td style="width: 150px"><c:out value="${MemberVO.phoneNum}" /></td>
							<td><c:out value="${MemberVO.userEmail}" /></td>
							<td><fmt:formatDate value="${MemberVO.lastLogin}"
									pattern="yyyy-MM-dd" /></td>

							<td><div class="form-check form-switch">
									<input class="form-check-input dormentCk" type="checkbox"
										role="switch" style="width: 80px; height: 20px;" /> <label
										class="form-check-label" for="flexSwitchCheckDefault"></label>
								</div></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="card">
			<h5 class="card-header">탈퇴회원</h5>
			<table class="table">
				<thead>
					<tr>
						<th>아이디</th>
						<th>탈퇴사유</th>
						<th>탈퇴일</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="Withdraw" items="${deleteMeber }"
						varStatus="status">
						<tr>
							<td><c:out value="${Withdraw.userId}" /></td>
							<td><c:out value="${Withdraw.why}" /></td>
							<td><fmt:formatDate value="${Withdraw.withdrawWhen}"
									pattern="yyyy-MM-dd" /></td>
							<td></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>