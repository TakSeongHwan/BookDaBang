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


$(function() {
	
	
	if(check == 1){
		$('#heartN').show();
	}else{
		$('#heartY').show();
	}
	
	
	
});

// 신고
function report() {
	let why = $("#why").val();
	console.log(boardno, why);
	
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
						
						alert("완료");
					}
				}
			});
		}
		
	}
	
	
	
	
	

function removeFreeBoard(boardno) {
	
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
				alert("완료");
				location.href ="/board/listAllFreeBoard";
				
			}
		}
	});
}

/* //좋아요 검사
function likeCheck(){
	$.ajax({
		url : '/lbr/board/likeCheck?boardno=' + boardno,
		type : "GET",
		success : function(data) {
			alert(data);
		}
	});	
}
 */

//게시물 좋아요
function likeBoard(gubun){
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
	margin-left:150px; 
	
	
}

#btn4 {
	margin: 20px;
	float: right;
	padding: 10px;
	
}
</style>
<title>Insert title here</title>
</head>

<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>



	<div class="container">
	<div class="comment-form">
		<h4>${freeBoard.boardno}</h4>
		<div class="mb-3 mt-3">
			<input type="text" class="form-control" id="title" name="title" readonly="readonly" value=" 제목 : ${freeBoard.title}">
					</div>
		<div class="mb-3">
				<input type="text" class="form-control" id="writer" name="writer" readonly="readonly" value="작성자  : ${freeBoard.writer}"/>
			</div>
			<div class="mb-3">
			<textarea class="form-control" rows="10" id="content" name="content" readonly="readonly" >내용  : ${freeBoard.content }
				
			</textarea>
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
				
		<div id=heart style="float: left; margin-left: 30px;">	
		<div id="heartY" style="display:none">
			<a href="" onclick="likeBoard('Y');"><img alt="emptyHeart" src="/resources/img/board/emptyHeart.png"></a>
		</div>
		<div id="heartN" style="display: none">
			<a href="" onclick="likeBoard('N');"><img alt="Heart" src="/resources/img/board/Heart.png"></a>	
		</div>
		</div>
		<button class="button button-postComment button--active" type="button" data-bs-target="#myModal" data-bs-toggle="modal" id="btn1">신고하기</button>
		<button class="button button-postComment button--active" type="button" id="btn4" onclick="removeFreeBoard(${freeBoard.boardno });">삭제하기</button>
		<button class="button button-postComment button--active" type="button" id="btn2" onclick="">수정하기</button>
		<button class="button button-postComment button--active" type="button" id="btn3" onclick="location.href='/board/listAllFreeBoard';">목록</button>
		
	
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
       		<div>신고할 글 제목 : ${freeBoard.title } </div>
       		       		신고 사유 :  <input type="text" placeholder="사유를 꼭 작성해주세요" id="why"/>
       		
       	
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
      
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" onclick="report();">신고하기</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
      </div>
      </form>
      
      </div>
      </div>
      </div>
      <jsp:include page="../userFooter.jsp"></jsp:include>
      </body>
      </html>
    



			