<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세안내 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style>

</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
		<div class="container">
			<div style="margin-top:50px; margin-bottom: 50px;">
				<h3 style="float: left; padding-bottom: 20px; width: 330px;">제목 : ${detailEvent.title }</h3>
				<div style="float: left; margin-left: 37%;">
					<div>작성일자 : ${detailEvent.date }</div>
					<div>이벤트 기간 : ${detailEvent.eventStart } ~ ${detailEvent.eventEnd }</div>
				</div>
				<div style="clear: both;"> 본문 : ${detailEvent.content }</div>
			</div>
			
			<!-- 버튼 ------------------------------------------------------- -->
			<div>
				<button class="button button-header" onclick="location.href='${contextPath}/event/eventUpdatePage?boardno=${detailEvent.boardNo }';" style="margin: 10px;">글 수정</button>
				<button class="button button-header" onclick="location.href='${contextPath}/event/eventDel?boardno=${detailEvent.boardNo }';" style="margin: 10px;">글 삭제</button>
				<button class="button button-header" onclick="location.href='${contextPath}/event/allEventList';" style="margin: 10px;">목록으로</button>
			</div>
			
			<!-- 댓글 ------------------------------------------------------- -->
			<div class="reply">
				<form action="post" action="${contextPath}/eventReply/reply">
					<input type="hidden" name="boardno" value="${detailEvent.boardNo}">
					<input type="text" class="form-control" style="display: block; width: 85%; height: 47px; margin-right: 10px; float: left;" name="reply" id="reply" placeholder="댓글입력란">
					<button type="submit" class="button button-header" style="display: block; width: 152px;">완료</button>
				</form>
			</div>
			<div>
				
			</div>
			
			
			
		</div>
		

	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>