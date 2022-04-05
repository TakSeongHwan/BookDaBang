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

<script>
	function restore(boardno) {
		console.log(boardno);
		let url = "/board/restoreBoard?boardno="+ boardno;
		
		$.ajax({
			url : url,
			dataType : "text", // 수신될 데이터 타입
			type : "post",
			success : function(data) {
				console.log(data)
				if(data == "success"){
					location.href ="/board/removeAllFreeBoard";
				}
			}
		});
		
		
		
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<div class="comment-form">
			<h4>${freeBoard.boardno}</h4>
			<div class="mb-3 mt-3">
				<input type="text" class="form-control" id="title" name="title"
					readonly="readonly" value=" 제목 : ${freeBoard.title}">
			</div>
			<div class="mb-3">
				<input type="text" class="form-control" id="writer" name="writer"
					readonly="readonly" value="작성자  : ${freeBoard.writer}" />
			</div>
			<textarea class="form-control" rows="10" id="content" name="content"
				readonly="readonly">내용  : ${freeBoard.content }</textarea>
				
				
				 <button type="button" class="btn btn-primary active" style="float: right; margin-top: 20px;" onclick="
					 restore(${freeBoard.boardno});">게시글 복원</button>
		</div>
	</div>
	
	
	
	
	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>
