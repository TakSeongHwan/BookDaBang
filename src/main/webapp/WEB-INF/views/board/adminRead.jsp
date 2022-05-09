<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판(관리자)</title>
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
let boardno = '${freeBoard.boardno}';


$(function() {
   let notImgFiles = document.getElementsByClassName("notImgFile");
   
   $(".notImgFile").each(
         function(i, tag) {
            let tmpFileName = $(tag).attr("href");
            // console.log(tmpFileName);
            let fileName = tmpFileName.substring(tmpFileName
                  .lastIndexOf("/") + 1);
            $(tag).text(fileName);
         });
}); 

function adminRemove() {
	
	 let url = "/board/adminRemove?boardno="+ boardno;
	
	 if(confirm(boardno + "번글을 삭제하시겠습니까?") == true){
		$.ajax({
			url : url,
			dataType : "text", // 수신될 데이터 타입
			type : "post",
			success : function(data) {
				console.log(data)
				if(data == "success"){
					alert("게시물이 삭제되었습니다");
					location.href="/board/adminFreeBoard";
				}else if(data == "fail") { 
					alert("실패");
				}
			}
		});
		}
}

</script>


</head>
<style>
.container {
	margin-top: 40px;
}
</style>

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


					<c:if test="${fileLst != null}">
						<div class="mb-3" style="float: left; margin-top: 20px;">
							파일 :
							<c:forEach var="file" items="${fileLst }">
								<c:if test="${file.thumbnailFile != null }">
									<img src="/resources/boardUploads${file.thumbnailFile }" />
								</c:if>
								<c:if test="${file.notImageFile != null}">

									<a href="/resources/boardUploads${file.notImageFile }"
										class="notImgFile"></a>
								</c:if>
							</c:forEach>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	
	<button type="button" class="btn btn-outline-primary" style="float: right; margin-left: 10px;" onclick="history.back();">목록</button>
	<button type="button" class="btn btn-outline-danger" style="float: right;" onclick="adminRemove();">삭제하기</button>
	</div>
	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>