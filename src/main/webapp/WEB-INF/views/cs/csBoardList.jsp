<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
.container{
margin-top:20px;
margin-bottom: 20px;
}

</style>
<script>

function movePage(no) {
	
	let pno = no
	
	if ("${ sessionId}" != null ) {
		
		location.href="${ contextPath}/cs/readPost?no=" + no + "&u=${ sessionId}";
		
	} else {
		
		location.href="${ contextPath}/cs/readPost?no=" + no;
		
	}
	
	
	
}

</script>
</head>
<body>
<jsp:include page="../userHeader.jsp"></jsp:include>
<div class="container mt-3">
	<h1 style="margin:20px; margin-bottom:20px;">고객센터</h1>
  <table class="table table-hover">
    <thead style="background-color:#fafaff;">
      <tr>
    		<th>No</th>
    		<th>말머리</th>
        	<th>제목</th>
        	<th>작성자</th>
         	<th>작성일자</th>  	
      </tr>
    </thead>
    <tbody>
    <c:forEach var="csBoard" items="${boardList }">
      <tr id="${csBoard.postNo}" onclick='movePage(${csBoard.postNo});'>
        <td>${csBoard.postNo}</td>
        <td>${csBoard.categoryCode}</td>
        <td>${csBoard.title}</td>
        <td>${csBoard.writer}</td>
        <td>${csBoard.postdate}</td>
      </tr>
     </c:forEach>
    </tbody>
  	</table>
  	<button class="button button-header" onclick='location.href="${ contextPath}/cs/write?u=${ sessionId}"'>글쓰기</button>
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>