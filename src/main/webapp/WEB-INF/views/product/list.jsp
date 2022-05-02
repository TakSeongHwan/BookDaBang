<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	let cno = 0;
	let sort = 0;
	function insertCart(no){
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : 1
			},
			success : function(data) {
				console.log(data);
				cartCount();
			},
			error : function(data){
				console.log(data);
			}
		});
	}
	function goOrder(no){
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : 1
			},
			success : function(data) {
				location.href = "${contextPath}/order/checkOut"
			},
			error : function(data){
				console.log(data);
			}
		});
	}
	$(function() {
		priceReplace();
		
		$(".category").click(function() {
			cno = $(this).val();
			orderBy(0);
		});
		noProduct();
	});
	
	function noProduct() {
		if ($("#productList").children("div").length == 0) {
			let output = "<img src='${contextPath}/resources/img/product/noproduct.png' style='margin-top: 200px;'>";
			$("#productList").html(output);
		}
		
	}
	
	function priceReplace() {
		$(".card-product__price").each(function (i,e) {
			let str = $(e).text().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			$(e).text(str);
		});
	}
	
	function orderBy(i) {
		// 정렬방법 css
		$(".orderBy a").css("color", "#000000");
		if (i == 1) {
			$("#bySellCount").css("color", "#384aeb");
		} else if (i == 2) {
			$("#byPubDate").css("color", "#384aeb");
		} else if (i == 3) {
			$("#byDiscount").css("color", "#384aeb");
		}
		sort = i;
		getCategory(1);
	}
	
	function getCategory(pageNo) {
		// URL 수정 (pageNo)
		const URLSearch = new URLSearchParams(location.search);
		URLSearch.set('pageNo', pageNo);
		const newParam = URLSearch.toString();
		history.pushState(null, null, location.pathname + '?' + newParam,'_self');

		let url = "${contextPath}/product/list/" + cno + "?pageNo=" + pageNo + "&sort=" + sort + "&searchWord=${param.searchWord}";
		console.log(url);
		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
			success : function(data) {
				console.log(data);
				if (data.productList != null) {
					parseList(data.productList);
					parsePaging(data.pagingInfo);
				} else {
					noProduct();
				}
			}
		});

	}

	function parseList(data) {
		$("#productList").empty();
		let output = '';
		$.each(data,function(i, e) {
			output += '<div class="col-md-6 col-lg-4"><div class="card text-center card-product"><div class="card-product__img">';
			output += '<img class="card-img" src="' + e.cover + '" alt="">';
			output += '<ul class="card-product__imgOverlay"><li><a href="${contextPath}/product/detail?no=' + e.product_no +
					'"><button><i class="ti-search"></i></button></a></li>';
			output += '<li><button onclick="insertCart(' + e.product_no + ')"><i class="ti-shopping-cart"></i></button></li>';
			output += '<li><button onclick="goOrder(' + e.product_no + ')"><i class="ti-money"></i></button></li></ul></div>';
			output += '<div class="card-body"><p>' + e.author
						+ ' | ' + e.publisher + '</p>';
			output += '<h4 class="card-product__title"><a href="${contextPath}/product/detail?no=' + e.product_no
						+ '" class="productLink">' + e.title + '</a></h4>';
			output += '<p class="card-product__price">' + e.sell_price + '원</p>';
			output += '</div></div></div>';
		});

		$("#productList").html(output);
		priceReplace();
	}

	function parsePaging(data) {
		$(".pagination").empty();
		let output = '';
		const URLSearch = new URLSearchParams(location.search);
		let pageNo = URLSearch.get("pageNo");
		if (pageNo > 2) {
			output += '<li class="page-item"><button onclick="getCategory(1)"'
				 + 'class="page-link" aria-label="Previous"><span aria-hidden="true">' +
				'<span class="lnr lnr-chevron-left"><<</span></span></button></li>';
		}
		if (pageNo > 1) {
			output += '<li class="page-item"><button onclick="getCategory(' + (pageNo-1) +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left"><</span></span></button></li>';
		
		}
		for (let i = data.startNoOfCurPagingBlock; i <= data.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				output += '<li class="page-item active"><button onclick="getCategory(' + i + ')"class="page-link">' + i + '</button></li>';
			} else {
				output += '<li class="page-item"><button onclick="getCategory(' + i + ')"class="page-link">' + i + '</button></li>';
			}
			
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item"><button onclick="getCategory(' + ++pageNo +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left">></span></span></button></li>';
		
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item"><button onclick="getCategory(' + data.totalPage +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left">>></span></span></button></li>';
		
		}

		$(".pagination").html(output);
		$(".filter-bar").attr("tabindex", -1).focus();
	}
	
</script>
<title>상품 리스트페이지</title>
<style>
	.orderBy {
		display: inline-block;
		padding: 6px;
		margin-top: 9px;
	}
	
	.sorting {
		float: right;
		margin-top: 9px;
	}
	
	.productLink {
		padding-top: 7px;
		overflow: hidden;
    	display: -webkit-box;
    	-webkit-line-clamp: 2;
    	-webkit-box-orient: vertical;
	}
	
	.card-img {
		height: 350px
	}
	
	.page-link {
		width: 42px;
    	height: 40px;
    	text-align: center;
    	font-size: 17px;
	}
</style>
</head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>

	<div class="container">
		<!-- ================ start banner area ================= -->
		<section class="blog-banner-area" id="category">
			<div class="container h-100">
				<div class="blog-banner">
					<div class="text-center">
						<h1>Book Category</h1>
						<nav aria-label="breadcrumb" class="banner-breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">Shop
									Category</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<!-- ================ end banner area ================= -->
		
		<!-- ================ category section start ================= -->
		<section class="section-margin--small mb-5">
			<div class="container">
				<div class="row">
					<div class="col-xl-3 col-lg-4 col-md-5">
						<div class="sidebar-categories">
							<div class="head">Book Categories</div>
							<ul class="main-categories" style="padding: 20px 26px;">
								<li class="common-filter">
									<form action="/list">
										<ul>
											<li class="filter-list">
												<label for="0">
												<input class="pixel-radio category" type="radio"
												value="0" name="category" id ="0">전체 
												<span>(${pagingInfo.totalPostCnt})</span>
												</label>
											</li>
											<c:forEach var="category" items="${categoryList }">
												<li class="filter-list">
													<label for="${category.category_code}">
													<input class="pixel-radio category" type="radio" id ="${category.category_code}"
													value ="${category.category_code}" name="category">${category.category_name}
														<span>(${category.productCount})</span>
													</label>
												</li>
											</c:forEach>
										</ul>
									</form>
								</li>
							</ul>
						</div>
						<div class="sidebar-filter">
							<div class="top-filter-head">Product Filters</div>
							<div class="common-filter">
								<div class="head">Brands</div>
								<form action="#">
									<ul>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="apple" name="brand"><label
											for="apple">Apple<span>(29)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="asus" name="brand"><label for="asus">Asus<span>(29)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="gionee" name="brand"><label
											for="gionee">Gionee<span>(19)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="micromax" name="brand"><label
											for="micromax">Micromax<span>(19)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="samsung" name="brand"><label
											for="samsung">Samsung<span>(19)</span></label></li>
									</ul>
								</form>
							</div>
							<div class="common-filter">
								<div class="head">Color</div>
								<form action="#">
									<ul>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="black" name="color"><label
											for="black">Black<span>(29)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="balckleather" name="color"><label
											for="balckleather">Black Leather<span>(29)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="blackred" name="color"><label
											for="blackred">Black with red<span>(19)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="gold" name="color"><label for="gold">Gold<span>(19)</span></label></li>
										<li class="filter-list"><input class="pixel-radio"
											type="radio" id="spacegrey" name="color"><label
											for="spacegrey">Spacegrey<span>(19)</span></label></li>
									</ul>
								</form>
							</div>
							<div class="common-filter">
								<div class="head">Price</div>
								<div class="price-range-area">
									<div id="price-range"></div>
									<div class="value-wrapper d-flex">
										<div class="price">Price:</div>
										<span>$</span>
										<div id="lower-value"></div>
										<div class="to">to</div>
										<span>$</span>
										<div id="upper-value"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-9 col-lg-8 col-md-7">
						<!-- Start Filter Bar -->
						<div class="filter-bar align-items-center" style="height: 55px;">
							<div style="float: left;">
								<ul id ="sort">
									<li class="orderBy"><a href="javascript:orderBy(1);" id ="bySellCount">판매순</a></li>
									<li class="orderBy"><a href="javascript:orderBy(2);" id ="byPubDate">출간일순</a></li>
									<li class="orderBy"><a href="javascript:orderBy(3);" id ="byDiscount">가격순</a></li>
								</ul>
							</div>
							<div class="sorting">
								<select>
									<option value="1">Default sorting</option>
									<option value="1">Default sorting</option>
									<option value="1">Default sorting</option>
								</select>
							</div>
							<div class="sorting">
								<select>
									<option value="1">Show 12</option>
									<option value="1">Show 12</option>
									<option value="1">Show 12</option>
								</select>
							</div>
							
						</div>
						<!-- End Filter Bar -->
						<!-- Start Book List -->
						<section class="lattest-product-area pb-40 category-list">
							<div class="row" id = "productList">						
								<c:forEach var="product" items="${productList }">
									<div class="col-md-6 col-lg-4">
										<div class="card text-center card-product">
											<div class="card-product__img">
												<img class="card-img" src="${product.cover }" alt="">
												<ul class="card-product__imgOverlay">
													<li>
														<a href="${contextPath}/product/detail?no=${product.product_no}">
															<button><i class="ti-search"></i></button>
														</a>
													</li>
													<li>
														<button onclick="insertCart(${product.product_no})"><i class="ti-shopping-cart"></i></button>
													</li>
													<li>
														<button onclick="goOrder(${product.product_no})"><i class="ti-money"></i></button>
													</li>
												</ul>
											</div>
											<div class="card-body">
												<p>${product.author} | ${product.publisher}</p>
												<h4 class="card-product__title">
													<a href="${contextPath}/product/detail?no=${product.product_no}"
													class="productLink">${product.title}</a>
												</h4>
												<p class="card-product__price">${product.sell_price}원</p>
											</div>
										</div>
									</div>
								</c:forEach>	
							</div>
						</section>
						<!-- 페이징 -->
						<nav class="blog-pagination justify-content-center d-flex">
                          	<ul class="pagination">
                          		<c:if test="${param.pageNo > 2 }">
                          			<c:choose>
										<c:when test="${param.searchWord == null || param.searchWord ==''}">
											<li class="page-item">
												<a href="${contextPath }/product/list?pageNo=1"
												 class="page-link" aria-label="Previous">
									 			<span aria-hidden="true">
									 				<span class="lnr lnr-chevron-left"><<</span>
									 			</span>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a href="${contextPath }/product/list?pageNo=1&searchWord=${param.searchWord}"
												 class="page-link" aria-label="Previous">
									 			<span aria-hidden="true">
									 				<span class="lnr lnr-chevron-left"><<</span>
									 			</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
                          		</c:if>
								<c:if test="${param.pageNo >1}">
									<c:choose>
										<c:when test="${param.searchWord == null || param.searchWord ==''}">
											<li class="page-item">
												<a href="${contextPath }/product/list?pageNo=${param.pageNo-1 }"
												class="page-link" aria-label="Previous">
												<span aria-hidden="true"><span class="lnr lnr-chevron-left"><</span>
												</span>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a class="page-link" aria-label="Previous"
												href="${contextPath }/product/list?pageNo=${param.pageNo-1 }&searchWord=${param.searchWord}">
												<span aria-hidden="true"><span class="lnr lnr-chevron-left"><</span>
												</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>	
								</c:if>
								<c:forEach var="i" begin="${pagingInfo.startNoOfCurPagingBlock}"
									end="${pagingInfo.endNoOfCurPagingBlock }" step="1">
									<c:choose>
										<c:when test="${param.searchWord == null || param.searchWord ==''}">
											<c:choose>
												<c:when test="${param.pageNo == i}">
													<li class="page-item active">
														<a href="${contextPath }/product/list?pageNo=${i}"
														class="page-link">${i}</a>
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<a href="${contextPath }/product/list?pageNo=${i}"
														class="page-link">${i}</a>
													</li>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${param.pageNo == i}">
													<li class="page-item active">
														<a href="${contextPath }/product/list?pageNo=${i}&searchWord=${param.searchWord}"
														class="page-link">${i}</a>
													</li>
												</c:when>
												<c:otherwise>
													<li class="page-item">
														<a href="${contextPath }/product/list?pageNo=${i}&searchWord=${param.searchWord}"
														class="page-link">${i}</a>
													</li>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>	
								</c:forEach>
								<c:if test="${param.pageNo < pagingInfo.totalPage}">
									<c:choose>
										<c:when test="${param.searchWord == null || param.searchWord ==''}">
											<li class="page-item">
												<a href="${contextPath }/product/list?pageNo=${param.pageNo+1}"
												class="page-link" aria-label="Next">
												<span aria-hidden="true"><span class="lnr lnr-chevron-right">></span>
												</span>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a class="page-link" aria-label="Next"
												href="${contextPath }/product/list?pageNo=${param.pageNo+1}&searchWord=${param.searchWord}">
												<span aria-hidden="true"><span class="lnr lnr-chevron-right">></span>
												</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if test="${param.pageNo < pagingInfo.totalPage-1}">
									<c:choose>
										<c:when test="${param.searchWord == null || param.searchWord ==''}">
											<li class="page-item">
												<a href="${contextPath }/product/list?pageNo=${pagingInfo.totalPage}"
												 class="page-link" aria-label="Next">
												<span aria-hidden="true"><span class="lnr lnr-chevron-right">>></span>
												</span>
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
												<a class="page-link" aria-label="Next"
												href="${contextPath }/product/list?pageNo=${pagingInfo.totalPage}&searchWord=${param.searchWord}">
												<span aria-hidden="true"><span class="lnr lnr-chevron-right">>></span>
												</span>
												</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:if>
                          </ul>
                      </nav>
						<!-- End Book List -->
					</div>
				</div>
			</div>
		</section>
		<!-- ================ category section end ================= -->

	</div>
	
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>