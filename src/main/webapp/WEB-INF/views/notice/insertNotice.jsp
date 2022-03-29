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
				
				$.ajax({
       				url : url, 
       				dataType : "text", 
       				type : "POST",
       				processData : false,//이진데이터 전송
       				contentType : false,
       				data : formData,
       				success : function(data) { 
       					console.log(data);
       					let output="<img src='/resources/uploads/noticeBoardImg/"+data+"' style='width:100px; height:100px; overflow: auto; margin:10px' />";
       					console.log(output);
       					$("#imgOutput").append(output);
       					$("#image").val(data);
       					
       				}, error: function(e){//ResponseEntity로 보내준 데이터가 예외가 발생하면 여기에 걸린다
       					
       					alert("통신에 실패하였습니다!");
       				}
       			});
			}
		}
		
		 
	});
	
$("#attachFile").change(function(){
		
		let url = "/notice/attachFileHandling";
		let upfile = this.files[0];
		console.log(upfile);
		let formData = new FormData();
		formData.append("upfile",upfile);
				
				$.ajax({
       				url : url, 
       				dataType : "json", 
       				type : "POST",
       				processData : false,//이진데이터 전송
       				contentType : false,
       				data : 	formData,
       				success : function(data) { 
       					console.log(data.name);
       					
       					
       				}, error: function(e){//ResponseEntity로 보내준 데이터가 예외가 발생하면 여기에 걸린다
       					
       					alert("통신에 실패하였습니다!");
       				}
       			});
			
		
		
		 
	});
	
	
});


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
 
  <form action="/notice/insertNotice" method="post">
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
      <textarea class="form-control" rows="5" id="comment" name="text"></textarea>
      	</div>
      	<input type="hidden" name="image" id="image"/>
  		 <div id="imgOutput"></div>
	
	 
 	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#imageFileAdd">
		이미지 파일 등록
	</button>
	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#attachFileAdd">
		첨부 파일 등록
	</button>
		
		<button type="submit" class="btn btn-success" id="submitBtn" >저장</button>
			<button type="reset" class="btn btn-danger">취소</button>

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