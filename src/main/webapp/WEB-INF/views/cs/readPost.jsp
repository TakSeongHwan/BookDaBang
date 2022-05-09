<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="/resources/js/myLib.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<style>
.list-group li {
   margin: 20px;
   font-size: 15px;
}

#btn1 {
   margin-top: 20px;
   background-color: white;
   color: red;
   border-color: red;
   float: right;
   padding: 10px;
}

#btn2 {
   margin-top: 20px;
   float: right;
   padding: 10px;
}

#btn3 {
   margin-top: 20px;
   margin-left: 150px;
}

#btn4 {
   margin: 20px;
   float: right;
   padding: 10px;
}
</style>
<script>

function modifyPost() {
	
	
	
}

</script>
<title>Insert title here</title>
</head>

<body>
   <jsp:include page="../userHeader.jsp"></jsp:include>
   
   <div class="container">
   <div class="comment-form">
   <h4>${csBoard.postNo}</h4>
   <div class="mb-3 mt-3">
         <input type="text" class="form-control" id="title" name="title" readonly="readonly" value=" 제목 : ${csBoard.title}" />
               </div>
      <div class="mb-3">
            <input type="text" class="form-control" id="writer" name="writer" readonly="readonly" value="작성자  : ${csBoard.writer}"/>
         </div>
         <div class="mb-3">
         <textarea class="form-control" rows="10" id="content" name="content" readonly="readonly" >내용  : ${csBoard.contents }
            
         </textarea>
         	<c:if test="${attachLst != null}">
				<div class="mb-3" style="float: left; margin-top: 20px;">
					<c:forEach var="file" items="${attachLst }">
						<c:if test="${file.thumbnailFile != null }">
							<img src="/resources/cs_uploads${file.originFile }" />
						</c:if>
						<c:if test="${file.notImageFile != null}">
							<a href="/resources/cs_uploads${file.notImageFile }"
								class="notImgFile">${file.notImageFile }</a>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
         </div>
         <div class = 'buttonBox'>
         <c:if test = "${csBoard.writer eq loginUser.userId }">
           <button class="button button-postComment button--active"
            type="button" id="btn4"
            onclick="location.href='${ contextPath}/cs/delete?no=${csBoard.postNo }'">삭제하기</button>
         <button class="button button-postComment button--active"
            type="button" id="btn2" onclick="location='/cs/modify?no=${csBoard.postNo }&u=${ sessionId}'">수정하기</button>
            </c:if>
            
         <button class="button button-postComment button--active"
            type="button" id="btn3"
            onclick="location.href='${ contextPath}/cs/'">목록</button>
            </div>
         </div>
         </div>
   
   <jsp:include page="../userFooter.jsp"></jsp:include>
</html>