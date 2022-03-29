<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<script>
</script>

<style>


.infoArea{
background-color : #000000;
min-height:50px;

}
.titleArea{
background-color : #002347;
align-content: center;
margin-bottom:0px;
}
.contentArea{

margin-bottom:0px;
min-height : 450px;
background-color: #feffff;
 padding: 15px 10px 2px 10px;

}

.contentContainer{
min-height : 800px;
}

.txtColorW{
color:white;
padding-left:5px;

}
.writer{
margin:10px;
display:inline-block;
}
.countText{
margin:10px;

float:right;
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
					<div class="writer txtColorW" >작성자 : ${content.writer }</div>
					<div class="countText">
						<span class="viewCount txtColorW" style="margin-right:10px;">조회수 : ${content.viewCount }</span>
						<span class="reply txtColorW" style="margin-right:10px;">댓글수 : ${content.reply }</span>
					</div>
					
				</div>
				<div class="contentArea">
					<div style="margin:0px 2px 10px 2px">${content.content }</div>
				</div>
				<div class="replyArea">
					<div></div>
				</div>
				
			</div>
		</div>
	    <a class="button reply-btn" href="/notice/listAll">목록으로</a>
  		<a class="button reply-btn" href="javascript:void()" onclick="history.back();">뒤로가기</a>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>