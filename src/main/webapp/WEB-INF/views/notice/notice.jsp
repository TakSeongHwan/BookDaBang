<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function() {
		console.log("${param}");
	});
	function showContent(obj) {
		let no = $(obj).attr("id");
		location.href = "${contextPath}/notice/viewContent?no=" + no;
	}
	
</script>
<style>
.container {
	margin-top: 20px;
	margin-bottom: 20px;

}
.pagination{
justify-content: center!important;
}
.searchType{
bottom: 0px !important;

}
.searchWord{

bottom: 6px;
width:150px;
margin-left: 5px;
}
.nice-select{
height: 38px;
}

</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<div class="container mt-3">
		<h1 style="margin: 20px; margin-bottom: 20px;">공 지 사 항</h1>

		<form action="${contextPath}/notice/listAll" method="get" >
		
		<div style="display: flex;">
			<span class="searchBar searchType"><select name="searchType" >
					<option value="title">제목</option>
					<option value="content">내용</option>

			</select>
			</span> 
			<span class="input-group filter-bar-search searchBar searchWord"> <input
				type="text" name="searchWord" />
				<button type="submit">
					<i class="ti-search"></i>
				</button>
			</span>
</div>
		</form>

		<table class="table table-hover">
			<thead style="background-color: #fafaff; color: #777">
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

						<td class="noticeContent" >${notice.title}</td>
						<td>${notice.writer}</td>
						<td class="noticeContent" ><fmt:formatDate value="${notice.writedDate}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td>${notice.viewCount}</td>
						<td>${notice.reply}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${userId == 'admin' }">
			<a class="button" href="${contextPath}/notice/viewNoticeWrite">글쓰기</a>
		</c:if>

		<ul class="pagination">
			<c:if test="${param.pageNo>1 }">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''}">
						<li class="page-item"><a class="page-link"
							href="${contextPath}/notice/listAll?pageNo=${param.pageNo-1}">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath}/notice/listAll?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Previous</a>
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
									href="${contextPath}/notice/listAll?pageNo=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath}/notice/listAll?pageNo=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${param.page== i}">
								<li class="page-item active"><a class="page-link"
									href="${contextPath}/notice/listAll?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath}/notice/listAll?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}">${i}</a></li>
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
							href="${contextPath}/notice/listAll?pageNo=${param.pageNo+1}">Next</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath}/notice/listAll?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}">Next</a></li>

					</c:otherwise>
				</c:choose>
			</c:if>
		
		</ul>



	</div>

	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>