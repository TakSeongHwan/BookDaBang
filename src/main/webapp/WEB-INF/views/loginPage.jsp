<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
window.onload = function () {
	let sessionId = "${ sessionId}"
	
	if (sessionId == "" || null) {
		location.href = "${ contextPath}/login"
		console.log(sessionId)
	} else {
		console.log(sessionId)
		location.href = "${ contextPath}/"
		
	}
	
}

</script>
<body>

</body>
</html>