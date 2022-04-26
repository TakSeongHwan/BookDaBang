<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<title>자유게시판</title>
<script>
let userId = '${mem.userId}';	

$(function() {

console.log(userId);
	
});
	function readFreeBoard(boardno) {
		location.href="/board/readFreeBoard?boardno=" + boardno;
		
	}
	
	
function login() {
	console.log(userId);
	if (userId !=''){
		location.href="/board/insertFreeBoard?userId=" + userId;
	}else{
		alert("로그인 후 이용해주세요");
		location.href="/login";
	}
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
			
			
				<div style="margin-left: 72%;">
					<div class="input-group filter-bar-search"  >
					<form action="listAllFreeBoard" method="get">
					<select name="searchType" >
						<option value="title">제목</option>
						<option value="writer">작성자</option>
						<option value="content">내용 </option>
					</select> 
					<span class="input-group-append" >
				<input type="text" placeholder="검색어를 입력하세요" name="searchWord"> 
				
					<button type="submit" ><i class="ti-search"></i></button></span>
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

			<div style="float: right;">
				<button class="button button-header" onclick="login();" style="margin: 10px;">글 작성</button>
		</div>				

			 <nav class="blog-pagination justify-content-center d-flex">
			<ul class="pagination">
				<c:if test="${param.pageNo>1 }">
					<c:choose>
						<c:when test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=1"><<</a></li>
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo-1}"><</a></li>
							
						</c:when>
						<c:otherwise>
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=1&searchType=${param.searchType}&searchWord=${param.searchWord}"><<</a></li>
							<li class="page-item">
							<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}"><</a></li>
								
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
										href="/board/listAllFreeBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item "><a class="page-link"
										href="/board/listAllFreeBoard?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
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
								href="/board/listAllFreeBoard?pageNo=${param.pageNo+1}">></a></li>
								<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${paging.totalPage}">>></a></li>
							
						</c:when>
						<c:otherwise>
						
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}">></a></li>
						<li class="page-item">
							<a class="page-link"
								href="/board/listAllFreeBoard?pageNo=${paging.totalPage}&searchType=${param.searchType}&searchWord=${param.searchWord}">>></a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		 </nav>
									
	</div>


	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>