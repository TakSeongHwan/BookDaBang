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
		//console.log(boardno);
		if(confirm(boardno + '번글을 복구하시겠습니까?') == true){
		
		let url = "/board/restoreBoard?boardno="+ boardno;
		
		$.ajax({
			url : url,
			dataType : "text", // 수신될 데이터 타입
			type : "post",
			success : function(data) {
				console.log(data)
				if(data == "success"){
					alert("게시물이 복구되었습니다");
					
					
					
					location.href='/board/removeAllfreeBoard';
				}else if(data == "fail") { 
					alert("실패");
				}
			}
		});
		}
		
		
		
	}
</script>
<style type="text/css">
.container{
margin-top: 40px;
}

</style>
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<div class="comment-form">
			<div class="mb-3 mt-3">
				<div class="card mb-4">
					<h4 class="card-header">${freeBoard.boardno}</h4>
					<div class="card-body demo-vertical-spacing demo-only-element">
						<div class="input-group">
							<span class="input-group-text" id="basic-addon11">제목</span> <input
								type="text" class="form-control" placeholder="Username"
								aria-label="title" aria-describedby="basic-addon11"
								value='${freeBoard.title}' readonly
								style="background-color: white;" />

						</div>
						<div class="mb-3">
							<input type="text" class="form-control" id="writer" name="writer"
								readonly="readonly" value="작성자  : ${freeBoard.writer}"
								style="background-color: white;" />
						</div>
						<div>
							<textarea class="form-control" rows="10" id="content"
								name="content" readonly="readonly"
								style="background-color: white;">내용  : ${freeBoard.content }</textarea>
						</div>

					</div>
				</div>
			</div>
		</div>
		<div>
			<button type="button" class="btn btn-primary active"
				style="float: right; margin-left: 20px;" onclick="history.back();">목록보기
			</button>
			<button type="button" class="btn btn-primary active"
				style="float: right;" onclick="restore(${freeBoard.boardno});">게시글
				복원</button>

		</div>
	</div>



	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>
