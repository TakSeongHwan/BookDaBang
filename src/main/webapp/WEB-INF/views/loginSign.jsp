<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
let ses = "${ sessionId}"
location.href="/ljs/?u=" + ses;



</script>
<body>
${ loginMember.userId}
${ loginMember.userName}
</body>
</html>