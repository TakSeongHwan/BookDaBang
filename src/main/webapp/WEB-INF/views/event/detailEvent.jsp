<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 상세안내 페이지</title>

</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
		<div class="container">
			<div>제목 : ${detailEvent.title }</div>
			<div>작성일자 : ${detailEvent.date }</div>
			<div>조회수 : ${detailEvent.readcount }</div>
			<div>이벤트 기간 : ${detailEvent.eventStart } ~ ${detailEvent.eventEnd }</div>
			<div> 본문 : ${detailEvent.content }</div>
			<div>
				<button class="button button-header" onclick="location.href='${contextPath}/event/eventUpdate';" style="margin: 10px;">글 수정</button>
				<button class="button button-header" onclick="location.href='${contextPath}/event/eventDel?boardno=${detailEvent.boardNo }';" style="margin: 10px;">글 삭제</button>
				<button class="button button-header" onclick="location.href='${contextPath}/event/allEventList';" style="margin: 10px;">목록으로</button>
			</div>
		</div>
		
		
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>