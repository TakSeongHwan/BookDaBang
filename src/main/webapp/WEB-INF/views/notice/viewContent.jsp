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
let attachCount = 0;

$(document).ready(function(){
	showAllReply();
	$("#imageFile").change(function(){
		let upfile = this.files[0];
		let fileName = upfile.name;
		
		let imgExt = ["jpg","gif","jpeg","png","jfif"];
		let fileExt = fileName.split(".")[1];
		let imgCheck = false;
	
		for(let i in imgExt){
			if(fileExt == imgExt[i]){
				console.log("이미지파일");
				imgCheck = true;
				formData.append("imageFile",upfile);
				
			}
		}
		if(!imgCheck){
			alert("이미지 파일만 업로드 가능합니다!");
		}
	});
	
$("#attachFile").change(function(){
	
	let upfile = this.files[0];
	console.log(upfile);
	
		formData.append("upfile"+attachCount, upfile);
		attachCount++;

		 
	});
	
	
});

function delFile(data){
	
	
}
function delAttachFile(thumbnailFile,notImageFile,originFile,attachFileNo){
	console.log(thumbnailFile+","+notImageFile+","+originFile+","+attachFileNo);
	
	
	
}
function modifyAttachFile(){
//파일들을 아작스로 바로 보내지 말고, 따로 값을 hidden에 정리해둔 다음 전송버튼이 눌리면 그때 보내자. 
}
function writeCancle(){
	
		
}
	function modifyNotice() {
		$("#modiModal").show(200);

	}
	function closeModal(){
		$("#modiModal").hide(0);
	}
	function showAlert(){
		
		$("#delAlert").show(200);
	}
	function addreply(){
		let reply=$("#reply").val();
		console.log(reply);
		let writer="cat"//세션아이디값 받아다쓸거
		let no = "${content.no}"
		
		let sendData = JSON.stringify({
			boardNo : no, replyer : writer, replyContent : reply
		});
		
		let url="/noticeReply/addReply";
		$.ajax({
				url : url, 
				dataType : "JSON", 
				type : "POST",
				data : sendData,
				contentType : "application/json;charset=UTF-8",
				success : function(data) { 
					console.log(data);
					
					
				}, error: function(e){
					console.log(e.responseText);
					
				}
			});
	}
	function showAllReply(){
		
		let boardNo = "${content.no}"
		let url="/noticeReply/all/"+boardNo;
		$.ajax({
			url : url, 
			dataType : "JSON", 
			type : "GET",
			success : function(data) { 
				console.log(data);
				if(data != null){
					parseData(data);
				}
				
			}, error: function(e){
				console.log(e.responseText);
				
			}
		});
	}
	function openReply(){
		$("#replyArea").css({"display":"block"});
	}
	function parseData(data){
		$("#viewAllReply").empty();
		let output = '<div class="list-group" style="border:10px;">'
			$.each(data, function(i,e){
				output += '<div class="list-group-item list-group-item-action replyItems" id="div'+e.replyNo+'">';
				output += '<div><div id="rep'+e.replyNo+'">'+e.replyer+'</div>';
				output += '<div> 댓글 내용 : '+ e.replyContent+'</div>';	
				output += '<div> 작성 일자 '+ formatDate(e.replyDate) + '</div>';	
				output += '<div style="float:right; margin-right:10px;">' + "<img src='/resources/images/correct.png' width='20px' onclick='showReplyModify("+e.replyNo+");'/>";
				output += "<img src='/resources/images/delete.png' width='20px' onclick='showReplyDelete("+e.replyNo+");'/>";
				output += '</div>';
	  			output += '</div></div>';
			});
		  
		  
			output += '</div>'
		
		$("#viewAllReply").append(output);
	}
	function formatDate(date){

		let diff = new Date() - date;
		let diffs = diff/1000;
		if( diffs < 60 * 5){
			return '<span class="badge bg-warning text-dark rounded-pill">방금 전</span>';
		}
		let diffm = diffs/60;
		if(diffm < 60){
			return '<span class="badge bg-warning text-dark rounded-pill">'+Math.floor(diffm)+'분 전</span>';
		}
		return '<span class="badge bg-info text-dark rounded-pill">'+new Date(date).toLocaleString()+'</span>';
	}
</script>

<style>
#modiModal{
z-index:auto;
}
.infoArea {
	background-color: #000000;
	min-height: 50px;
}

.titleArea {
	background-color: #002347;
	align-content: center;
	margin-bottom: 0px;
}

.contentArea {
	margin-bottom: 0px;
	min-height: 450px;
	background-color: #feffff;
	padding: 15px 10px 2px 10px;
}

.contentContainer {
	min-height: 800px;
}

.txtColorW {
	color: white;
	padding-left: 5px;
}

.writer {
	margin: 10px;
	display: inline-block;
}

.countText {
	margin: 10px;
	float: right;
}
</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container mt-3 contentContainer">
		${content }
		<div class="contentContainer">
			<h3 class="titleArea mt-4 p-5 txtColorW">${content.title }</h3>
			<div class="infoArea">
				<div class="writer txtColorW">작성자 : ${content.writer }</div>
				<div class="countText">
					<span class="viewCount txtColorW" style="margin-right: 10px;">조회수
						: ${content.viewCount }</span> <span class="reply txtColorW"
						style="margin-right: 10px;">댓글수 : ${content.reply }</span>
				</div>

			</div>
			<div class="contentArea">
				<div style="margin: 0px 2px 10px 2px">${content.content }</div>
			</div>
			<div class="attachFileArea">
				<div>${attachFile }</div>
			</div>
			
			<div id="viewAllReply"></div>
			<a class="button reply-btn" href="javascript:void(0)"
		onclick="openReply();">댓글열기</a>
			
			
			<div id="replyArea" style="display: none;">
			
				<div class="input-group mb-3 input-group-lg">
					  <input type="text" class="form-control" id="reply" name="reply" placeholder="댓글달기">
				</div>
				<a class="button reply-btn" href="javascript:void(0)"
			onclick="addreply();">댓글달기</a>
				
			</div>

		</div>
	</div>
	<a class="button reply-btn" href="/notice/listAll">목록으로</a>
	<a class="button reply-btn" href="javascript:void(0)"
		onclick="modifyNotice();">수정</a>
		<a class="button reply-btn" href="javascript:void(0)"
		onclick="showAlert();">삭제</a>
	<a class="button reply-btn" href="javascript:void(0)"
		onclick="history.back();">뒤로가기</a>






	<!-- The Modal -->
	<div class="modal" id="modiModal">
		<div class="modal-dialog modal-lg modal-dialog-scrollable">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body">
					<form action="" method="POST" enctype="multipart/form-data">
						<input type="hidden" name="no" id="no" value="${content.no}"/>
					
						<div class="mb-3 mt-3">
							<label for="title" class="form-label">글 제목 : </label> 
							<input type="text" class="form-control" name="title" value="${content.title }">
						</div>
						<div class="mb-3 mt-3">
							<label for="writer" class="form-label">작성자 : </label> <input
								type="text" class="form-control" name="writer"
								value="${content.writer }">
						</div>
						<div class="mb-3 mt-3">
							<label for="comment">글 내용:</label>
							<textarea class="form-control" rows="5" id="content"
								name="content">${content.content }</textarea>
						</div>
						<div class="mb-3 mt-3">
							<div id="imgOutput"><img src='/resources/uploads/noticeBoardImg/${content.image }' style='width:100px; height:100px; overflow: auto; margin:10px'/>
							<button type='button' onclick='delFile("${content.image }");'>x</button></div>
							</div>
						<c:if test="${attachFile != null }">
							<c:forEach var="attachFile" items="${attachFile}">
								<c:choose>
									<c:when test="${attachFile.notImageFile == null }">
									<div id="${attachFile.originFile }"><img src='/resources/uploads/attachFile${attachFile.thumbnailFile }' style="width:100px; height:100px; overflow: auto; margin:10px" />
									<button type='button' onclick='delAttachFile("${attachFile.thumbnailFile}","${attachFile.notImageFile }","${attachFile.originFile }","${attachFile.attachFileNo }");'>x</button></div>
									</c:when>
									<c:otherwise>
									<div id="${attachFile.originFile }"><a href='/resources/uploads/attachFile${attachFile.notImageFile }'>첨부파일</a>"
									<button type='button' onclick='delAttachFile("${attachFile.thumbnailFile }","${attachFile.notImageFile }","${attachFile.originFile }","${attachFile.attachFileNo }");'>x</button></div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						
						<input type="hidden" name="image" id="image"/>
						</div>
						<div class="mb-3 mt-3" id="attachFileDiv">
							<div id="attachOutput"></div>
						</div>


						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#imageFileAdd">
							이미지 파일 등록</button>
						<button type="button" class="btn btn-primary"
							data-bs-toggle="modal" data-bs-target="#attachFileAdd">
							첨부 파일 등록</button>

						<button type="submit" class="btn btn-success" id="submitBtn">저장</button>
						<button type="button" class="btn btn-danger"
							onclick="writeCancle();">취소</button>
						
					</form>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="closeModal();">Close</button>
				</div>

			</div>
		</div>
	</div>

<div class="modal" id="imageFileAdd">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">이미지 등록</h4>
		
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
				

					<label for="file"></label> <input type="file" class="form-control"
						id="imageFile" name="upfile">

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">

					<button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close">완료</button>
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
				
				</div>
				
				<!-- Modal body -->
				<div class="modal-body">
						
					<label for="file"></label> <input type="file" class="form-control"
						id="attachFile" name="attachFile">

				</div>

				<!-- Modal footer -->
				<div class="modal-footer">

					<button type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close">완료</button>
				</div>

			</div>
		</div>
	</div>
<div class="modal" id="delAlert">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

      <!-- Modal body -->
      <div class="modal-body">
        ${content.no }번 공지사항을 삭제하시겠습니까?
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" onclick="location.href='/notice/deleteNotice?no=${content.no}'" >삭제</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>

	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>