<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>베스트 페이지</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container">
		<h2 style="margin: 30px; ">베스트 게시글</h2>
		<div>
			<h5>오늘의 베스트 게시글</h5>
		</div>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${allBestList }" var="allBestList">
					<tr onclick="location.href='${contextPath}/board/readFreeBoard?boardno=${allBestList.boardno }';"> <!-- 클릭시 글넘버를 GET으로 넘기며 이동--->
						<td>${allBestList.boardno }</td>
						<td>${allBestList.title }</td>
						<td>${allBestList.writer }</td>
						<td>${allBestList.date }</td>
						<td>${allBestList.readcount }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="container mt-3">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item active"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
		</div>
	</div>
	
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>