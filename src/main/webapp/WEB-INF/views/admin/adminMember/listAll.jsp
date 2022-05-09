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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
	let pageNo = 1;

	window.onload = function() {
		getList(1, pageNo);
		getList(2, pageNo);
		getList(3, pageNo);

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
	//회원 관리 ajax통신
	function getList(answerStatus, tmp) {
		console.log(tmp)
		pageNo = tmp;
		url = "/admin/adminMember/getList?pageNo=" + pageNo + "&answerStatus="
				+ answerStatus;
		$.ajax({
			url : url,
			type : "GET",
			success : function(data) {
				console.log(data)
				if (answerStatus == 1) {
					selectList(data);
				} else if (answerStatus == 2) {
					dormantList(data);
				} else if (answerStatus == 3) {
					deleteList(data);
				}
			},
			error : function(data) {
				console.log(data);
			}
		});
	}
	// 모든회원 조회
	function selectList(data) {
		let output = "";
		$.each(data.memberList, function(i, e) {
			output += '<tr class="">';
			output += '<td class="">' + e.userId + "</td>";
			output += '<td class="">' + e.nickName + "</td>";
			output += '<td class="">' + e.userName + "</td>";
			output += '<td class="">' + e.gender + "</td>";
			let birth = new Date(new Date(e.birth) + 3240 * 10000)
					.toISOString().split("T")[0];
			output += '<td class="">' + birth + "</td>";
			output += '<td class="">' + e.phoneNum + "</td>";
			output += '<td class="">' + e.userEmail + "</td>";
			let memberWhen = new Date(new Date(e.memberWhen) + 3240 * 10000)
					.toISOString().split("T")[0];
			output += '<td class="">' + memberWhen + "</td>";
			let lastLogin = new Date(new Date(e.lastLogin) + 3240 * 10000)
					.toISOString().split("T")[0];
			output += '<td class="">' + lastLogin + "</td></tr>";
		});

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(1,1)'><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(1,"
					+ (pageNo - 1)
					+ ")'><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active' onclick='getList(1,"
						+ i + ")'><a class='page-link'>" + i + "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='getList(1,"
						+ i + ")'>" + i + "</a></li>";
			}

		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='getList(1,"
					+ (pageNo + 1)
					+ ")'><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last' onclick='getList(1,"
					+ data.pagingInfo.totalPage
					+ ")'><a class='page-link' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'
		$("#seleteList").html(output);
		$("#pagingBox").html(pagingoutput);
	}
	// 휴면/정지회원
	function dormantList(data) {
		let output = "";
		$.each(data.memberList, function(i, e) {
			output += '<tr class="">';
			output += '<td class="">' + e.userId + "</td>";
			let birth = new Date(new Date(e.birth) + 3240 * 10000)
					.toISOString().split("T")[0];
			output += '<td class="">' + birth + "</td>";
			output += '<td class="">' + e.phoneNum + "</td>";
			output += '<td class="">' + e.userEmail + "</td>";
			let lastLogin = new Date(new Date(e.lastLogin) + 3240 * 10000)
					.toISOString().split("T")[0];
			output += '<td class="">' + lastLogin + "</td>";
			output += '<td><div class="form-check form-switch"><input class="form-check-input dormentCk" type="checkbox" role="switch" style="width: 80px; height: 20px;" <label class="form-check-label" for="flexSwitchCheckDefault"></label></td></tr>'
		});

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(2,1)'><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(2,"
					+ (pageNo - 1)
					+ ")'><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active' onclick='getList(2,"
						+ i + ")'><a class='page-link'>" + i + "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='getList(2,"
						+ i + ")'>" + i + "</a></li>";
			}

		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='getList(2,"
					+ (pageNo + 1)
					+ ")'><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last' onclick='getList(2,"
					+ data.pagingInfo.totalPage
					+ ")'><a class='page-link' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'
		$("#dormantList").html(output);
		$("#pagingBox2").html(pagingoutput);
	}

	// 삭제회원
	function deleteList(data) {
		let output = "";
		$.each(data.deleteList,
				function(i, e) {
					output += '<tr class="">';
					output += '<td class="">' + e.userId + "</td>";
					output += '<td class="">' + e.why + "</td>";
					let withdrawWhen = new Date(
							new Date(e.withdrawWhen) + 3240 * 10000)
							.toISOString().split("T")[0];
					output += '<td class="">' + withdrawWhen + "</td>";
					output += '<td><img src="../../resources/img/delete.png" style="width: 20px;" data-bs-toggle="modal" data-bs-target="#myModal" onclick="deleteMember("${status.count }");" /></td></tr>'
				});

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(3,1)'><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='getList(3,"
					+ (pageNo - 1)
					+ ")'><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active' onclick='getList(3,"
						+ i + ")'><a class='page-link'>" + i + "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='getList(3,"
						+ i + ")'>" + i + "</a></li>";
			}

		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='getList(3,"
					+ (pageNo + 1)
					+ ")'><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last' onclick='getList(3,"
					+ data.pagingInfo.totalPage
					+ ")'><a class='page-link' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'
		$("#deleteList").html(output);
		$("#pagingBox3").html(pagingoutput);
	}

	//회원 삭제 모달
	let userId = null;
	function deleteMember(i) {
		userId = $("#" + i).text();
		$(".modal-body").html(userId + "를 삭제하시겠습니까?")
	}
	//회원 삭제
	function delete2() {
		let url = "/admin/adminMember/delete"
		$.ajax({
			url : url, // ajax와 통신할곳
			dataType : "text", // 수신 받을 데이터의 타입
			type : "GET",
			data : {
				userId : userId
			},
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data);
				if (data == "success") {

				}
			}
		});
	}
</script>
<style>
.pagination {
	width: 300px;
	margin: 0 auto;
}
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
				<tbody id="seleteList">

				</tbody>
			</table>
			<!-- 페이징 -->
			<!--  	
			<nav class="blog-pagination justify-content-center d-flex">
				<ul class="pagination"> 
					<c:if test="${param.pageNo>1 }">
							<li class="page-item"><a class="page-link"
								href="/admin/adminMember/listAll?pageNo=${param.pageNo-1}"><</a></li>
					</c:if>
					 
					<c:forEach var="i" begin="${memberList.pagingInfo.startNoOfCurPagingBlock}"
						end="${memberList.pagingInfo.endNoOfCurPagingBlock }" step="1">
								<c:choose>
									<c:when test="${param.pageNo== i}">
										<li class="page-item"><a class="page-link" href="/admin/adminMember/listAll?pageNo=${i}">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item "><a class="page-link" href="/admin/adminMember/listAll?pageNo=${i}">${i}</a></li>
									</c:otherwise>
								</c:choose>
					</c:forEach>
					<c:if test="${param.pageNo < memberList.pagingInfo.totalPage }">
							<li class="page-item"><a class="page-link" href="/admin/adminMember/listAll?pageNo=${param.pageNo+1}">></a></li>
					</c:if>
				</ul>
			</nav> -->
			<div id="pagingBox" style="width: 700px; margin: 0 auto;"></div>
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
				<tbody id="dormantList">
					<!--  jstl 작업 -->
					<!--<c:forEach var="MemberVO" items="${dormantMember }"
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
					</c:forEach> -->

				</tbody>
			</table>
			<div id="pagingBox2" style="width: 700px; margin: 0 auto;"></div>
		</div>

		<div class="card">
			<h5 class="card-header">탈퇴회원</h5>
			<table class="table">
				<thead>
					<tr>
						<th>아이디</th>
						<th>탈퇴사유</th>
						<th>탈퇴일</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id="deleteList">
					<!--<c:forEach var="Withdraw" items="${deleteMeber }"
						varStatus="status">
						<tr>
							<td id='${status.count }'><c:out value="${Withdraw.userId}" /></td>
							<td><c:out value="${Withdraw.why}" /></td>
							<td><fmt:formatDate value="${Withdraw.withdrawWhen}"
									pattern="yyyy-MM-dd" /></td>
							<td><img src="../../resources/img/delete.png"
								style="width: 20px;" data-bs-toggle="modal"
								data-bs-target="#myModal"
								onclick="deleteMember('${status.count }');" /></td>
						</tr>
					</c:forEach>-->
				</tbody>
			</table>
			<div id="pagingBox3" style="width: 700px; margin: 0 auto;"></div>
		</div>

	</div>
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">삭제</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">정말 삭제 하시겠습니까?</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal" onclick="delete2();">확인</button>
				</div>

			</div>
		</div>
	</div>

	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>