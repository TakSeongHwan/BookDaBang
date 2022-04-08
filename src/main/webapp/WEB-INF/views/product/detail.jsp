<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>상품 상세페이지</title>
<script>
	$(function() {
		priceReplace();
		quantity(1);
		infoReplace();
		navColor();
		starMaker();
		
	});
	
	function priceReplace() {
		let sellPrice = $(".s_product_text h2").text().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$(".s_product_text h2").text(sellPrice);
		
		let listPrice = $("#listPrice").html().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$("#listPrice").html(listPrice);
	}
	
	function quantity(number) {
		let q = number;
		let output = "";
		if (q > 1) {
			let price = String(${product.sell_price}*q);
			price = price.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
			output = "총 상품금액 : <h2 style='display:inline-block;'> " + price + " </h2>원";
		}	
		$("#totalPrice").html(output);
	}
	
	function infoReplace() {
		let info = $("#home").html();
		info = info.replaceAll("더보기", "");
		info = info.replace("책소개", "<h4>책소개</h4>");
		info = info.replace("저자 및 역자소개", "<h4>저자 및 역자소개</h4>");
		info = info.replace("(모두보기)", "<hr style='border-style: dotted;' />");
		info = info.replace("목차", "<h4>목차</h4>");
		info = info.replace("책속에서", "<h4>책속에서</h4>");
		info = info.replace("출판사 제공 책소개", "<h4>출판사 제공 책소개</h4>");
		$("#home").html(info);
	}
	
	function navColor() {
		$("#home-tab, #review-tab, #contact-tab, #profile-tab").click(function() {
			$("#home-tab, #review-tab, #contact-tab, #profile-tab").each(function (i,e) {
				$(e).css("background-color", "#f1f6f7");
			});
			$(this).css("background-color", "#384aeb");
		});	
	}

	function starMaker() {
		let star = "";

		$(".star").each(function (i,e) {
			star = $(e).attr("value");
			let output = "";
			for (i=0; i < star; i++) {
				output += '<i class="fa fa-star"></i>&nbsp';
			}
			for (i=0; i < 5-star; i++) {
				output += '<i class="fa fa-star"style="font-weight: 100"></i>&nbsp';
			}
			$(e).html(output);
		});	
	}
	
	function getComment(no) {
		let rno = no;
		console.log(rno);
		if ($("#comment").html() == '') {
			let url = "${contextPath}/comment/all/" + rno;
			$.ajax({
				url : url,
				dataType : "json",
				type : "get",
				success : function (data) {
					console.log(data);	
					if (data != null) {
						parseComment(data);
					}
				}
			});
		} else {
			$("#comment").empty();
		}	
	}
	
	function parseComment(data) {
		$("#comment").empty();
		let output = '<div class="comments-area">';
		$.each(data, function(i, e) {
			output += '<div class="comment-list" style="padding-bottom: 25px;"><div class="single-comment justify-content-between d-flex">';
			output += '<div class="user justify-content-between" style="width:800px;"><div class="desc">';
			output += '<p class="commenter">' + e.commenter + '</p>';
			let writtenDate = calcDate(e.writeDate);
			output += '<p class="date">' + writtenDate + '</p>';
			output += '<p class="comment">' + e.comment + '</p></div></div>';
			output += '<div class="reply-btn"><a href="#" class="btn-reply text-uppercase">reply</a></div></div></div>';
		});
		 output += '<hr/><textarea class="form-control" name="comment" id= "commentText" rows="3" placeholder="comment"></textarea>';
		 output += '<button type="submit" class="button button--active button-contactForm" style="float:right;">댓글 작성</button></div>';
		 
		 $("#comment").html(output);
	}
	
	function calcDate(rd) {
		// '방금전', '0분전','날짜 시간'
		let diff = new Date() - rd; // 댓글 단 시간과 현재시간의 차
		let diffSecond = diff / 1000; // 초단위
		if(diffSecond < 60 * 5) return '방금전';
		let diffMiniutes = diffSecond / 60; // 분단위
		if(diffMiniutes < 60) return Math.floor(diffMiniutes) + '분전';
		return new Date(rd).toLocaleString();
	}	
	
</script>
<style>
 .reviewBtn {
 	width : 80px;
 	height: 35px;
 	margin-bottom: 10px;
 	font-size: 13px;
 	
 }
 
 #home-tab, #review-tab, #contact-tab, #profile-tab {
 	width: 261.9px;
 	height: 60px;
 	border:0;
 	border-radius:0;
 	font-size: 18px;
 	line-height: 57px;
 }
 
 #review-tab, #contact-tab, #profile-tab {
 	background-color: #f1f6f7;
 }
 
 .commenter {
 	text-align : left;
 	font-size: 20px;
 }
 
 #commentText {
 	width: 800px;
 	display: inline-block;
 }
 
 .comment-list {
 	background-color: white;
 	padding : 10px 10px 25px 30px;
 	margin-bottom: 25px;
 	border : 1px solid #ced4da;
 	border-radius: 20px;
 	box-shadow : 2px 2px 2px 2px #ced4da;
 }
 
 .btn-reply {
	margin-top: 12px;
 	border : 1px solid #ced4da;
 	border-radius: 20px;
 }
 
 .commenter{
 	display: inline-block;
 }
 
 .date {
 	display: inline-block;
 	margin-left: 14px;
 }
</style>
<head>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	
	<div class="container">
		<!--================Single Product Area =================-->
		<div class="product_image_area">
			<div class="container">
				<div class="row s_product_inner">
					<div class="col-lg-6">
						<div class="owl-carousel owl-theme s_Product_carousel owl-loaded owl-drag">
							<div class="single-prd-item">
								<img class="img-fluid" src="${product.cover }" alt="" style="width: auto; height: auto;">
							</div>		
						</div>
					</div>
					<div class="col-lg-5 offset-lg-1">
						<div class="s_product_text">
							<h3>${product.title }</h3>
							<h2>판매가  : ${product.sell_price }원 
							<c:if test="${product.sell_price != product.price }">
								(${(product.price - product.sell_price)/product.price*100}%,
								${product.price - product.sell_price}원 할인)
							</c:if>
							</h2>
							<ul class="list">
								<li><a id="listPrice"><span>정가</span> : ${product.price}원</a></li>
								<li><a class="active" href="#"><span>Category</span> :
										Household</a></li>
								<li><a href="#"><span>Availibility</span> : In Stock(${product.stock})</a></li>
								<li><a><span>배송비</span> : 무료</a></li>
							</ul>
							<p>${product.description } <br/>
							출판사 - ${product.publisher }  ||  출판일 - ${product.pub_date}
							</p>
							<br/>
							<div class="product_count">
								<label for="qty">Quantity:</label>
                                <input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:"
                                    class="input-text qty" style="height: 40px;">
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++; quantity(result.value);"
                                    class="increase items-count" type="button" style="top: -2px;">
                                    <i class="lnr lnr-chevron-up:before"><img src="//image.aladin.co.kr/img/shop/2018/icon_Aup.png" border="0"></i>
                                    
                                </button>
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 1 ) result.value--;quantity(result.value);"
                                    class="reduced items-count" type="button" style="bottom: -1.5px;">
                                    <i class="lnr lnr-chevron-down"><img src="//image.aladin.co.kr/img/shop/2018/icon_Adown.png" border="0"></i>
                                </button>
                               
							</div>
							 <div style="display: inline-block; margin-left: 50px;" id="totalPrice">
							
							</div>
							<div>
								<a class="button button--active button-contactForm" href="#">장바구니 담기</a>&nbsp;
								<a class="button button--active button-contactForm" href="#">바로구매</a>
							</div>
							
							<!--  <div class="card_area d-flex align-items-center">
								<a class="icon_btn" href="#"><i class="lnr lnr lnr-diamond"></i></a>
								<a class="icon_btn" href="#"><i class="lnr lnr lnr-heart"></i></a>
							</div>-->
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--================End Single Product Area =================-->

		<!--================Product Description Area =================-->
		<section class="product_description_area">
			<div class="container">
				<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding: 0">
					<li class="nav-item" style="margin-bottom: 0;">
						<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home"
						 role="tab" aria-controls="home" aria-selected="true">도서 정보</a></li>
					<li class="nav-item" >
						<a class="nav-link" id="review-tab" data-toggle="tab" href="#review"
						 role="tab" aria-controls="review" aria-selected="false">Reviews</a></li>
					<li class="nav-item" >
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact"
						role="tab" aria-controls="contact" aria-selected="false">Q&A</a></li>
					<li class="nav-item" >
						<a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile"
						 role="tab" aria-controls="profile" aria-selected="false">교환/반품안내</a></li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<!-- 도서 정보 content -->
					<div class="tab-pane fade show active" id="home" role="tabpanel"
						aria-labelledby="home-tab" style="white-space: pre-line;">
						<h4>ISBN</h4>
							${product.isbn13 } ( ${product.isbn } )
							<hr/>${product.detail_description }
							<hr/>${product.author_introduce }
							<hr/>${product.index }
							<c:if test="${product.inside_book != ''}">
								<hr/> ${product.inside_book } 
							</c:if>
							<c:if test="${product.pisOffdiscription != ''}">
								<hr/> ${product.pisOffdiscription }
							</c:if>
							
					</div>
					<!-- 리뷰 정보 content -->
					<div class="tab-pane fade" id="review" role="tabpanel"
						aria-labelledby="review-tab">
						<div class="row">
							<div class="col-lg-12">
								<div class="row total_rate">
									<div class="col-6">
										<div class="box_total">
											<h5>Overall</h5>
											<h4>4.0</h4>
											<h6>(03 Reviews)</h6>
										</div>
									</div>
									<div class="col-6">
										<div class="rating_list">
											<h3>Based on 3 Reviews</h3>
											<ul class="list">
												<li><a href="#">5 Star <i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i> 01
												</a></li>
												<li><a href="#">4 Star <i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star" style="font-weight: 100"></i> 01
												</a></li>
												<li><a href="#">3 Star <i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"style="font-weight: 100"></i>
														<i class="fa fa-star"style="font-weight: 100"></i> 01
												</a></li>
												<li><a href="#">2 Star <i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"style="font-weight: 100"></i>
														<i class="fa fa-star" style="font-weight: 100"></i>
														<i class="fa fa-star"style="font-weight: 100"></i> 01
												</a></li>
												<li><a href="#">1 Star <i class="fa fa-star"></i>
														<i class="fa fa-star"style="font-weight: 100"></i>
														<i class="fa fa-star"style="font-weight: 100"></i>
														<i class="fa fa-star"style="font-weight: 100"></i>
														<i class="fa fa-star"style="font-weight: 100"></i> 01
												</a></li>
											</ul>							
										</div>
										<div>
											<button type="submit" class="button button--active button-review"
											style="float: right;"> 리뷰 작성</button>
										</div>
									</div>						
								</div>
								<hr/>
								<div class="review_list">
									<c:forEach var="review" items="${reviewList }">
										<div class="review_item">
											<div class="media">
												<div class="d-flex">
													<img src="" alt="">
												</div>
												<div class="media-body" >
													<div class = "star"  value = "${review.grade }"
													style="display: inline-block; float: left; margin-right: 25px;">														
													</div>
															
													<div style="display: inline-block;">
														<h4 style="display: inline-block; margin-right: 20px">${review.title }</h4>
														<h5 style="float: right; margin-top: 1px">
														${review.writer } | ${review.writedate}</h5>
														<p style="width: 750px">${review.content }</p>
													</div>
													<div style="display: inline-block; float: right; width: 100px;">
														<button type="submit" class="button button-header reviewBtn"
														style="padding: 5px">♡ ${review.recommendNum}</button>
														<button class="button button-header reviewBtn" style="padding: 8px"
														onclick="getComment(${review.reviewNo})">댓글 ${review.commentNum}</button>
													</div>
													<div id="comment"></div>
													<hr style="border-style: dotted; margin-top: 35px; margin-bottom: 4px" />
													
												</div>
												
											</div>
										</div>
									</c:forEach>
									
									<!--  <div class="review_item">
										<div class="media">
											<div class="d-flex">
												<img src="img/product/review-2.png" alt="">
											</div>
											<div class="media-body">
												<h4>Blake Ruiz</h4>
												<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
													class="fa fa-star"></i> <i class="fa fa-star"></i> <i
													class="fa fa-star"></i>
											</div>
										</div>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua. Ut enim ad minim veniam, quis nostrud
											exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
									</div>-->
									
								</div>
							</div>
							
						</div>
					</div>
					<!-- Q&A 정보 content -->
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">
						<div class="row">
							<div class="col-lg-6">
								<div class="comment_list">
									<div class="review_item">
										<div class="media">
											<div class="d-flex">
												<img src="img/product/review-1.png" alt="">
											</div>
											<div class="media-body">
												<h4>Blake Ruiz</h4>
												<h5>12th Feb, 2018 at 05:56 pm</h5>
												<a class="reply_btn" href="#">Reply</a>
											</div>
										</div>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua. Ut enim ad minim veniam, quis nostrud
											exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
									</div>
									<div class="review_item reply">
										<div class="media">
											<div class="d-flex">
												<img src="img/product/review-2.png" alt="">
											</div>
											<div class="media-body">
												<h4>Blake Ruiz</h4>
												<h5>12th Feb, 2018 at 05:56 pm</h5>
												<a class="reply_btn" href="#">Reply</a>
											</div>
										</div>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua. Ut enim ad minim veniam, quis nostrud
											exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
									</div>
									<div class="review_item">
										<div class="media">
											<div class="d-flex">
												<img src="img/product/review-3.png" alt="">
											</div>
											<div class="media-body">
												<h4>Blake Ruiz</h4>
												<h5>12th Feb, 2018 at 05:56 pm</h5>
												<a class="reply_btn" href="#">Reply</a>
											</div>
										</div>
										<p>Lorem ipsum dolor sit amet, consectetur adipisicing
											elit, sed do eiusmod tempor incididunt ut labore et dolore
											magna aliqua. Ut enim ad minim veniam, quis nostrud
											exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
									</div>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="review_box">
									<h4>Post a comment</h4>
									<form class="row contact_form" action="contact_process.php"
										method="post" id="contactForm" novalidate="novalidate">
										<div class="col-md-12">
											<div class="form-group">
												<input type="text" class="form-control" id="name"
													name="name" placeholder="Your Full name">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<input type="email" class="form-control" id="email"
													name="email" placeholder="Email Address">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<input type="text" class="form-control" id="number"
													name="number" placeholder="Phone Number">
											</div>
										</div>
										<div class="col-md-12">
											<div class="form-group">
												<textarea class="form-control" name="message" id="message"
													rows="1" placeholder="Message"></textarea>
											</div>
										</div>
										<div class="col-md-12 text-right">
											<button type="submit" value="submit" class="btn primary-btn">Submit
												Now</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- 교환/반품 정보 content -->
					<div class="tab-pane fade" id="profile" role="tabpanel"
						aria-labelledby="profile-tab">
						<div class="table-responsive">
							<table class="table">
								<tbody>
									<tr>
										<td style="width: 260px;">
											<h5>반품/교환 방법</h5>
										</td>
										<td>
											<h5>(미정)</h5>
										</td>
									</tr>
									<tr>
										<td>
											<h5>반품/교환 가능기간</h5>
										</td>
										<td>
											<h5>(미정)</h5>
										</td>
									</tr>
									<tr>
										<td>
											<h5>반품/교환 비용</h5>
										</td>
										<td>
											<h5>(미정)</h5>
										</td>
									</tr>
									<tr>
										<td>
											<h5>반품/교환 불가 사유</h5>
										</td>
										<td>
											<h5>(미정)</h5>
										</td>
									</tr>
									<tr>
										<td>
											<h5>소비자 피해보상<br/>환불지연에 따른 배상</h5>
										</td>
										<td>
											<h5>* 상품의 불량에 의한 반품, 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은<br/>
											소비자분쟁해결기준 (공정거래위원회 고시)에 준하여 처리됨</h5><br/>
											<h5>* 대금 환불 및 환불 지연에 따른 배상금 지급 조건, 절차 등은<br/>
											 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 처리함</h5>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--================End Product Description Area =================-->

		<!-- ================ Best Selling item  carousel ================= -->
		<section class="section-margin calc-60px">
			<div class="container">
				<div class="section-intro pb-60px">
					<p>Popular Book in the market</p>
					<h2>
						Best <span class="section-intro__style">Sellers</span>
					</h2>
				</div>
				<div class="owl-carousel owl-theme owl-loaded owl-drag" id="bestSellerCarousel">
					<c:forEach var="product" items="${topList }">
						<div class="card text-center card-product">
							<div class="card-product__img">
								<img class="img-fluid" src="${product.cover }" alt="">
								<ul class="card-product__imgOverlay">
									<li><button>
											<i class="ti-search"></i>
										</button></li>
									<li><button>
											<i class="ti-shopping-cart"></i>
										</button></li>
									<li><button>
											<i class="ti-heart"></i>
										</button></li>
								</ul>
							</div>
							<div class="card-body">
								<p>${product.author}|${product.publisher}</p>
								<h4 class="card-product__title">
									<a href="${contextPath}/product/detail?no=${product.product_no}">${product.title}</a>
								</h4>
								<p class="card-product__price">${product.sell_price}원</p>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</section>
		<!-- ================ Best Selling item  carousel end ================= -->
	</div>
	
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>
</html>