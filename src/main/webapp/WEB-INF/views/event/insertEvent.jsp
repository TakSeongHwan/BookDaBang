<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글 작성</title>
<!-- 제이쿼리 -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>


<script type="text/javascript">
	function insertsumit() {
		let title = $("#title").val();
		let eventStart = $("#eventStart").val();
		let eventEnd = $("#eventEnd").val();
		let content = $("#content").val();
		let mainImg = $("#mainImg").val();

		$.ajax({
			type : "POST",
			url : "/khn/event/insertEvent",
			data : {
				title : title,
				eventStart : eventStart,
				eventEnd : eventEnd,
				content : content,
				mainImg : mainImg, 
			},
			success : function() {
				alert("글 등록이 완료되었습니다.");
				location.href = "${contextPath}/event/allEventList";
			},
			error : function() {
				alert("등록 실패")
				console.log(data);
			}
		});
	};
	
</script>



</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>

	<div class="container">
		<div class="mb-3 mt-3">
			<label for="title" class="form-label">글 제목 : </label>
			<input type="text" class="form-control" name="title" id="title" placeholder="글 제목 입력">
		</div>

		<div class="mb-3 mt-3">
			<label for="eventStart" class="form-label">이벤트 시작일 : </label>
			<input type="date" class="form-control" name="eventStart" id="eventStart">
		</div>
		<div class="mb-3 mt-3">
			<label for="eventEnd" class="form-label">이벤트 종료일 : </label> 
			<input type="date" class="form-control" name="eventEnd" id="eventEnd">
		</div>

		<div class="mb-3 mt-3">
			<div class="mainImgArea"><img src="" /></div>
		  	<label for="content" class="form-label">본문 : </label>
		 	<textarea class="form-control"  name="content" id="content" style="height: 500px;"></textarea>
		</div>
		<input type="file" id="mainImg">
		
		<button class="button button-header" onclick="insertsumit()" style="margin: 10px;">등록</button>
		<button class="button button-header" onclick="location.href='${contextPath}/event/allEventList';" style="margin: 10px;">취소</button>
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>