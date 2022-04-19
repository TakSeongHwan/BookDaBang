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

<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


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
  
  <form action="" method="get"  style="margin-bottom: 10px;">
		
		<div style="display: flex;">
			<div class="btn-group">
                      <button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        Primary
                      </button>
                      <ul class="dropdown-menu" style="">
                        <li><a class="dropdown-item" href="javascript:void(0);">Action</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);">Another action</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);">Something else here</a></li>
                        <li>
                          <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="javascript:void(0);">Separated link</a></li>
                      </ul>
                    </div>
			<div class="navbar-nav align-items-center">
                <div class="nav-item d-flex align-items-center">
                  <i class="bx bx-search fs-4 lh-0"></i>
                  <input type="text" class="form-control border-1 " placeholder="Search..." aria-label="Search...">
                </div>
              </div>
</div>
		</form>
  
 
  <table class="table table-bordered table-light" style="table-layout: fixed;">
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
</div>


	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>