<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/resources/js/myLib.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
function openArea() {
	$(".fileDrop").toggle();
}

function savePost(){
	
	console.log($(".selected").text());
	console.log($(".selected").data('value'));
	
	if ($(".selected").data('value') == null) {
		
		alert("말머리를 선택해주세요")
		
	} else {
		
		let headVal = $(".selected").data('value');
		
		$("#categoryCode").val(headVal);
		csWriteForm.submit();
		
	}
}

function delFile(obj) {
	console.log("지우기 되나요")
	
	let targetFile = ($(obj).parent().attr("id")); // 여기서 undifined 뜸.
	
	console.log(obj);
	console.log(targetFile);
	
	
	let url = "${ contextPath}/cs/delFile";

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
				$(".fDropList").empty();
			}

		}
	});
}

function ifchange() {
	
	console.log("왜 안되니..")
	
}

$(function(){
	
	$(".current").on("change", function() {
		alert("!")
	});
	
	 $(".fileDrop").on("dropenter dragover", function (evt){
		evt.preventDefault();
	});
	 
	 $(".fileDrop").on("drop", function (evt) {
		 evt.preventDefault(); // 이벤트가 전파되어 드롭된 파일이 웹브라우저에서 열리는 것을 방지
		 
		 let files = evt.originalEvent.dataTransfer.files; // 드랍된 파일을 얻어옴
		 console.log(files);
		 
		 let formData = new FormData(); // form 객체 생성
		 formData.append("upfile", files[0]); // form 객체에 파일 첨부
		 
		 let url = "${ contextPath}/cs/uploadFile";
		 

		 $.ajax({
			 url : url,
			 data : formData,
			 dataType : "json", // 수신될 데이터 타입
			 type : "post",
			 processData : false, // 전송하는 데이터를 쿼리스트링 형태로 변환하지 않는다.
			 contentType : false, // 기본값(application/x-www.form-urlencoded)를 사용하지 않는다는 뜻.
			 success : function (data) {
				console.log(data);
				
				let output="";
				if (data.thumbnailFileName != null){
					  // 이미지 파일일 경우
                   	  
					  output += "<img src='${ contextPath}/resources/cs_uploads" + data.thumbnailFileName + "' />";
					  output += "<span id='" + data.thumbnailFileName + "'>";
                   
				} else if (data.notImageFileName != null) {
					// 이미지 파일 아닐 경우
					
					
                   let fn = data.notImageFileName.substring(data.notImageFileName.lastIndexOf("/")+1);
                   
                   output += "<a href='${ contextPath}/resources/cs_uploads" + data.notImageFileName + "'>"+ fn + "</a>";
                   output += "<span id='" + data.notImageFileName + "'>";
                   
				}
				
				
				output += "<img src = '${ contextPath}/resources/img/board/close.png' onclick='delFile(this);'/></span>"
					
				$(".fDropList").append(output);
			}			 
		 });
	});
});
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
<title></title>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>

	<div class="container">
		<div class="comment-form">
			<h4 style="text-align: center;">고객센터 글 등록</h4>
			<form method="post" action="${ contextPath}/cs/write.do" name="csWriteForm" >
				<div class="mb-3 mt-3">
					<div class = "nice-select" tabindex="0" style = 'width : 250px; height :38px; margin-right : 25px;'>
						<span class="current" >말머리 선택 </span>
							<ul class="list">
							<li class="option" >말머리 선택</li>
							<li class="option" data-value="1" >기타 불만사항</li>
							<li class="option" data-value="2" >사이트 이용 관련 문의</li>
							<li class="option" data-value="3" >칭찬해요 </li>
							</ul>
							<input type ="hidden" id ="categoryCode" name ="categoryCode" value =""  /> 
						</div>
					<div style = 'margin-left : 20px;'>
					 <label for="title" class="form-label"></label><input
						type="text" class="form-control" id="title"
						placeholder="제목을 입력하세요" name="title" style = 'width : 65%'>
						</div>
					</div>
				<div class="mb-3" style="display:flex; justify-content:center;">
				
					<label for="writer" class="form-label"> 작성자 : </label> <input
						type="text" class="form-control" style = 'width : 45%; margin-left : 20px;' value =  " ${loginMember.nickName }" readonly />
						<input type="hidden" id="writer" name="writer" value = "${ loginMember.userId}" />			
				</div>
			
				<label for="content" class="form-label">내 용 :</label>
				<textarea class="form-control" rows="10" id="content" name="contents"></textarea>
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
						type="button" onclick="savePost();">저장</button>; 
					<button class="button button-postComment button--active"
						id="cancel" onclick="cancelWriteCS();">취소</button>
				</div>
			</form>
		</div>
	</div>


	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>
