<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="contextPath" value="<%=request.getContextPath()%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.1/chart.min.js" integrity="sha512-QSkVNOCYLtj73J4hbmVoOV6KVZuMluZlioC+trLpewV8qMjsWqlIQvkn1KGX2StWvPMdWGBqim1xlC8krl1EKQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<title>Admin Product Statistics</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>

$(function(){
	
	$("#sortType").change(function(){
		location.href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${param.pageNo}&sortType="+$("#sortType").val();
		
	});
	
})

</script>

<style>
.ellipsis{
text-overflow: ellipsis;
overflow: hidden;
white-space: nowrap;
  height: 40px;
  width:10%;

}
.titleWidth{
 width:100px;
}


</style>
</head>
<body>
<jsp:include page="../../managerHeader.jsp"></jsp:include>

<div class="container mt-3">
  <h2>상품 통계</h2>
  
  <form action="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=1" method="get" style="margin-bottom: 1%;">
		
		<div style="display: flex;">
	
				<div class="input-group" style="width: 10%;">
                            <select class="form-select" id="sortType" name="sortType">
                             
                              <option value="product_no" ${param.sortType == 'product_no' ? 'selected="selected"' : '' }>제품번호 순</option>
                              <option value="category" ${param.sortType == 'category' ? 'selected="selected"' : '' }>카테고리 순</option>
                              <option value="isbn13" ${param.sortType == 'isbn13' ? 'selected="selected"' : '' }>isbn13 순</option>
                              <option value="title" ${param.sortType == 'title' ? 'selected="selected"' : '' }>제목 순</option>
                              <option value="priceAsc" ${param.sortType == 'priceAsc' ? 'selected="selected"' : '' }>가격 낮은 순</option>
                              <option value="priceDesc" ${param.sortType == 'priceDesc' ? 'selected="selected"' : '' }>가격 높은 순</option>
                              <option value="reviewDesc" ${param.sortType == 'reviewDesc' ? 'selected="selected"' : '' }>리뷰 많은 순</option>
                            </select>
                          </div>
        		 <div class="input-group" style="width: 10%;">
                            <select class="form-select" id="inputGroupSelect02" name="searchType">
                              <option selected="">Choose...</option>
                              <option value="category" ${param.searchType == 'category' ? 'selected="selected"' : '' }>카테고리</option>
                              <option value="isbn13" ${param.searchType == 'isbn13' ? 'selected="selected"' : '' }>isbn13</option>
                              <option value="title" ${param.searchType == 'title' ? 'selected="selected"' : '' }>제목</option>
                            </select>
                          </div>
			<div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                  <input type="text" class="form-control border-1 " name="searchWord" placeholder="Search..." aria-label="Search...">
                  <button type="submit" class="btn rounded-pill btn-outline-primary mrg2" style="width:40%;">검색</button>
                </div>
              </div>
</div>
		</form>
  
 
  <table class="table table-striped" style="table-layout: fixed;">
    <thead>
      <tr id="theadTR">
        <th style="width:5%">제품번호</th>
        <th style="width:10%;">ISBN13</th>
        <th style="width:18%;">제목</th>
        <th style="width:10%">카테고리</th>
        <th style="width:7%;">판매량</th>
        <th style="width:9%;">정가</th>
        <th style="width:9%;">판매가</th>
        <th style="width:5%;">재고</th>
        <th style="width:7%;">조회수</th>
        <th style="width:8%;">판매상태</th>
        <th style="width:7%;">리뷰 수</th>
      </tr>
    </thead>
    <tbody>
        <c:forEach var="adminProduct" items="${adminProduct }">
      <tr>
  
        <td>${adminProduct.product_no}</td>
        <td class="ellipsis">${adminProduct.isbn13}</td>
        <td class="ellipsis">${adminProduct.title}</td>
        <td class="ellipsis">${adminProduct.category_name}</td>
        <td>${adminProduct.sales_count}</td>
        <td>${adminProduct.price}원</td>
        <td>${adminProduct.sell_price}원</td>
        <td>${adminProduct.stock}</td>
        <td>${adminProduct.read_count}</td>
        <td>${adminProduct.sales_status}</td>
        <td>${adminProduct.reviewCount}</td>
      
      </tr>
    </c:forEach>
    </tbody>
  </table>
  
  <div class="demo-inline-spacing">
                        <!-- Basic Pagination -->
                        <nav aria-label="Page navigation">
                       
                          <ul class="pagination">
			<c:if test="${param.pageNo>1 }">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord =='' || param.sortType == '' || param.sortType==null}">
						<li class="page-item"><a class="page-link"
							href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${param.pageNo-1}">Previous</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${param.pageNo-1}&searchType=${param.searchType}&searchWord=${param.searchWord}&sortType=${param.sortType}">Previous</a>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:forEach var="i" begin="${pagingInfo.startNoOfCurPagingBlock}"
				end="${pagingInfo.endNoOfCurPagingBlock }" step="1">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''|| param.sortType == '' || param.sortType==null}">
						<c:choose>
							<c:when test="${param.pageNo== i}">
								<li class="page-item active"><a class="page-link"
									href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${param.page== i}">
								<li class="page-item active"><a class="page-link"
									href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}&sortType=${param.sortType}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item "><a class="page-link"
									href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${i}&searchType=${param.searchType}&searchWord=${param.searchWord}&sortType=${param.sortType}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>


			</c:forEach>
			<c:if test="${param.pageNo < pagingInfo.totalPage }">
				<c:choose>
					<c:when
						test="${param.searchType == null || param.searchType =='' || param.searchWord == null || param.searchWord ==''|| param.sortType == '' || param.sortType==null}">
						<li class="page-item"><a class="page-link"
							href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${param.pageNo+1}">Next</a></li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="${contextPath }/admin/adminStatistics/adminProductStatistics?pageNo=${param.pageNo+1}&searchType=${param.searchType}&searchWord=${param.searchWord}&sortType=${param.sortType}">Next</a></li>

					</c:otherwise>
				</c:choose>
			</c:if>
		
		</ul>

                        </nav>
                        <!--/ Basic Pagination -->
                      </div>
</div>


	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>