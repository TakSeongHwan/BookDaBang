<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
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

console.log("이것도 안되니?" + ses);



</script>

<body>
	<jsp:include page="userHeader.jsp"></jsp:include>
<<<<<<< HEAD
		<div> <button type="button" class="btn">${ sessionId}</button>
<button type="button" class="btn btn-primary">${loginMember.userName}</button>
<button type="button" class="btn btn-secondary">${ sessionId}</button>
<button type="button" class="btn btn-success">Success</button>
<button type="button" class="btn btn-info">Info</button>
<button type="button" class="btn btn-warning">Warning</button>
<button type="button" class="btn btn-danger">Danger</button>
<button type="button" class="btn btn-dark">Dark</button>
<button type="button" class="btn btn-light">Light</button>
<button type="button" class="btn btn-link">Link</button> </div>
=======
	<div>
		<button type="button" class="btn">Basic</button>
		<button type="button" class="btn btn-primary">Primary</button>
		<button type="button" class="btn btn-secondary">Secondary</button>
		<button type="button" class="btn btn-success">Success</button>
		<button type="button" class="btn btn-info">Info</button>
		<button type="button" class="btn btn-warning">Warning</button>
		<button type="button" class="btn btn-danger">Danger</button>
		<button type="button" class="btn btn-dark">Dark</button>
		<button type="button" class="btn btn-light">Light</button>
		<button type="button" class="btn btn-link">Link</button>
	</div>
>>>>>>> KHN
	<jsp:include page="userFooter.jsp"></jsp:include>
</body>
</html>