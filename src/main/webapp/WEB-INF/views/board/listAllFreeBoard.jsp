<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<script>

  
	function readFreeBoard(boardno) {
		location.href="/board/readFreeBoard?boardno=" + boardno;
		
	}
	
	
</script>
<style>
#listTable thead {
	background-color: #fafaff;
}
</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	
	
	
	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">자유게시판</h2>
		
			
				<div style="float: right;">
					<div class="input-group filter-bar-search" >
					<form action="listAllFreeBoard" method="get">
					<select name="searchtype">
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용 </option>
					</select> 
				<input type="text" placeholder="검색어를 입력하세요" name="searchword"> 
					<button type="submit" class="ti-search"></button>
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
					<tr onclick="readFreeBoard(${board.boardno});">
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
						<c:when test="${param.searchtype == null || param.searchtype =='' || param.searchword == null || param.searchword ==''}">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo-1}"><</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo-1}&searchtype=${param.searchtype}&searchword=${param.searchword}"><</a></li>
								
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:forEach var="i" begin="${paging.startNoOfCurPagingBlock}"
					end="${paging.endNoOfCurPagingBlock }" step="1">
					<c:choose>
						<c:when
							test="${param.searchtype == null || param.searchtype =='' || param.searchword == null || param.searchword ==''}">
							<c:choose>
								<c:when test="${param.pageNo== i}">
									<li class="page-item"><a class="page-link"
										href="/board/listAllFreeBoard?pageNo=${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/listAllFreeBoard?pageNo=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${param.pageNo== i}">
									<li class="page-item"><a class="page-link"
										href="/board/listAllFreeBoard?pageNo=${i}&searchtype=${param.searchtype}&searchword=${param.searchword}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/llistAllFreeBoard?pageNo=${i}&searchtype=${param.searchtype}&searchword=${param.searchword}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${param.pageNo < paging.totalPage }">
					<c:choose>
						<c:when
							test="${param.searchtype == null || param.searchtype =='' || param.searchword == null || param.searchword ==''}">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo+1}">></a></li>
							
						</c:when>
						<c:otherwise>
						
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo+1}&searchtype=${param.searchtype}&searchword=${param.searchword}">></a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		 </nav>
		<div>
				<button class="button button-header" onclick="location.href='/board/insertFreeBoard';" style="margin: 10px;">글 작성</button>

		</div>											
	</div>


	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>