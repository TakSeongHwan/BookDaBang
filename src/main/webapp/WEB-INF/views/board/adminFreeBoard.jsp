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
	
	
</script>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">자유게시판</h2>

		<hr />

		<div style="float: right;">
			<div class="input-group filter-bar-search">

				<form action="adminFreeBoard" method="get">
					<select class="form-select placement-dropdown" id="selectPlacement"
						name="searchType">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용</option>
					</select>
					<div class="nav-item d-flex align-items-center">
						<input type="text" name="searchWord"
							class="form-control border-0 shadow-none"
							placeholder="검색어를 입력하세요.." aria-label="Search..." />
						<button type="submit"
							style="background-color: white; border-color: white;">
							<i class="bx bx-search fs-4 lh-0"></i>
						</button>

					</div>

				</form>
			</div>
		</div>



		<table class="table table-hover" id=listTable>
			<thead>
				<tr>
					<th>게시글 번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody>


				<c:forEach var="board" items="${freeBoard }">
					<tr onclick="location.href='/board/adminRead?boardno='+ ${board.boardno };">
						<td>${board.boardno }</td>
						<td>${board.title }</td>
						<td>${board.writer }</td>
						<td>${board.date }</td>
						<td>${board.readcount }</td>
						<td>${board.likecount }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


		<nav class="blog-pagination justify-content-center d-flex">
			<ul class="pagination">
				<c:if test="${param.pageNo>1 }">
					<c:choose>
						<c:when
							test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=1"><<</a></li>
							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${param.pageNo-1}"><</a></li>

						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=1&searchType=${param.searchType}&searchWord=${param.searchWord}"><<</a></li>

							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}"><</a></li>

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
										href="/board/adminFreeBoard?pageNo=${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/adminFreeBoard?pageNo=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${param.pageNo== i}">
									<li class="page-item"><a class="page-link"
										href="/board/adminFreeBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/adminFreeBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${param.pageNo < paging.totalPage }">
					<c:choose>
						<c:when
							test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">

							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${param.pageNo+1}">></a></li>
							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${paging.totalPage}">>></a></li>

						</c:when>
						<c:otherwise>

							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}">></a></li>
							<li class="page-item"><a class="page-link"
								href="/board/adminFreeBoard?pageNo=${paging.totalPage}&searchType=${param.searchType}&searchWord=${param.searchWord}">>></a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</nav>

		
	
	
	
</div>




	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>