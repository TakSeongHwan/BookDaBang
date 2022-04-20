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
	let rno = 0;
	let cno = 0;
	
	$(function() {
		priceReplace();
		quantity(1);
		infoReplace();
		navColor();
		starMaker();
		reviewStar();
		reviewStatus();	
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
	
	function getComment(no,obj) { //$(".comments-area").length == 1 && rno != no
		if (rno == no) {
			$(".comments-area").remove();
			rno = 0;
			return;
		} else {
			$(".comments-area").remove();
			let url = "/Rcomment/all/" + no;
			console.log(url);
			$.ajax({
				url : url,
				dataType : "json",
				type : "get",
				success : function (data) {
					console.log(data);	
					if (data != null) {
						parseComment(data,obj);
					}
				},error : function() {
					parseComment(null,obj);
				}
			});	
		}
		rno = no;
	}
	
	function parseComment(data,obj) {
		let output = '<div class="comments-area" style="display:none;">';
		if (data != null) {
			$.each(data, function(i, e) {
				output += '<div class="comment-list" style="padding-bottom: 25px;">';
				output += '<div class="single-comment justify-content-between d-flex" id ="' + e.commentNo +
						'" value = "' + $(obj).val() + ',' + e.ref + ',' + e.step + ',' + e.reforder + '">';
				output += '<div class="user justify-content-between" style="width:800px;"><div class="desc">';
				for (let i = 0; i < e.step; i++) {
					output += '<img src="${contextPath}/resources/img/review/reply.png" id= "replyImg" />';
				}
				output += '<p class="commenter">' + e.commenter + '</p>';
				
				let writtenDate = calcDate(e.writeDate);
				if (writtenDate == '방금전') {
					output += '<p class="date" style="color:red;">' + writtenDate + '</p>';
				} else if (writtenDate.indexOf('분전') != -1){
					output += '<p class="date" style="color:blue;">' + writtenDate + '</p>';
				} else {
					output += '<p class="date">' + writtenDate + '</p>';
				}
				
				output += '<p class="comment">' + e.comment + '</p></div></div>';
				output += '<div class="reply-btn"><a href="javascript:replyMaker(' + e.commentNo + ');" class="btn-reply text-uppercase">'
				+ 'reply</a></div></div></div>';
			});
		}
		 output += '<hr/><textarea class="form-control" name="comment" id= "commentText" rows="3" placeholder="comment"></textarea>';
		 let rno = $(obj).val();
		 output += '<button type="" class="button button--active button-contactForm" onclick="addComment(' + rno + ');" style="float:right;">댓글 작성</button></div>';
		 
		 $(obj).parent().after(output);
		 $(".comments-area").slideDown(500);	 
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
	
	function replyMaker(no) {
		//$(".comments-area").html().indexOf("replyForm") == -1) // $("#replyForm").length != 1
		if (cno == no) {
			$("#replyForm").remove();
			cno = 0;
			return;
		} else {
			$("#replyForm").remove();
			let output = '<div id= "replyForm"><hr/><textarea class="form-control" name="reply" id= "replyText" rows="3" placeholder="reply"></textarea>';
			output += '<button class="button button--active button-contactForm" onclick="addReply(' + no +
					')" style="float:right; width: 90px;">답글 작성</button></div>';	
			$("#" + no).after(output);
		}
		cno = no;
	}
	
	function addComment(rno) {
		let id = "${sessionId}";
		let comment = $('#commentText').val();
		
		if (id) {
			if (comment != "") {
				let reviewNo = parseInt(rno);
				let url = '/Rcomment';
				let sendData = JSON.stringify({
					reviewNo : reviewNo, commenter : id, comment : comment
				});
				console.log(sendData);
				$.ajax({
					url : url,
					data : sendData,
					dataType : "text",
					type : "post",
					headers : {
						"content-type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					success : function (data) {
						console.log(data);
						if(data == "success") {
							alert("댓글 등록 성공");
							location.reload();
							
						} else if(data == "fail") { 
							alert("댓글등록실패");
						}
					}
				});
			} else {
				validate("#commentText",1);
			}	
		} else {
			loginAlarm();
		}
	}
	
	function addReply(no) {
		let id = "${sessionId}";
		let comment = $('#replyText').val();
		if (id) {
			if (comment != "") {
				// 필요한 형태로 변환
				let str = $("#" + no).attr("value");
				let reviewNo = parseInt(str.split(",")[0]);
				let ref = parseInt(str.split(",")[1]);
				let step = parseInt(str.split(",")[2]);
				let reforder = parseInt(str.split(",")[3]);
				
				let url = '/Rcomment';
				let sendData = JSON.stringify({
					commenter : id, comment : comment, reviewNo : reviewNo,
					ref : ref, step : step, reforder : reforder
				});
				console.log(sendData);
				$.ajax({
					url : url,
					data : sendData,
					dataType : "text",
					type : "post",
					headers : {
						"content-type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
					success : function (data) {
						console.log(data);
						if(data == "success") {
							alert("답글 등록 성공");
							location.reload();
						} else if(data == "fail") { 
							alert("답글등록실패");
						}
					}
				});
			} else {
				validate("#replyText",1);
			}	
		} else {
			loginAlarm();
		}
	}
	
	function loginAlarm() {
		alert("로그인 후 이용가능합니다!");
		location.href = "/login";
	}
	
	function validate(obj,version) {
		$('#msg').remove();
		let output = "";
		if (version == 1) {
			output = "<div id ='msg' style='color:red; padding-bottom: 15px;'>내용을 입력해주세요</div>";
		} else {
			output = "<div id ='msg' style='color:red; padding-bottom: 13px; margin-left: 10px;'>별점을 선택해주세요</div>";
		}
		
		$(obj).before(output);
		$(obj).focus();
	}
	
	function like(rno,obj) {
		let url = "/review/like?no=" + rno + "&change=1";
		console.log(url);	
		$.ajax({
			url : url,
			dataType : "text",
			type : "get",
			success : function (data) { // 아직 미완성
				console.log(data);	
				if (data == "success") {
					alert("좋아요 성공");	
				} else if(data == "fail") { 
					alert("좋아요 실패");
				}
			}
		});	
	}
	
	function showModal() {
		if ("${sessionId}") {
			$(".newStar").css("font-weight", 100);
			$("#msg").remove();
			$("#modalBack").fadeIn(400);
			$('body').css("overflow", "hidden");
		} else {
			loginAlarm();
		}
	}
	
	function cancleModal() {
		 $("#modalBack").fadeOut(400);
		 $('body').css("overflow", "scroll"); 
	}
	 
	function reviewStar() {
		$(document).on("mouseover", ".newStar", function(){
			let n = $(this).attr("id").split("star")[1];
			$(".newStar").css("font-weight", 100);
			for (let i = 1; i <= n; i++) {
				$("#star" + i).css("font-weight", 900);
			}
			$("#starCount").val(n);
		});
	}
	
	function addReview() {
		if ($(".newStar").css("font-weight") == 100) {
			validate($(".rating_list div"), 2);
			return false;
		}
	}
	
	function reviewStatus() {
		let status = '${result}';
		if(status == "success") {
			alert("리뷰 등록 성공");
		} else if (status == "fail") {
			alert("리뷰 등록 실패");
		}
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
 
<<<<<<< HEAD
 .commenter {
 	text-align : left;
 	font-size: 20px;
 }
 
 #commentText, #replyText {
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
 
 #replyImg {
 	width : 20px;
 	height : 20px;
 	margin-right: 10px;
 	margin-bottom: 5px;
 }
 
 #modalBack {
 	position: fixed;
 	top:0; left: 0; bottom: 0; right: 0;
 	background:rgba(0,0,0,.3);
 	z-index: 999;
 	display: none;
 }
 
 #reviewModal {
		position: absolute;
  		top: 18%; left: 31%;
  		overflow: auto;
  		width: 800px; height: 600px;
  		border-radius : 25px;
  		box-shadow : 10px 10px 10px 10px;
}
 
 .newStar {
 	color : #fbd600;
 	font-size: 30px;
 }
 
=======
#qnaTable>thead>tr, #qnaTable>tbody>tr {
	text-align :center;
	
}
#qnaTable>thead>tr>th, #qnaTable>tbody>tr>td {
	padding: 5px;
	padding-top : 10px;
	padding-bottom : 10px;
	margin : 0px;
	width: 100px;
}

#qnaPagingZone {
	width: 700px;
	margin: 0 auto;
}

.pagination {
	width: 300px;
	margin: 0 auto;
}

>>>>>>> 3909fb220075723b22f0a0f983a2e20838366a06
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
										${product.category_code}</a></li>
								<li><a href="#"><span>재고</span> : ${product.stock}개</a></li>
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
											style="float: right;" onclick="showModal()"> 리뷰 작성</button>
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
														style="padding: 5px" onclick="like(${review.reviewNo},this)">♡ ${review.recommendNum}</button>
														<button class="button button-header reviewBtn" style="padding: 8px" value="${review.reviewNo}"
														onclick="getComment(${review.reviewNo},this)">댓글 ${review.commentNum}</button>
													</div>
													<hr style="border-style: dotted; margin-top: 35px; margin-bottom: 4px" />
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							
						</div>
					</div>
					<!-- Q&A 정보 content -->
					<script>
						let sessionId = "";
						let userNickName = "";
						let isbn = "${product.isbn}"
						let product_qna = {
								isbn : "",
								writer : "",
								content : "",
								pwd : ""
						}
						
						let pageNo = 1;
						window.onload = function() {
							sessionId = "${sessionId}";
							getUserNickName(sessionId);
							
							ViewSelectQnA(3, pageNo);
							console.log(isbn);
							console.log(userNickName);
						
							
							
							
														
							$(document).on("click", "#writeQnA", function() {
								let login = "${sessionId}";
								console.log(login);
								if(login == ""){
								alert("로그인한 유저만 글을 작성할 수 있습니다");
								location.href ="/login";
								} else {
								
								$("#qnaContent").val("");
								$("#pwd").val("");
								$("#qnaContainer").toggle();
								$("#qnaContentBox").toggle();
								
								
								
								}
							});
							
							$(document).on("click", "#backTolist", function() {
								$("#qnaContainer").toggle();
								$("#qnaContentBox").toggle();
							});
							
							
							
							
						
						
						$(document).on("click", "#insertQnA", function() {
							
							product_qna.content = ($("#qnaContent").val());
							product_qna.pwd = ($("#pwd").val());
							product_qna.writer = "${sessionId}";
							product_qna.isbn = "${product.isbn}";
							console.log(product_qna);
							
							
							url = "/prodQna/"  
							$.ajax({
								url : url,
								dataType : "text",
								type : "post",
								data : product_qna,
								success : function(data) {
									
									if(data == "success"){
									alert("정상적으로 등록되었습니다");
									location.reload();
									} else {
									alert("등록 안됨");
									location.reload();
									}
								}

							});
							
							
						});
						
						$(document).on("click", ".deleteBtn", function() {
							let index = $(".deleteBtn").index(this);
							console.log($(".questionNo").eq(index).attr("id"));
							let question_no = $(".questionNo").eq(index).attr("id");
							
							let url = "/prodQna/deleteQnA" 
							$.ajax({
								url : url,
								dataType : "text",
								type : "post",
								data : {question_no : question_no},
								success : function(data) {
									
									if(data == "success"){
									alert("삭제 완뇨");
									location.reload();
									
									} else {
									alert("삭제 안됨 ㅠ");
									
									}
								}

							});
							
							
						});
							
						
						
						}
						
						
						function getUserNickName(sessionId) {
							let url = "/prodQnARest/"+sessionId; 
								$.ajax({
									url : url,
									dataType : "text",
									type : "get",
									success : function(data) {
										userNickName = data;
										console.log(data);
											
										}
									});
						}
							
						
						function viewProdQnA(data) {
							
							$("#viewProdQnA").empty();
							
							$("#qnaPagingZone").empty();
							let output = "";
							$.each(data.qnaList, function(i, e) {
								let writeDate = new Date(
										+new Date(e.write_date) + 3240 * 10000)
										.toISOString().split("T")[0];
								if(e.ref_order < 1){
								output += "<tr><td class='questionNo' style='width : 20px' id='"+e.question_no+"'>" + e.question_no + "</td>";
								
								if(e.pwd != null){
									if(userNickName == e.writer){
										output += "<td style ='text-align : left;width:500px'>" + e.content + "</td>";	
									} else{
										output += "<td style ='text-align : left;width:500px'><img src='/resources/img/etc/lock.png' width='18px'>비공개 글입니다.</td>";
									}
									
								} else{
									
									output += "<td style ='text-align : left;width:500px'>" + e.content + "</td>";
								}
								
								let writer = e.writer.substr(0,2) + "**";
								output += "<td>" + writer + "</td>";
								
								output +="<td>"+writeDate+"</td>"
								let answerStatus = ""
								if(e.answer_status == "wating"){
									answerStatus ='<span class="badge bg-secondary" style="font-size : 12px">답변대기</span>';
								}else{
									answerStatus ='<span class="badge bg-primary" style="font-size : 12px">답변완료</span>';
								}
								output += '<td>' + answerStatus + '</td>'
								output += '<td>'
								
								if(userNickName == e.writer){
									output += "<span class='badge bg-danger deleteBtn' >삭제</span>";
									} 
								output+='</td>'
								} else {
									
									output += "<tr><td></td>";
									if(e.pwd != null){
										if(userNickName == e.writer){
									output += "<td style ='text-align : left;width:500px'>ㄴ<span class='badge bg-secondary' style='font-weight :300; background-color : #ccc!important'>답변</span>&nbsp&nbsp" +e.content+"</td>";
										}  else {
											output += "<td style ='text-align : left;width:500px; color : #ccc'>ㄴ<img src='/resources/img/etc/lock.png' width='18px'>비공개 답변입니다.</td>";
										}
										}else {
											output += "<td style ='text-align : left;width:500px'>ㄴ<span class='badge bg-secondary' style='font-weight :300; background-color : #ccc!important'>답변</span>&nbsp&nbsp" +e.content+"</td>";	
										}
									output += "<td></td>"
									output += "<td>"+writeDate+"</td>";
									output += "<td></td>";
									
								}	
							});
							let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

								if (pageNo != 1) {
									pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(3,1)'><<</a></li>";
									pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(3,"
											+ (pageNo - 1)
											+ ")'><</a></li>";
								}
								for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
									if (pageNo == i) {
										pagingoutput += "<li class='page-item active' onclick='ViewSelectQnA(3,"
												+ i + ")'><a class='page-link'>" + i + "</a></li>";
									} else {
										pagingoutput += "<li class='page-item'><a class='page-link' onclick='ViewSelectQnA(3,"
												+ i + ")'>" + i + "</a></li>";
									}

								}

								if (pageNo < data.pagingInfo.totalPage) {
									pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='ViewSelectQnA(3,"
											+ (pageNo + 1)
											+ ")'>></a></li>";
									pagingoutput += "<li class='page-item last' onclick='ViewSelectQnA(3,"
											+ data.pagingInfo.totalPage
											+ ")'><a class='page-link' >>></a></li>";
								}

								pagingoutput += '</ul></nav>'
							
							
							
							
							
							$("#viewProdQnA").append(output);
							
							$("#qnaPagingZone").append(pagingoutput);
							
						}
						
						function ViewSelectQnA(answerStatus, tmp) {

							pageNo = tmp;

							url = "/prodQnARest/list?pageNo=" + pageNo + "&answerStatus="+ answerStatus +"&isbn=" + isbn;
							$.ajax({
								url : url,
								dataType : "json",
								type : "get",
								success : function(data) {
									console.log(data);
									if (answerStatus == 1) {
										viewNotAnswer(data);
									} else if (answerStatus == 2) {
										viewAnswer(data);
									} else {
										viewProdQnA(data);
									}

								}

							});
						}
						
					</script>
					<style>
						#writeQnA:hover {
							color: #000;
						}
					</style>
					
					<!-- Q&A 정보 content -->
					<div class="tab-pane fade" id="contact" role="tabpanel"
						aria-labelledby="contact-tab">
						
						<div class="container-xxl flex-grow-1 container-p-y">
			<h4 class="fw-bold py-3 mb-4">
				<span class="text-muted fw-light">Question &</span> Answer
			</h4>
						
						<div id="qnaContainer">
						<table class="table" id="qnaTable">
							<thead>
								<tr>
									<th>글번호</th>
									<th style="width: 700px; text-align: center" >내용</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>답변상태</th>
									<th>비고</th>
									
								</tr>
							</thead>
							<tbody class="table-border-bottom-0" id="viewProdQnA">

							</tbody>
						</table>
						
						<div id="qnaPagingZone"></div>
						<a class="button button--active button-contactForm" id="writeQnA" style="color : #fff;" >글 작성</a>
						</div>
						
						
						<div id="qnaContentBox" style="display : none">
						<span style="font-size : 21px; line-height: 70px">Q&A를 작성하세요</span>
						<div style ="float: right;  display : inline-block;">
						<label class="form-label">비밀번호 입력(선택)</label>
						<input type="text" class="form-control" id="pwd" placeholder="Password" aria-describedby="defaultFormControlHelp" style="width:200px; margin-bottom: 10px " />
						</div>
						<textarea class="form-control" id="qnaContent" id=index " rows="9"></textarea>
						<a class="button button--active button-contactForm" id="backTolist" style="color : #fff; margin-top: 10px;">뒤로가기</a>
						<a class="button button--active button-contactForm" id="insertQnA" style="color : #fff; margin-top: 10px;" >글등록</a>
						
						
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
		
		<!-- 리뷰 작성 모달창 -->
		<div id="modalBack">
			<div class="comment-form" id="reviewModal">
				<h3 style="margin-bottom: 70px;">리뷰 작성</h3>
				<form action="/review" method="post">
					<div class="form-group form-inline">
						<div class="form-group col-lg-8 col-md-8 name">
							<h4 style="margin-bottom: 15px;">제목 </h4>
							<input type="text" class="form-control" id="title" name = "title"
								placeholder="Enter title" required=""
								style="border-radius : 20px;">
							<input type="hidden" name ="writer" value="${sessionId }">
						</div>
						<div class="form-group col-lg-4 col-md-4 rating_list">
							<h4 style="margin-bottom: 15px;">등급 </h4>
							<div>
								<i class="fa fa-star newStar" id="star1" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star2" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star3" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star4" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star5" style="font-weight: 100"></i>
							</div>
							<input type="hidden" id ="starCount" name ="grade">
						</div>
					</div>
					<div class="form-group">
						<h4 style="text-align: left; margin-bottom: 15px;">내용</h4>
						<textarea class="form-control mb-10" rows="5" name="content"
							placeholder="content" required=""
							style="border-radius : 20px;"></textarea>
					</div>
					<input type="hidden" name ="productNo" value="${product.product_no }">
					
					<button type="submit" class="button button--active"
					 onclick="return addReview();" style="margin: 25px;"> 작성하기 </button>
					<button type="reset" class="button button--active"
					 onclick="cancleModal()" style="margin: 25px;"> 취소하기 </button>
				</form>
			</div>
		</div>

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
									<li>
										<a href="${contextPath}/product/detail?no=${product.product_no}">
											<button><i class="ti-search"></i></button>
										</a>
									</li>
									<li>
										<a href="">
											<button><i class="ti-shopping-cart"></i></button>
										</a>
									</li>
									<li>
										<a href="">
											<button><i class="ti-money"></i></button>
										</a>
									</li>
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