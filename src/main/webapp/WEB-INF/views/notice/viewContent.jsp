<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>
	let attachCount = 0;
	let formData = new FormData();
	$(document).ready(function() {

		showAllReply();

		$("#imageFile").change(function() {
			let upfile = this.files[0];
			let fileName = upfile.name;

			let imgExt = [ "jpg", "gif", "jpeg", "png", "jfif" ];
			let fileExt = fileName.split(".")[1];
			let imgCheck = false;

			for ( let i in imgExt) {
				if (fileExt == imgExt[i]) {
					console.log("이미지파일");
					imgCheck = true;
					formData.append("imageFile", upfile);
					
					let existingImg = "<span id='existingImg'>"+fileName+"</span>";
					existingImg += '<button type="button" class="btn rounded-pill btn-icon btn-outline-secondary" onclick="delFile();">x</button>'

				}
			}
			if (!imgCheck) {
				alert("이미지 파일만 업로드 가능합니다!");
			}
		});

		$("#attachFile").change(function() {

			let upfile = this.files[0];
			let fileName = upfile.name;
			console.log(upfile);

			formData.append("upfile" + attachCount, upfile);
			attachCount++;

		});
		
		$("#reply").click(function() {
			let sessionId="${sessionId}";
			let getUserIdUrl = "${pageContext.request.contextPath}/notice/getUserId"
				
				$.ajax({
						url : getUserIdUrl, 
						dataType : "json", 
						type : "GET",
						data : {
							sessionId : sessionId
							
						},
						success : function(data) { 
							console.log(data.userId);
							if(data.userId != null){
								$("#writer").val(data.userId);
							}else{
								location.href="${pageContext.request.contextPath}/login";
							}
							
						}, error: function(e){
							console.log(e.responseText);
							
						}
					});
		});
		

	});

	function delFile() {
		$("#imgOutput").empty();
	}
	function delAttachFile(attachFileNo) {
		console.log(attachFileNo);

	}

	function modifyNotice() {
		$("#modiModal").show(200);

	}
	function closeModal() {
		$("#modiModal").hide(0);
	}
	function showAlert() {

		$("#delAlert").show(200);
	}
	function addreply() {
		let reply = $("#reply").val();
		console.log(reply);
		let writer = $("#writer").val();
		console.log(writer)
		let no = "${content.no}"

		let sendData = JSON.stringify({
			boardNo : no,
			replyer : writer,
			replyContent : reply
		});

		let url = "${pageContext.request.contextPath}/noticeReply/addReply";
		$.ajax({
			url : url,
			dataType : "text",
			type : "POST",
			data : sendData,
			headers : {
				"content-type" : "application/json",
				"x-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
		
				if (data == "success") {
				
					showAllReply();//현재 글의 모든 댓글을 가져와 화면에 출력
				} else if (data == "fail") {
					alert("댓글 등록 실패!");
				}

			},
			error : function(e) {
				console.log(e.responseText);

			}
		});
	}
	function showAllReply() {

		let boardNo = "${content.no}"
		let url = "${pageContext.request.contextPath}/noticeReply/all/" + boardNo;
		$.ajax({
			url : url,
			dataType : "JSON",
			type : "GET",
			success : function(data) {
				console.log(data);
				replyList = data;
				if (data != null) {
					parseData(data);

				}

			}
		});
	}

	function parseData(data) {
		$("#viewAllReply").empty();
		let output = '<div class="list-group" style="border:10px;">'
		$
				.each(
						data,
						function(i, e) {
							output += '<div class="single-comment justify-content-between replyItems" id="div'+e.replyNo+'">';
							
							output += '<div>';
							if(e.step > 0){
								for(let count = 0; count < e.step; count++){
									output+= '<img src="${pageContext.request.contextPath}/resources/img/reply.png" width="20px"/>'
								}
									
								
							}
							output += '<div id="rep'+e.replyNo+'">'
									+ e.replyer + '</div>';
							output += '<div> 댓글 내용 : ' + e.replyContent
									+ '</div>';
							output += '<div>'+ formatDate(e.replyDate)
									+ '</div>';
							output += '<div style="float:right; margin-right:10px; margin-bottom:5px;">'
									+ "<img src='${pageContext.request.contextPath}/resources/img/addrereply.png' width='20px' style='margin-right:10px;' onclick='showRereplyModal("
									+ e.replyNo + ");'/>";
							output += "<img src='${pageContext.request.contextPath}/resources/img/correct.png' width='20px' style='margin-right:10px;' onclick='showReplyModify("
									+ e.replyNo + ");'/>";
							output += "<img src='${pageContext.request.contextPath}/resources/img/delete.png' width='20px' onclick='showReplyDelete("
									+ e.replyNo + ");'/>";
							output += '</div>';
							output += '</div></div>';
						});

		output += '</div>'

		$("#viewAllReply").append(output);

	}
	function showReplyDelete(replyNo) {
		let output = '<div class="modal-dialog modal-sm"><div class="modal-content"><div class="modal-body">댓글을 삭제하시겠습니까?</div>';
		output += '<div class="modal-footer"><button type="button" class="btn btn-danger" onclick="deleteReply('
				+ replyNo
				+ ');">삭제</button><button type="button" class="btn btn-primary" onclick="closeModal();">닫기</button></div></div></div>'
		$("#deleteModal").html(output);

		$("#deleteModal").show(200);

	}
	function showReplyModify(replyNo) {
		let output = '<div class="modal-dialog modal-sm"><div class="modal-content"><div class="modal-body">댓글 내용 수정 : <input type="text" id="replyContent"name="content"/></div>';
		output += '<div class="modal-footer"><button type="button" class="btn btn-danger" onclick="modiReply('
				+ replyNo
				+ ');">수정</button><button type="button" class="btn btn-primary" onclick="closeModiReplyModal();">닫기</button></div></div></div>'
		$("#modiReplyModal").html(output);

		$("#modiReplyModal").show(200);

	}
	function deleteReply(replyNo) {
		let url = "${pageContext.request.contextPath}/noticeReply/" + replyNo;
		$.ajax({
			url : url,
			dataType : "text",
			type : "DELETE",
			headers : {
				"content-type" : "application/json",
				"x-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				console.log(data);
				$("#deleteModal").hide();
				showAllReply();

			}
		});

	}
	function modiReply(replyNo) {
		let url = "${pageContext.request.contextPath}/noticeReply/" + replyNo;
		let content = $("#replyContent").val();
		let boardNo = $
		{
			content.no
		}
		console.log(content);
		let sendData = JSON.stringify({
			replyNo : replyNo,
			replyContent : content,
			replyer : "cat",//로그인한 유저 아이디값 받아오기
			boardNo : boardNo

		});
		$.ajax({
			url : url,
			dataType : "text",
			data : sendData,
			type : "PUT",
			headers : {
				"content-type" : "application/json",
				"x-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				if (data == "success") {
					console.log(data);
					$("#modiReplyModal").hide();
					showAllReply();
				} else if (data == "fail") {
					alert("댓글 수정에 실패하였습니다.")
				}

			}
		});
	}
	function closeModiModal() {
		$("#modiModal").hide();
		location.href="${pageContext.request.contextPath}/notice/viewContent?no="+${content.no}
	}
	function closeModiReplyModal(){
		$("#modiReplyModal").hide();
		
	}
	function closeModal() {
		$("#deleteModal").hide();
	}
	function formatDate(date) {

		let diff = new Date() - date;
		let diffs = diff / 1000;
		if (diffs < 60 * 5) {
			return '<span class="badge" style="color:#fff; background-color:#384aeb">방금 전</span>';
		}
		let diffm = diffs / 60;
		if (diffm < 60) {
			return '<span class="badge" style="color:#fff; background-color:#384aeb">'
					+ Math.floor(diffm) + '분 전</span>';
		}
		return '<span class="badge" style="color:#fff; background-color:#384aeb">'
				+ new Date(date).toLocaleString() + '</span>';
	}
	function showRereplyModal(replyNo) {
		let output = '<div class="modal-dialog modal-sm"><div class="modal-content"><div class="modal-body">대댓글 입력 : <input type="text" id="rereplyContent" name="replyContent"/><input type="hidden" id ="rereplyer" name="replyer" value="cat"/></div>';
		output += '<div class="modal-footer"><button type="button" class="btn btn-danger" onclick="insertRereply('
				+ replyNo+ ');">입력</button><button type="button" class="btn btn-primary" onclick="closRereplyModal();">닫기</button></div></div></div>'
		//댓글단사람은 로그인한 유저 아이디값 받아와서 채워주기
		$("#rereplyModal").html(output);

		$("#rereplyModal").show(200);

	}
	function closRereplyModal(){
		$("#rereplyModal").hide();
	}
	function insertRereply(replyNo){
		
		let url = "${pageContext.request.contextPath}/noticeReply/rereply";
		
		let replyer = $("#rereplyer").val();
		let replyContent = $("#rereplyContent").val();
		let boardNo = ${content.no}
		
		let sendData = JSON.stringify({
			replyNo : replyNo,
			replyContent : replyContent,
			replyer : replyer,//로그인한 유저 아이디값 받아오기
			ref : replyNo,
			boardNo : boardNo
		});
		
		
		$.ajax({
			url : url,
			dataType : "text",
			data : sendData,
			type : "POST",
			headers : {
				"content-type" : "application/json",
				"x-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				if (data == "success") {
					console.log(data);
					$("#rereplyModal").hide();
					showAllReply();
				} else if (data == "fail") {
					alert("대댓글 등록에 실패하였습니다.")
				}

			}
		});
		
	}
	
	
</script>

<style>
#modiModal {
	z-index: 20000;
}

.contentArea {
	margin-bottom: 0px;
	min-height: 450px;
	background-color:#fff;
	padding: 15px 10px 2px 10px;
}

#replyArea{
margin-top : 20px;
border: 5px solid #fff;


}

.replyItems{
border: 1px solid #fff;
padding-left: 10px;
}

.contentContainer {
	min-height: 800px;
}

.titleArea{
margin-top : 15px;
margin-bottom: 20px;
}

.writer {

	display: inline-block;
}

.countText {
	margin: 10px;
	float: right;
}

#replyInputArea{
margin: 10px 0px;
}

#buttonGroup{
margin:30px 0px 0px 0px;
}
#attachFileAdd{
z-index: 22000;
}
#imageFileAdd{
z-index: 22000;
}
</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container comments-area contentContainer">
	<div class="titleArea">
	<h3>${content.title }</h3>
			<div class="infoArea">
				<div class="writer">작성자 : ${content.writer }</div>
				<div class="countText">
					<span class="viewCount" style="margin-right: 10px;">조회수
						: ${content.viewCount }</span> <span class="reply"
						style="margin-right: 10px;">댓글수 : ${content.reply }</span>
				</div>

			</div>
	</div>
		<div class="contentContainer">
			
			<div class="contentArea">
				<div style="margin: 0px 2px 10px 2px">${content.content }</div>
			<div class="imgFileArea">
			<c:if test="${content.image != null }">
				<img src='/resources/uploads/noticeBoardImg/${content.image }' style="margin: 10px" />
			</c:if>				
			</div>
									
			<div class="attachFileArea">
				<c:if test="${attachFile != null }">
					<c:forEach var="attachFile" items="${attachFile}">
						<c:choose>
							<c:when test="${attachFile.notImageFile == null }">
								<img
									src='/resources/uploads/attachFile${attachFile.thumbnailFile }'
									style="width: 100px; height: 100px; overflow: auto; margin: 10px" />
							</c:when>
							<c:otherwise>
								<a
									href='/resources/uploads/attachFile${attachFile.notImageFile }'>첨부파일</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</div>


		</div>
		
		<div id="buttonGroup">
			<a class="button button-header" href="${pageContext.request.contextPath}/notice/listAll">목록으로</a><a
				class="button button-header" href="javascript:void(0)"
				onclick="history.back();">뒤로가기</a>
				 <a
				class="button button-header" href="javascript:void(0)"
				onclick="modifyNotice();">수정</a> <a class="button button-header"
				href="javascript:void(0)" onclick="showAlert();">삭제</a> 
		</div>

		<div id="replyContainer">
			<div id="replyArea">
				<div id="viewAllReply"></div>
			</div>
			<div id="replyInputArea">
					<div style="display: inline-block; width: 85%;">
						<input type="text" class="form-control" id="reply" name="reply"
							placeholder="댓글을 입력하세요">
							<input type="hidden" id="writer"/>
					</div>

					<a class="button button-header"
						href="javascript:void(0)" onclick="addreply();">댓글달기</a>
			</div>
		</div>
	</div>
		
	</div>




	<!-- The Modal -->
	<div class="modal" id="modiModal">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
                    <h5 class="modal-title" id="modalTopTitle">공지사항 수정</h5>
  				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form action="${pageContext.request.contextPath}/notice/updateNotice" method="POST" enctype="multipart/form-data">
						<input type="hidden" name="no" id="no" value="${content.no}" />

						<div class="mb-3 mt-3">
							<label for="title" class="form-label">글 제목 : </label> <input
								type="text" class="form-control" name="title"
								value="${content.title }">
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
							<div id="imgOutput">
								<c:if test="${content.image != null }">
								
									<span>${content.image }</span>
										<button type='button' class="btn rounded-pill btn-icon btn-outline-secondary"
													onclick='delFile();'>x</button>
													
							
								</c:if>
							</div>
						</div>
						<div id="existingAttachFile">
						<c:if test="${attachFile != null }">
							<c:forEach var="attachFile" items="${attachFile}">
								<c:choose>
									<c:when test="${attachFile.notImageFile == null }">
										<div id="existingAttachImg${attachFile.attachFileNo }">
											<span>${attachFile.thumbnailFile }</span>
											
											<button type='button' class="btn rounded-pill btn-icon btn-outline-secondary"
												onclick='delAttachFile("${attachFile.attachFileNo }");'>x</button>
										
									</c:when>
									<c:otherwise>
										<div id="existingAttachNotImg${attachFile.attachFileNo }">
										<span>/resources/uploads/attachFile${attachFile.notImageFile }</span>
											<button type='button' class="btn rounded-pill btn-icon btn-outline-secondary" 
												onclick='delAttachFile("${attachFile.attachFileNo }");'>x</button>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						</div>
						<input type="hidden" name="image" id="image" />
				</div>
				<div class="mb-3 mt-3" id="attachFileDiv">
					<div id="attachOutput"></div>
				</div>

				
				<button type="button" class="button button-blog" data-bs-toggle="modal"
					data-bs-target="#imageFileAdd">이미지 파일 등록</button>
				<button type="button" class="button button-blog" data-bs-toggle="modal"
					data-bs-target="#attachFileAdd">첨부 파일 등록</button>

				<button type="submit" class="button button-blog" id="submitBtn">저장</button>
				<button type="reset" class="button button-blog"
					onclick="closeModiModal();">취소</button>
				
				</form>
			</div>

		</div>
	</div>
	</div>

	<div class="modal" id="imageFileAdd">
		<div class="modal-dialog modal-sm modal-dialog-centered">
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

					<button type="button" class="button button-header"
						data-bs-dismiss="modal" aria-label="Close">완료</button>
				</div>

			</div>
		</div>
	</div>
	<div class="modal" id="attachFileAdd">
		<div class="modal-dialog modal-sm modal-dialog-centered">
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

					<button type="button" class="button button-header"
						data-bs-dismiss="modal" aria-label="Close">완료</button>
				</div>

			</div>
		</div>
	</div>
	<div class="modal" id="delAlert">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">

				<!-- Modal body -->
				<div class="modal-body">${content.no }번공지사항을 삭제하시겠습니까?</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="button button-header"
						onclick="location.href='${pageContext.request.contextPath}/notice/deleteNotice?no=${content.no}'">삭제</button>
					<button type="button" class="button button-header"
						data-bs-dismiss="modal">닫기</button>
				</div>

			</div>
		</div>
	</div>

	<div class="modal" id="deleteModal"></div>
	<div class="modal" id="modiReplyModal"></div>
	<div class="modal" id="rereplyModal"></div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>