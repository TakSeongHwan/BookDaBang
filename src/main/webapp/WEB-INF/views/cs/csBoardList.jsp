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
	
	<div>
	<form action = "${contextPath}/cs/" method="get">
		<select name = "searchType">
			<option value="title" >제목</option>
			<option value= "contents">제목 + 내용</option>
			<option value= "writer">글쓴이</option>
			<option value= "category">말머리</option>
		</select>
		<div>
			<div class="input-group filter-bar-search">
				<input type="text" name = "searchWord"  placeholder="검색" />
					<div class = "input-group-append">
						<button type = "submit">
						<i class = "ti-search">
						</i>
						</button>
					</div>
			</div>
		</div>
		</form>
	</div>
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
  	
  	<ul class="pagination">
			<c:if test="${param.pageNo>1 }">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
						<li class="page-item"><a class="page-link"
							href="${contextPath}/cs/?pageNo=${param.pageNo-1}">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath}/cs/?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Previous</a>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:forEach var="i" begin="${pagingInfo.startNoOfCurPagingBlock}"
				end="${pagingInfo.endNoOfCurPagingBlock }" step="1">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
						<c:choose>
							<c:when test="${param.pageNo== i}">
								<li class="page-item active"><a class="page-link"
									href="${contextPath}/cs/?pageNo=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath}/cs/?pageNo=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${param.page== i}">
								<li class="page-item active"><a class="page-link"
									href="${contextPath}/cs/?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath}/cs/?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${param.pageNo < pagingInfo.totalPage }">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
						<li class="page-item"><a class="page-link"
							href="${contextPath}/cs/?pageNo=${param.pageNo+1}">Next</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath}/cs/?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Next</a></li>

					</c:otherwise>
				</c:choose>
			</c:if>
		</ul>
  	
  	<button class="button button-header" onclick='location.href="${ contextPath}/cs/write?u=${ sessionId}"'>글쓰기</button>
	</div>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>