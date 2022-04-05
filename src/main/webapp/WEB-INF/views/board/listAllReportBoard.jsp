<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function readReportBoard(boardno) {
		location.href="/board/readReportBoard?boardno=" + boardno;
	}

</script>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">신고게시판</h2>

		<table class="table table-hover" id=listTable>
			<thead>
				<tr>
					<th>자유게시글 번호</th>
					<th>신고게시글 번호</th>
					<th>신고한아이디</th>
					<th>신고 처리현황</th>
					<th>신고 사유</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="board" items="${reportBoard }">
					<tr>
						<td>${board.boardno }</td>
						<td onclick="readReportBoard(${board.boardno});">${board.reportno }</td>
						<td>${board.reportuser }</td>
						<td>${board.reportstatus }</td>
						<td>${board.why }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		</div>

		<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>