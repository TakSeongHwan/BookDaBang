<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#imageFile").change(function(){
		
		let url = "/notice/imageHandling";
		let upfile = this.files[0];
		let flag = false;
		fileName = upfile.name;
		
		let imgExt = ["jpg","gif","jpeg","png","jfif"];
		let fileExt = fileName.split(".")[1];
		let imgCheck = false;
	
		for(let i in imgExt){
			if(fileExt == imgExt[i]){
				console.log("이미지파일");
				imgCheck = true;
				let formData = new FormData();
				formData.append("imageFile",upfile);
				flag = true;
				
				$.ajax({
       				url : url, 
       				dataType : "text", 
       				type : "POST",
       				processData : false,
       				contentType : false,
       				data : formData,
       				success : function(data) { 
       					console.log(data);
       					let output="<div><img src='/resources/uploads/noticeBoardImg/"+data+"' style='width:100px; height:100px; overflow: auto; margin:10px' />";
       					output += "<button type='button' onclick='delFile(\""+data+"\");'>x</button></div>";
       					console.log(output);
       					$("#imgOutput").html(output);
       					$("#image").val(data);
       					
       				}, error: function(e){
       					console.log(e.responseText);
       					if(e.responseText == "fail:uploadingFail"){
       						alert("파일 업로드에 실패했습니다! 잠시 후 다시 시도해주세요.");
       					}else if(e.responseText == "fail:fileSizeOver"){
       						alert("파일의 용량은 최대 10Mb 까지만 업로드 할 수 있습니다.");
       					}
       				}
       			});
				
			}
		}
		if(!flag){
			alert("이미지 파일만 업로드 가능합니다!");
		}
		 
	});
	
$("#attachFile").change(function(){
		
		let url = "/notice/attactFileUpload";
		let upfile = this.files[0];
		console.log(upfile);
		let formData = new FormData();
		formData.append("upfile",upfile);
				
				$.ajax({
       				url : url, 
       				dataType : "json", 
       				type : "POST",
       				processData : false,
       				contentType : false,
       				data : 	formData,
       				success : function(data) { 
       					console.log(data.notImageFile);
       					console.log(data.thumbnailFile);
       					
       					let output = "";
       					let originFile = data.originFile.split("/")[4].split(".")[0];
       					console.log(originFile)
       			
       					if(data.notImageFile == null){
       						output = "<div id="+originFile+"><img src='/resources/uploads/attachFile"+data.thumbnailFile+"' style='width:100px; height:100px; overflow: auto; margin:10px' />";
       						output +="<button type='button' onclick='delAttachFile(\""+data.thumbnailFile+"\",\""+data.notImageFile+"\",\""+data.originFile+"\");'>x</button></div>";
       					}else if(data.notImageFile != null){
       						output = "<div id="+originFile+"><a href='/resources/uploads/attachFile"+data.notImageFile+"'>첨부파일</a>";
       						output += "<button type='button' onclick='delAttachFile(\""+data.thumbnailFile+"\",\""+data.notImageFile+"\",\""+data.originFile+"\");'>x</button></div>";
       					}
       				
       					$("#attachOutput").append(output);
       					
       				}, error: function(e){
       					
       					alert("통신에 실패하였습니다!");
       				}
       			});
			
		
		
		 
	});
	
	
});

function delFile(data){
	let url = "/notice/delImgFile";
	
	$.ajax({
			url : url, 
			dataType : "text", 
			type : "POST",
			data : {
				fileName : data
			},
			success : function(data) { 
				$("#imgOutput *").remove();
				
			}, error: function(e){//ResponseEntity로 보내준 데이터가 예외가 발생하면 여기에 걸린다
				
				alert("파일 삭제에 실패했습니다! 잠시 후 다시 시도해주세요");
			}
		});

}
function delAttachFile(thumbnailFile,notImageFile,originFile){
	console.log(thumbnailFile+","+notImageFile+","+originFile);
	
	let url = "/notice/attachFileDelete"
		$.ajax({
			url : url, 
			dataType : "text", 
			type : "POST",
			data : {
				thumbnailFile : thumbnailFile,
				notImageFile : notImageFile,
				originFile : originFile
			},
			success : function(data) { 
				
				let originFileId = originFile.split("/")[4].split(".")[0];
				$("#"+originFileId+"").detach();
				
			}, error: function(e){//ResponseEntity로 보내준 데이터가 예외가 발생하면 여기에 걸린다
				
				alert("파일 삭제에 실패했습니다! 잠시 후 다시 시도해주세요");
			}
		});

	
	
}
function writeCancle(){
	let url = "/notice/uploadCancle";
	let targetFileDiv = $("#imgOutput").html();
	console.log(targetFileDiv);
	let targetFile = targetFileDiv.split("/")[4].split("\"")[0];
	console.log(targetFile);
	
	$.ajax({
 		url : url,
 		dataType : "text", // 수신될 데이터 타입
 		type : "POST",
 		data : {
 			targetFile : targetFile
 			},
		success : function(data){
			console.log(data);
			location.href = '/notice/listAll';
			
		},error : function(e){
			
			alert("에러 발생!잠시 후 다시 시도하세요!")
		}
 	});
		
}
</script>
<style>
.imageFileAdd{
z-index:2000;
}
</style>
</head>
<body>
<jsp:include page="../userHeader.jsp"></jsp:include>
<div class="container mt-3">
<h3>공지사항 등록</h3>
 
  <form action="/notice/insertNotice" method="post" >
   <div class="mb-3 mt-3">
  	 <label for="title" class="form-label">글 제목 : </label>
 	 <input type="text" class="form-control" name="title" placeholder="글 제목 입력">
 	  </div>
 	  <div class="mb-3 mt-3">
 	  <label for="writer" class="form-label">작성자 : </label>
  	 <input type="text" class="form-control" name="writer" placeholder="세션에서 받아온 값 리드온리할거">
  	  </div>
  	    <div class="mb-3 mt-3">
      <label for="comment">글 내용:</label>
      <textarea class="form-control" rows="5" id="content" name="content"></textarea>
      	</div>
      	<input type="hidden" name="image" id="image"/>
  		 
	 
 	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#imageFileAdd">
		이미지 파일 등록
	</button>
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#attachFileAdd">
		첨부 파일 등록
	</button>
		
		<button type="submit" class="btn btn-success" id="submitBtn" >저장</button>
			<button type="button" class="btn btn-danger" onclick="writeCancle();">취소</button>

  </form>
 
</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
	
	<div class="modal" id="imageFileAdd">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">이미지 등록</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
				<div id="imgOutput"></div>

					<label for="file"></label> <input type="file" class="form-control"
						id="imageFile" name="upfile">

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">

					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
	<div class="modal" id="attachFileAdd">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
				
					<h4 class="modal-title">첨부파일 등록</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
						<div id="attachOutput"></div>
					<label for="file"></label> <input type="file" class="form-control"
						id="attachFile" name="attachFile">

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">

					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>
</body>
</html>