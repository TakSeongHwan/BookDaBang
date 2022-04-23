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

	
	


</script>
<style>


</style>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">신고게시판</h2>

		<hr/>
	
	<form action="listAllReportBoard" method="get">
		<button type="submit" name="status" value="Completed">처리완료</button>
		<button type="submit" name="status" value="ing">처리중</button>
		</form>
			
		
	
	

	<div>
		<form action="listAllReportBoard" method="get">
			
		</form>
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

		<nav class="blog-pagination justify-content-center d-flex">
			<ul class="pagination">
				<c:if test="${param.pageNo>1 }">
					<c:choose>
						<c:when test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=1"><<</a></li>
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${param.pageNo-1}"><</a></li>
							
						</c:when>
						<c:otherwise>
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=1&searchType=${param.searchType}&searchWord=${param.searchWord}"><<</a></li>
							<li class="page-item">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}"><</a></li>
								
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:forEach var="i" begin="${paging.startNoOfCurPagingBlock}"
					end="${paging.endNoOfCurPagingBlock }" step="1">
					<c:choose>
						<c:when
							test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
							<c:choose>
								<c:when test="${param.pageNo== i}">
									<li class="page-item"><a class="page-link"
										href="/board/listAllReportBoard?pageNo=${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/listAllReportBoard?pageNo=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${param.pageNo== i}">
									<li class="page-item"><a class="page-link"
										href="/board/listAllReportBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/listAllReportBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${param.pageNo < paging.totalPage }">
					<c:choose>
						<c:when
							test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
							
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${param.pageNo+1}">></a></li>
								<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${paging.totalPage}">>></a></li>
							
						</c:when>
						<c:otherwise>
						
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}">></a></li>
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllReportBoard?pageNo=${paging.totalPage}&searchType=${param.searchType}&searchWord=${param.searchWord}">>></a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		 </nav>







	</div>



	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>