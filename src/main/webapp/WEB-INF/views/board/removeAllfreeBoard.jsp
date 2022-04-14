<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function readDelBoard(boardno) {
		location.href="/board/readDelBoard?boardno=" + boardno;
	}

</script>

</head>
<body>
<jsp:include page="../managerHeader.jsp"></jsp:include>

<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">삭제게시판</h2>

		<table class="table table-hover" id=listTable>
			<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>작성날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${removeBoard }">
					<tr onclick="readDelBoard(${board.boardno });">
						<td id="td1">${board.boardno }</td>
						<td>${board.writer }</td>
						<td>${board.title }</td>
						<td>${board.date }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		</div>

<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>