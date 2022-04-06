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
	// 여기로 넘어온다는 건 쿠키가 없다는 뜻, 사용자 화면이 아닌 URL을 직접 쳐서 들어왔을 경우.
	
	let sessionId = "${ sessionId}"
	
	if (sessionId == "" || null) {
		location.href = "${ contextPath}/login"
		
	} else {
			location.href = "${ contextPath}/?u=" + sessionId // 세션 아이디 들고 홈으로 가라
					
		} 
				
	}


</script>
<body>

</body>
</html>