<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 이벤트 리스트</title>
</head>
<style>
#listTable thead {
	background-color: #dcdcdc;
}
</style>
<script type="text/javascript">
	function readEvent(boardNo){
		location.href="/event/progressEvent?boardno=" + boardno; // 넘겨받은 글번호로 하이퍼링크를 건다
	}
</script>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container">
		<h2 style="margin: 30px; font-family: monospace;">전체 이벤트 리스트</h2>
		<table class="table table-hover">
			<thead>
				<tr>
					<th colspan="2">글번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>이벤트 기간</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${eventBoardList }" var="eventBoardList">
					<tr onclick="readEvent(${eventBoardList.boardNo})"> <!-- 클릭시 글넘버를 넘겨 -->
						<td>${eventBoardList.boardNo }</td>
						<td><img src="${eventBoardList.mainImg }" /></td>
						<td>${eventBoardList.title }</td>
						<td>${eventBoardList.date }</td>
						<td>${eventBoardList.eventStart } ~ ${eventBoardList.eventEnd } </td>
						<td>${eventBoardList.readcount }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div>
		<!-- 이하 if문으로 감싸 관리자만 해당 버튼이 보이게 만드는 처리를 할 것 -->
		<!-- <c:if test="${sessionScope.loginUser == 'admin' }"></c:if> -->
		<button class="button button-header" onclick="location.href='/event/showinsertEventPage';" style="margin: 10px;">글 작성</button>
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>