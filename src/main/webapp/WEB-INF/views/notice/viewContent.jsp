<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<jsp:include page="../userHeader.jsp"></jsp:include>
		<div class="container mt-3">
	${content }
	<textarea class="form-control" rows="5" id="comment" name="text" readonly>${content.content }</textarea>
		</div>

	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>