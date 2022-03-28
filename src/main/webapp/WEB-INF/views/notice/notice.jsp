<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	
});
function showContent(obj){
	let no = $(obj).attr("id");
	location.href="/notice/viewContent?no="+no;
}

</script>
</head>
<body>
<jsp:include page="../userHeader.jsp"></jsp:include>
		<div class="container mt-3">
	<h1 style="margin:20px; margin-bottom:20px;">공 지 사 항</h1>
  <table class="table table-hover">
    <thead style="background-color:#002347; color:#fff">
      <tr>
    
        <th>제목</th>
        <th>작성자</th>
         <th>작성일자</th>
          <th>조회수</th>
           <th>댓글 수</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach var="notice" items="${notice }">
      <tr id="${notice.no}" onclick="showContent(this);">
       
        <td>${notice.title}</td>
        <td>${notice.writer}</td>
         <td>${notice.writedDate}</td>
        <td>${notice.viewCount}</td>
        <td>${notice.reply}</td>
      </tr>
     </c:forEach>
    </tbody>
  </table>
</div>

	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>