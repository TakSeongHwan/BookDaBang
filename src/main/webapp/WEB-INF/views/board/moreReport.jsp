<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	
function reportStatus(reportno,boardno) {
	if(confirm(boardno + '번글을 신고처리하시겠습니까?') == true){
		if('${reportboard.reportstatus }' == '처리완료'){
			alert("신고처리 완료된 게시물입니다.");
		}else{
	console.log(reportno);
	console.log(boardno);
	
	let url = '/board/reportStatus';
	
	$.ajax({
		url : url,
		data : {
			boardno : boardno,
			reportno : reportno
		},
		dataType : "text", // 수신될 데이터 타입
		type : "post",
		success : function(data) {
			if(data == "success"){
				alert("처리완료");
				location.href="listAllReportBoard";
			}
		}
	});
	
}
	}
}
	
	</script>
<style type="text/css">
.container {
	margin-top: 40px;
}
</style>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>

	<div class="container">
		<div class="comment-form">
			<div class="mb-3 mt-3">
				<div class="card mb-4">
					<h4 class="card-header">신고당한 글 : ${freeboard.boardno }번 게시물</h4>
					<div class="card-body demo-vertical-spacing demo-only-element">
						<div class="input-group">
							<span class="input-group-text" id="basic-addon11">제목</span> <input
								type="text" class="form-control" placeholder="Username"
								aria-label="title" aria-describedby="basic-addon11"
								value='${freeboard.title}' readonly
								style="background-color: white;" />

						</div>
						<div class="mb-3">
							<input type="text" class="form-control" id="writer" name="writer"
								readonly="readonly" value="작성자  : ${freeboard.writer}"
								style="background-color: white;" />
						</div>
						<div>
							<textarea class="form-control" rows="10" id="content"
								name="content" readonly="readonly"
								style="background-color: white;">내용  : ${freeboard.content }</textarea>
						</div>

						<div class="mb-3">
							<input type="text" class="form-control" id="writer" name="writer"
								readonly="readonly" value="신고자  : ${reportboard.reportuser}"
								style="background-color: white;" />
						</div>

						<div>
							<textarea class="form-control" rows="10" id="content"
								name="content" readonly="readonly"
								style="background-color: white;">신고이유  : ${reportboard.why }</textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<button type="button" class="btn btn-primary active"
				style="float: right; margin-left: 20px;" onclick="history.back();">목록보기
			</button>
			<button class="btn btn-outline-danger" id="btn1"
				type="button"  style="float: right;"
				onclick="reportStatus(${reportboard.reportno },${freeboard.boardno} );">신고처리</button>


		</div>
	</div>




	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>