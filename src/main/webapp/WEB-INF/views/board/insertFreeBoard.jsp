<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function() {
		$(".fileDrop").on("dropenter dragover", function(evt) {
			evt.preventDefault();

		});

		$(".fileDrop")
				.on(
						"drop",
						function(evt) {
							evt.preventDefault(); // 이벤트가 전파되어 파일이 웹브라우저에서 열리는 것을 방지

							let files = evt.originalEvent.dataTransfer.files; // 드랍된 파일을 얻어옴
							console.log(files);

							let formData = new FormData(); // form객체 생성

							formData.append("upfile", files[0]); // form객체에 파일 첨부

							let url = "/board/uploadsFile";
							
									$.ajax({
										url : url,
										data : formData,
										dataType : "json", // 수신될 데이터 타입
										type : "post",
										processData : false, // 전송하는 데이터를 쿼리스트링 형태로 변환하지 않는다
										contentType : false, // 기본값(application/x-www.form-urlencoded) 사용하지 않음
										success : function(data) {
											console.log(data);

											let output = "";
											if (data.thumbnailFileName != null) {
												// 이미지 파일이다
												output += "<img src='/resources/boardUploads" + data.thumbnailFileName + "' />";
												output += "<span id='"
														+ data.thumbnailFileName
														+ "' onclick='delFile(this)'>";
											} else if (data.notImageFileName != null) { // 이미지 파일 아님
												let fn = data.notImageFileName
														.substring(data.notImageFileName
																.lastIndexOf("/") + 1);

												output += "<a href='/resources/boardUploads" + data.notImageFileName + "'>"
														+ fn + "</a>";
												output += "<span id='"
														+ data.notImageFileName
														+ "' onclick='delFile(this)'>";
											}

											output += "<img src='/resources/img/board/close.png' /></span>"

											$(".fDropList").append(output);

										},
										error : function(e) {
											console.log(e);
											alert("파일업로드 실패");
										}
									});
						});

	});

	function delFile(obj) {
		let targetFile = ($(obj).attr("id"));
		console.log(targetFile); 
		let url = "/board/delFile";

		$.ajax({
			url : url,
			data : {
				targetFile : targetFile
			},
			dataType : "text", // 수신될 데이터 타입
			type : "post",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					$(obj).prev().remove();
					$(obj).remove();
				}
			}
		});
	}

	function openArea() {
		$(".fileDrop").toggle();

	}
	
	function cancelFreeBoard() {
		let url = "/board/cancelFreeBoard";
		$.ajax({
			url : url,
			dataType : "text", // 수신될 데이터 타입
			type : "post",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					location.href ="/board/listAllFreeBoard";
				}
			}
		});

		
	}
	
	function formCheck() {
		if($("#title").val()=="" || $("#content").val()==""){
			alert("내용을 입력해주세요!");
			return false;
		}
	}
	
</script>
<style>
.form-label {
	float: left;
}

#cancel {
	background: white;
	color: #6b38eb;
}

.fileDrop {
	width: 100%;
	height: 300px;
	border: 1px dotted blue;
	display: none;
}

.fileDrop .fileContent {
	padding: 20px;
	text-align: center;
	margin: 10px auto;
}

.fDropList {
	padding: 5px;
	float: left;
}

.fDropList img, .fDropList a {
	margin-left: 10px;
}

.btns {
	clear: left;
}
</style>
<title>자유게시판 글 등록</title>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>

	<div class="container">

		<div class="comment-form">
			<h4 style="text-align: center;">자유게시판 글 등록</h4>
			<form method="post" action="/board/createFreeBoard" onsubmit="return formCheck();">
				<div class="mb-3 mt-3"> 
					<label for="title" class="form-label">글 제목 :</label> <input
						type="text" class="form-control" id="title"
						placeholder="제목을 입력하세요" name="title">
				</div>
				<div class="mb-3">
					<label for="writer" class="form-label">작성자 :</label> <input
						type="text" class="form-control" id="writer" name="writer" value="${userId }" readonly="readonly"/>
				</div>
				<label for="content" class="form-label">내 용 :</label>
				<textarea class="form-control" rows="10" id="content" name="content"></textarea>

				<div class="mb-3">
					<button type="button" class="btn btn-default" onclick="openArea();">파일
						업로드</button>
					<div class="fileDrop">
						<div class="fileContent">이 영역에 업로드 할 파일을 드래그 드롭 해 주세요!</div>
					</div>
					<div class="fDropList"></div>

				</div>

				<div class="btns">
					<button class="button button-postComment button--active"
						type="submit"  >저장</button>
					<button class="button button-postComment button--active"
						id="cancel" type="button" onclick="cancelFreeBoard();">취소</button>

				</div>
			</form>
		</div>
	</div>






	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>
