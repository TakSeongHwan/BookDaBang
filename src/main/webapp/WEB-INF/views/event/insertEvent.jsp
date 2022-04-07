<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글 작성</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	function insertsumit() {
		let title = $("#title").val();
		let eventStart = $("#eventStart").val();
		let eventEnd = $("#eventEnd").val();
		let content = $("#content").val();
		
		$.ajax({
			url : url, 
			dataType : "text", 
			type : "POST",
			data : {title : title, eventStart : eventStart, eventEnd : eventEnd, content : content},
			success : function(data) {
				if(data == "Y"){
					alert("글 등록이 완료되었습니다.");
					location.href = "/event/allEventList";
				}
			},
			errpr : function (data) {
				alert("등록 실패")
				console.log(data);
			}
		});
	};
</script>
</head>
<body>
	<div class="container">
		<form method="post">
			<input type="text" placeholder="제목을 입력해주세요" id="title">
			<input type="date" id="eventStart">
			<input type="date" id="eventEnd">
			<input type="text" placeholder="본문을 입력합니다" id="content">
			<button type="button" onclick="insertsumit();">등록</button>
		</form>
	</div>
</body>
</html>