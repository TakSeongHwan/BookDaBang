<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<jsp:include page="projectHeader.jsp"></jsp:include>
<P>  The time on the server is ${serverTime}. </P>
<jsp:include page="projectFooter.jsp"></jsp:include>
</body>
</html>
