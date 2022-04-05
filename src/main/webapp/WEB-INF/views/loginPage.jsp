<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		location.href = "/ljs/login"
		console.log(sessionId)
	} else {
		console.log(sessionId)
		location.href = "/ljs/"
	}
	
}

</script>
<body>

</body>
</html>