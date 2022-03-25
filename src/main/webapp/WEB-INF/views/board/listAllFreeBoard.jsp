<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#listTable thead{
	background-color: #dcdcdc;
}

</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;" >자유게시판</h2>

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
					<tr>
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



	</div>


	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>