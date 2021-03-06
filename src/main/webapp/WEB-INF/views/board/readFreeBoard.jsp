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
let boardno = ${freeBoard.boardno};
let check = ${check};
let reportCheck = ${reportCheck};
let userId = '${mem.userId}';
let writer = '${freeBoard.writer}';

$(function() {
   
   console.log(reportCheck);
   readComment();
   console.log(userId);
   //console.log(writer);
   
   let notImgFiles = document.getElementsByClassName("notImgFile");
   console.log(notImgFiles);

   $(".notImgFile").each(
         function(i, tag) {
            let tmpFileName = $(tag).attr("href");
            // console.log(tmpFileName);
            let fileName = tmpFileName.substring(tmpFileName
                  .lastIndexOf("/") + 1);
            $(tag).text(fileName);
         });


   
   if(check == 1){
      $('#heartN').show();
   }else{
      $('#heartY').show();
   }
   
   if(userId == writer){
      $('#btn2').show();
      $('#btn4').show();
   }
   
   if(userId != ''){
      $('#btn1').show();
   }
});

$("#btn2").onclick(function() {
	alert("!");
})



// 신고
function report() {
   
   
   let why = $("#why").val();
   console.log(boardno, why);
      
if(writer == userId){
   alert("본인글은 신고 불가");
   $("#why").val('');
} else {
   
   if (reportCheck == 1){
      alert("이미 신고한 게시물입니다.");
      $("#why").val('');
      location.reload();
   } else {
      if(why == ""){
         alert("신고사유를 작성해주세요");
         } else {
         let url = "/board/insertReportBoard";   
         $.ajax({
            url : url,
            data : {
               why : why,
               boardno : boardno         
            },
            dataType : "text", // 수신될 데이터 타입
            type : "post",
            success : function(data) {
               if(data == "success"){
                  alert("신고완료..")
                  $("#why").val('');
                  location.reload();
               }
            }
         });
      }
   
}
   
   

   
   
}
   
   
      

      
   }
   


   
   
function insertComment() {
   let no = parseInt(boardno);
   let content = $("#commentContent").val();
   console.log(boardno, content);
   let writer = userId;
   if(userId == ''){
      if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?") == true){
         $("#commentContent").val('');
         location.href="/login";
      }
   }else{
   let url = '/comment';
   let sendData = JSON.stringify({
      boardno : no, commentwriter : writer, commentcontent : content
   });
   
   
  
	 if($("#commentContent").val() == ""){
		 alert("댓글을 입력해주세요!");
	 }else{
  
   $.ajax({
      url : url,
      data : sendData,
      dataType : "text",
      type : "post",
      headers : {
         "content-type" : "application/json",
         "X-HTTP-Method-Override" : "POST"
      },
      success : function (data) {
         console.log(data);   
         if(data == "success") {
            alert("댓글달기성공");
            readComment();
            $("#commentContent").val('');
            console.log(content);
         } else if(data == "fail") { 
            alert("댓글등록실패");
         }
         
         
      }
      
      
   });
	 }
   
}
}


function readComment() {
   
   let url = "/comment/read/" + boardno;
   
   $.ajax({
      url : url,
      dataType : "json",
      type : "get",
      success : function (data) {
         console.log(data);   
         if (data != null) {
            console.log(data);
            viewComment(data);
         }
      }
   });
}

 // 댓글보기 
function viewComment(data) {
   console.log(data);
   
   $("#commentList").empty();
   let output = '<div class="list-group">';
   $.each(data, function(i, e) {
         output += '<ul id="'+ e.commentno + '" class="list-group-item list-group-item-action replyItems">';
         output += '<div>';
         output += '<div><div id="rep' + e.commentno+ '" style="float:left;">' + e.commentwriter + '</div>';
         output += '<br><div style="float:left;">내용 : ' + e.commentcontent + '</div>';
         let writtenDate = calcDate(e.commentdate);
         output += '<br><div style="float:left;">(작성일 : ' + writtenDate + ')</div></div>';
         output += "<div style='float:right; margin-right : 10px;'>"+
         "<img src ='/resources/img/board/commentModify.png' width='20px'onclick='showModiComment("+e.commentno + ");' />"
         + "<img src ='/resources/img/board/commentRemove.png' width='20px' onclick='showDelComment("+e.commentno + ");' />"
         output += "</div></div></ul>";
      });
   
   output += '</div>';
   $("#commentList").html(output);
}


 
function showModiComment(cno) {
   if(userId == ('')){
      if(confirm("로그인이 필요합니다. 로그인하시겠습니까?") == true){
         location.href="/login/";
      }
      
   }else if(isConfirmUser(cno)){
         $("#modiCommentDiv").insertAfter($("#" + cno));
         $("#modifCommentNo").val(cno);
         $("#modiCommentDiv").show();
      
      } 
   }

   

function isConfirmUser(cno) {
   let commentwriter = $('#rep' + cno).text();
      if(userId != commentwriter) {
         alert("댓글 수정 및 삭제는 본인 댓글만 허용");
         return false;
      }
   
   
   return true;
}


function modiComment() {
   let cno = $("#modifCommentNo").val();
   let commentContent = $("#modyComment").val();
   let sendData = JSON.stringify({
      commentno : cno, commentcontent : commentContent
   });
   
   let url = '/comment/'+ cno  
   
   
   if($("#modyComment").val()==""){
	   alert("수정할 댓글을 입력해주세요!");
   }else{
   $.ajax({
      url : url,
      data : sendData,
      dataType : "text",
      type : "put",
      headers : {
         "content-type" : "application/json",
         "X-HTTP-Method-Override" : "POST"
      },
      success : function (data) {
         console.log(data);   
         if(data == "success") {
        	window.location.reload();
            readComment();
            
            
         } else if(data == "fail") { 
            alert("댓글수정실패");
         }

      }

   });
   }
   
}

function cancelModiComment() {
   
   $("#modiCommentDiv").hide();
   $("#modyComment").val('');
}


function rc(){
   $("#why").val('');
}

function showDelComment(cno) {
   
if(userId == ('')){
   if(confirm("로그인이 필요합니다. 로그인 하시겠습니까?") == true){
      location.href="/login/";
   }
}else{
   if(isConfirmUser(cno)){
   if(confirm('댓글을 삭제하시겠습니까?') == true){
      let url ='/comment/' + cno
      $.ajax({
         url : url,
         dataType : "text",
         type : "delete",
         headers : {
            "content-type" : "application/json",
            "X-HTTP-Method-Override" : "POST"
         },
         success : function (data) {
            console.log(data);   
            if(data == "success") {
               alert("댓글삭제!");
               window.location.reload();
               readComment(); 
            } else if(data == "fail") { 
               alert("댓글삭제실패");
            }

         }

      });      
   }else{
      alert('댓글삭제가 취소되었습니다.');
      return false;
   }
}
}
}



function removeFreeBoard(boardno) {
   
   if(confirm('글을 삭제하시겠습니까?') == true){
   let url = "/board/removeFreeBoard";
   
   $.ajax({
      url : url,
      data : {
         boardno : boardno         
      },
      dataType : "text", // 수신될 데이터 타입
      type : "post",
      success : function(data) {
         if(data == "success"){
            alert("게시물이 삭제되었습니다. 복구 가능");
            location.href ="/board/listAllFreeBoard";
            
         }
      }
   });
   }
}

function calcDate(rd) {
   
   let diff = new Date() - rd; 
   let diffSecond = diff / 1000; 
   if(diffSecond < 60 * 5) return '방금전';
   let diffMiniutes = diffSecond / 60; 
   if(diffMiniutes < 60) return Math.floor(diffMiniutes) + '분전';
   return new Date(rd).toLocaleString();
}

//게시물 좋아요
function likeBoard(gubun){
   if(userId != ''){
      
      $.ajax({
         url : '/board/likeFreeBoard',
         data : {
            gubun : gubun,
            boardno : boardno         
         },      
         type : "post",
         success : function(data) {
            console.log(data)
            if(data == "success"){
               alert("완료");
            }
         }
      });   
      
   } else{
      alert("로그인 후 이용해주세요");
     
      
   }
   
   
}

function update() {
	let content = "${freeBoard.content }";
	console.log(content);
	if(content=="신고처리가 된 글입니다"){
		alert("신고처리가 된 글은 수정할수없습니다.");
	}else{
	location.href='/board/modifyFreeBoard?boardno='+${freeBoard.boardno };
	}
}


</script>
<style>
.list-group li {
	margin: 20px;
	font-size: 15px;
}

#btn1 {
	margin-top: 20px;
	background-color: white;
	color: red;
	border-color: red;
	float: right;
	padding: 10px;
}

#btn2 {
	margin-top: 20px;
	float: right;
	padding: 10px;
}

#btn3 {
	margin-top: 20px;
	margin-left: 100px;
}

#btn4 {
	margin: 20px;
	float: right;
	padding: 10px;
}

.replyItems {
	margin-top: 20px;
	overflow: auto;
}

#commentList {
	margin-top: 40px;
}

#modiImg {
	margin-right: 15px;
}
</style>
<title>Insert title here</title>
</head>

<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>



	<div class="container">
		<div class="comment-form">
			<h4>${freeBoard.boardno}</h4>
			<div id=heart style="float: right; margin-left: 30px;">
				<div id="heartY" style="display: none">
					<a href="" onclick="likeBoard('Y');"><img alt="emptyHeart"
						src="/resources/img/board/emptyHeart.png"></a>
				</div>
				<div id="heartN" style="display: none">
					<a href="" onclick="likeBoard('N');"><img alt="Heart"
						src="/resources/img/board/Heart.png"></a>
				</div>
			</div>
			<div class="mb-3 mt-3">
				<input type="text" class="form-control" id="title" name="title"
					readonly="readonly" value=" 제목 : ${freeBoard.title}">
			</div>
			<div class="mb-3">
				<input type="text" class="form-control" id="writer" name="writer"
					readonly="readonly" value="작성자  : ${freeBoard.writer}" />
			</div>
			<div class="mb-3">
				<textarea class="form-control" rows="10" id="content" name="content"
					readonly="readonly">내용  : ${freeBoard.content }</textarea>


				<c:if test="${fileLst != null}">
					<div class="mb-3" style="float: left; margin-top: 20px;">
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


			<button class="button button-postComment button--active"
				type="button" id="btn2" style="display: none;" onclick="update();">수정하기</button>
			<button class="button button-postComment button--active"
				type="button" id="btn4" style="display: none;"
				onclick="removeFreeBoard(${freeBoard.boardno });">삭제하기</button>



			<div id=siren style="float: right; margin-left: 30px;">
				<div id="btn1" style="display: none;" data-bs-target="#myModal"
					data-bs-toggle="modal">
					<img alt="siren" src="/resources/img/board/siren.png">
				</div>
			</div>





			<div class="mb-3" style="clear: both;">

				<textarea class="form-control" rows="5" id="commentContent"
					name="text" style="border-color: #ADD8E6;"></textarea>

			</div>

			<button class="button button-postComment button--active"
				type="button" id="comment" onclick="insertComment();"
				style="padding: 5px; float: right;">댓글등록</button>
			<div id="commentList"></div>






			<button class="button button-postComment button--active"
				type="button" id="btn3"
				onclick="location.href ='/board/listAllFreeBoard';">목록</button>
		</div>

	</div>


	<div class="modal" id="myModal" style="margin-top: 60px;">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">게시물 신고</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<form method="post" action="/board/insertReportBoard">
					<div class="modal-body">

						<div>신고할 글 번호 : ${freeBoard.boardno }</div>
						<div>신고할 글 제목 : ${freeBoard.title }</div>
						신고 사유 : <input type="text" placeholder="사유를 꼭 작성해주세요" id="why" />


					</div>

					<!-- Modal footer -->
					<div class="modal-footer">

						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal" onclick="report();">신고하기</button>
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal" onclick="rc();">취소</button>
					</div>
				</form>

			</div>
		</div>
	</div>

	<div id="modiCommentDiv" style="display: none;">
		<input type="hidden" id="modifCommentNo" />
		<textarea class="form-control" rows="5" id="modyComment"
			name="modyComment" style="border-color: #ADD8E6; margin-top: 10px;"></textarea>

		<button class="button button-postComment button--active" type="button"
			id="cancelModiComment" onclick="cancelModiComment();"
			style="padding: 5px; float: right; margin-left: 10px;">취소</button>
		<button class="button button-postComment button--active" type="button"
			id="modiComment" onclick="modiComment();"
			style="float: right; padding: 5px;">댓글수정</button>

	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>



