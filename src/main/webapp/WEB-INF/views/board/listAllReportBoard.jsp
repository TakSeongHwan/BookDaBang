<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>



function moreReport(reportno, boardno) {
	location.href = '/board/moreReport?boardno=' + boardno + '&reportno='+reportno;
	
	
}

function status(yn) {
	console.log(yn);
	location.href="/board/listAllReportBoard?yn=" + yn;
	
}



</script>
<style>
</style>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">신고게시판</h2>

		<hr />



		<div class="input-group filter-bar-search"  style="width: 10%; height: 5%; margin-bottom: 50px; margin-top:20px; float: right;">
			<select name="status" class="form-select placement-dropdown" onchange="status(this.value);">
				<option value="all">전체보기</option>
				<option value="y">처리완료</option>
				<option value="n">처리중</option>
			</select>
		</div>




		<table class="table table-hover" id=listTable>
			<thead>
				<tr>
					<th>자유게시글 번호</th>
					<th>신고게시글 번호</th>
					<th>신고한아이디</th>
					<th>신고 처리현황</th>
					<th>신고 사유</th>
					<th></th>



				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${reportBoard }">
					<tr>
						<td>${board.boardno }</td>
						<td>${board.reportno }</td>
						<td>${board.reportuser }</td>
						<c:if test="${board.reportstatus eq '처리중' }">
							<td><span class="badge bg-label-primary me-1">${board.reportstatus }</span></td>
						</c:if>
						<c:if test="${board.reportstatus eq '처리완료' }">
							<td><span class="badge bg-label-success me-1">${board.reportstatus }</span></td>
						</c:if>
						<td>${board.why }</td>
						<td><button class="btn btn-sm btn-outline-primary" id="btn1"
								type="button"
								onclick="moreReport(${board.reportno },${board.boardno});">자세히
								보기</button></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>


		<nav aria-label="Page navigation">
			<ul class="pagination" style="justify-content: center;">
				<c:if test="${param.pageNo>1 }">
					
			
					<li class="page-item first"><a class="page-link"
						href="/board/listAllReportBoard?pageNo=1"><i
							class="tf-icon bx bx-chevrons-left"></i></a>	
							
					<li class="page-item next"><a class="page-link"
						href="/board/listAllReportBoard?pageNo=${param.pageNo-1}"><i
							class="tf-icon bx bx-chevron-left"></i></a>


				</c:if>

				<c:forEach var="i" begin="${paging.startNoOfCurPagingBlock}"
					end="${paging.endNoOfCurPagingBlock }" step="1">
					<c:choose>
						<c:when test="${param.pageNo== i}">
							
							<li class="page-item active"><a class="page-link"
								href="/board/listAllReportBoard?pageNo=${i}">${i}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item "><a class="page-link"
								href="/board/listAllReportBoard?pageNo=${i}">${i}</a></li>
						</c:otherwise>
					</c:choose>

				</c:forEach>
				<c:if test="${param.pageNo < paging.totalPage }">
					<li class="page-item next"><a class="page-link"
						href="/board/listAllReportBoard?pageNo=${param.pageNo+1}"><i
							class="tf-icon bx bx-chevron-right"></i></a>
					<li class="page-item next"><a class="page-link"
						href="/board/listAllReportBoard?pageNo=${paging.totalPage}"><i
							class="tf-icon bx bx-chevrons-right"></i></a>
				</c:if>
			</ul>
		</nav>





	</div>



	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>