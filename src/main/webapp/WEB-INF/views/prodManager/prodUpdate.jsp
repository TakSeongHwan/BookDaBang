<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>



<script>
	let isbnCheck = false;
	let priceCheck = false;

	let product = {
		title : "",
		author : "",
		price : 0,
		sell_price : 0,
		publisher : "",
		category_code : 100,
		description : "",
		stock : 0,
		display_status : "",
		sales_status : "",
		pub_date : "",
		end_date : "",
		cover : "",
		detail_description : "",
		index : "",
		inside_book : "",
		author_introduce : "",
		pisOffdiscription : "",
		isbn : ""
	}

	window.onload = function() {
		let discount =(100-(${prod.sell_price/prod.price*100}));
		
		console.log(discount);
		$("#discount").val(discount);
		let pub_date = new Date(new Date('${prod.pub_date}') + 3240 * 10000).toISOString().split("T")[0];
		let end_date = new Date(new Date('${prod.end_date}') + 3240 * 10000).toISOString().split("T")[0];
		
		let cover = '<img src="${prod.cover}"id="prodImg" style="margin : 8px;"  width="200px"/>';
		$("#imgView").append(cover);
		
		$("#pub_date").val(pub_date);
		$("#endDate").val(end_date);

		$(window).on("beforeunload", callback);

		function callback() {
			let imagePath = $("#prodImg").attr("src");
			console.log(imagePath);
			let url = "/prodRest/c"
			$.ajax({
				url : url,
				dataType : "json",
				type : "delete",
				data : {
					imagePath : imagePath
				},
				success : function(data) {
					console.log(data);
				},
				error : function(data) {
					console.log(data);
				}
			});
		}

		$("#applyDiscount").on("click", function() {
			if ($("#price").val() != "") {
				outputvaliableMsg("올바른 데이터입니다.", $("#discount"));
				$("#applyDiscount").hide();
				$("#discount").css("display", "inline-block");
				$("#sellPriceBox").show();
			} else {
				outPutErrMessage("상품가격을 설정해주세요", $("#price"));
			}

		});

		$(document).on("blur", "#price", function() {
			if ($("#price").val() == "") {
				outPutErrMessage("공백ㄴ", $("#price"));

			}
		});
		$("#discount").on("keyup", function() {

			if (parseInt($("#discount").val()) < 100) {
				outputvaliableMsg("올바른 데이터입니다.", $("#discount"));
				let price = parseInt($("#price").val().replace(",", ""));
				let discount = parseInt($("#discount").val()) / 100;

				$("#sellPrice").val(price - (price * discount));
			} else {
				outPutErrMessage("할인율은 100이상일 수 없습니다", $("#discount"));
			}

		});

		$("#isbn").blur(function() {
			let isbn = $("#isbn").val();

			if (isbn == "") {
				outPutErrMessage("상품번호는 공백일 수 없습니다", $("#price"));
			} else {

				let url = "/prodRest/d";
				$.ajax({
					url : url,
					dataType : "text",
					type : "post",
					data : {
						isbn : isbn
					},
					success : function(data) {
						console.log(data)
						if (data == "validate") {
							outputvaliableMsg("올바른 데이터입니다.", $("#isbn"));
							apiSearch(isbn);
						} else if (data == "unValidate") {
							outPutErrMessage("중복된 상품번호(ISBN) 입니다", $("#isbn"));

						}

					},
					error : function(data) {
						console.log(data);
					}

				});
			}

		});

		$(document)
				.on(
						"click",
						"#urlImgSearch",
						function() {
							let searchVal = $("#urlSearch").val();
							if (urlExists(searchVal) == "200") {
								$("#imgView").show();
								let img = '<img src="'+ searchVal + '"id="prodImg" style="margin : 8px"  width="200px"/>';
								$("#imgView").append(img);
							} else {
								alert("존재하지 않는 url입니다");

							}

						});

		$(document)
				.on(
						"change",
						"#imgFile",
						function() {
							const imageInput = $("#imgFile")[0];
							console.log(imageInput.files);

							const formData = new FormData();
							formData.append("image", imageInput.files[0]);

							let url = "/prodRest/b";
							$
									.ajax({
										url : url,
										processData : false,
										contentType : false,
										dataType : "text",
										type : "post",
										data : formData,
										success : function(data) {
											console.log(data);
											$("#imgView").show();
											let img = '<img src="/resources/uploads'+ data + '" id="prodImg"  style="margin : 8px"/>';
											$("#imgView").append(img);

										},
										error : function(data) {
											console.log(data);
										}

									});

						});

		$(document).on(
				"change",
				"#selectEndDate",
				function() {
					now = new Date();
					if ($("#selectEndDate").val() == "1year") {
						let yearlater = new Date(now.setFullYear(now
								.getFullYear() + 1));
						product.end_date = yearlater.getTime() + "";
					} else if ($("#selectEndDate").val() == "6month") {
						let Xmonthlater = new Date(now
								.setMonth(now.getMonth() + 6));
						product.end_date = Xmonthlater.getTime();
					} else if ($("#selectEndDate").val() == "3month") {
						let Xmonthlater = new Date(now
								.setMonth(now.getMonth() + 3));
						product.end_date = Xmonthlater.getTime();
					} else if ($("#selectEndDate").val() == "1month") {
						let Xmonthlater = new Date(now
								.setMonth(now.getMonth() + 1));
						product.end_date = Xmonthlater.getTime();
					}

				});

		$(document).on("change", "#endDate", function() {
			product.end_date = $("#endDate").val();
			console.log(product);
		});

		$(document)
				.on(
						"click",
						"#addConfirm",
						function() {

							let output = '<label for="floatingInput" class="form-label"style="display: block">목차</label><input type="text"class="form-control addInfo" aria-describedby="defaultFormControlHelp" value= "'
									+ $("#index").val() + '" readonly/>';

							output += '<label for="floatingInput" class="form-label"style="display: block">상세설명</label><input type="text"class="form-control addInfo" aria-describedby="defaultFormControlHelp" value= "'
									+ $("#detail_description").val()
									+ '"readonly/>'
							output += '<label for="floatingInput" class="form-label"style="display: block">저자 정보 설정</label><input type="text"class="form-control addInfo" aria-describedby="defaultFormControlHelp" value= "'
									+ $("#author_introduce").val()
									+ '"readonly/>'
							output += '<label for="floatingInput" class="form-label"style="display: block">책속으로</label><input type="text"class="form-control addInfo" aria-describedby="defaultFormControlHelp" value= "'
									+ $("#inside_book").val() + '"readonly/>'
							output += '<label for="floatingInput" class="form-label"style="display: block">출판사 제공 책소개</label><input type="text"class="form-control addInfo" aria-describedby="defaultFormControlHelp" value= "'
									+ $("#pisOffdiscription").val()
									+ '"readonly/>'
							$("#addInfo").html(output);
						});

	}

	function outPutErrMessage(msg, obj) {
		$(".msg").remove();
		let output = "<div class= 'msg'>";
		$(output).insertAfter($(obj));
		$(".msg").html(msg);
		$(".msg").css("color", "red");
		$(obj).css("border-color", "red");
	}

	function outputvaliableMsg(msg, obj) {
		$(".msg").remove();
		let output = "<div class= 'msg'>";
		$(output).insertAfter($(obj));
		$(".msg").html(msg);
		$(".msg").css("color", "green");
		$(obj).css("border-color", "green");

	}

	function urlExists(url) {
		let http = $.ajax({
			type : "HEAD",
			url : url,
			async : false
		})
		return http.status;

	}

	function apiSearch(isbn) {
		let url = "/prodRest/a";
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : {
				isbn : isbn
			},
			success : function(data) {
				prodInfoView(data);
				console.log(data);
			}

		});

	}

	function prodInfoView(data) {

		$("#prodTitle").val(data.title);
		$("#author").val(data.author);
		$("#publisher").val(data.publisher);
		$("#description").val(data.description);
		$("#pub_date").val(data.pubDate);

	}

	function inputNumberFormat(obj) {

		obj.value = comma(uncomma(obj.value));
	}

	function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}

	function uncomma(str) {
		str = String(str);
		return str.replace(/[^\d]+/g, '');
	}

	function insertProduct() {

		product.isbn = $("#isbn").val();
		product.title = $("#prodTitle").val();
		product.price = parseInt($("#price").val().replace(",", ""));
		product.sell_price = parseInt($("#sellPrice").val().replace(",", ""));
		product.author = $("#author").val();
		product.publisher = $("#publisher").val();
		product.cover = $("#prodImg").attr("src");
		product.description = $("#description").val();
		product.index = $("#index").val();
		product.detail_description = $("#detail_description").val();
		product.inside_book = $("#inside_book").val();
		product.author_introduce = $("#author_introduce").val();
		product.pisOffdiscription = $("#pisOffdiscription").val();
		product.category_code = parseInt($("#category").val());
		product.display_status = $("#display_status").val();
		product.sales_status = $("#sales_status").val();
		product.stock = parseInt($("#stock").val());
		product.pub_date = $("#pub_date").val();

		console.log(product)

		let url = "/prodRest/update";
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : product,
			success : function(data) {
				console.log(data);
			}

		});

	}
</script>
<style>
.addInfo {
	width: 500px;
	overflow: hidden;
}
</style>
</head>
<body onunload="unload()">
	<jsp:include page="../managerHeader.jsp"></jsp:include>
	<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
			<h4 class="fw-bold py-3 mb-4">
				<span class="text-muted fw-light">상품 관리 /</span> 상품 수정
			</h4>

			<div class="row">
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">상품 정보</h5>
						<div class="card-body">
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">상품번호 / ISBN</label> <input type="text"
									class="form-control" id="isbn" placeholder="ISBN(상품번호)을 입력해주세요"
									aria-describedby="defaultFormControlHelp" value="${prod.isbn}" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">상품 명</label> <input type="text"
									class="form-control" id="prodTitle" placeholder="상품 명을 입력해주세요"
									aria-describedby="defaultFormControlHelp" value="${prod.title}" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">판매가격 설정</label> <input type="text"
									class="form-control" id="price" placeholder="50,000"
									aria-describedby="defaultFormControlHelp"
									style="width: 500px; display: inline-block;"
									onkeyup="inputNumberFormat(this)" value="${prod.price}" /> <input
									type="text" class="form-control" id="discount"
									placeholder="10%" aria-describedby="defaultFormControlHelp"
									style="width: 80px; display: inline-block;"
									onkeyup="inputNumberFormat(this)" />
							</div>
							<div class="mb-3" id="sellPriceBox">
								<label for="floatingInput" class="form-label"
									style="display: block">할인 가격</label> <input type="text"
									class="form-control" id="sellPrice" placeholder=""
									aria-describedby="defaultFormControlHelp"
									style="width: 500px; display: inline-block;" readonly
									value="${prod.sell_price}" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">재고</label> <input type="text"
									class="form-control" id="stock" placeholder=""
									aria-describedby="defaultFormControlHelp"
									style="width: 100px; display: inline-block;"
									onkeyup="inputNumberFormat(this)" value="${prod.stock}" />
							</div>

							<div id="defaultFormControlHelp" class="form-text">ISBN으로
								보다 빠르고 수월한 등록이 가능합니다.</div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">상품 이미지</h5>
						<div class="card-body">
							<div class="form-floating">

								<div class="mb-3">
									<label for="floatingInput" class="form-label"
										style="display: block">URI로 등록하세요!</label> <input type="text"
										class="form-control" id="urlSearch" placeholder="URI로 이미지 검색"
										aria-describedby="defaultFormControlHelp"
										style="width: 550px; display: inline-block;" />
									<button type="button" class="btn btn-outline-primary"
										id="urlImgSearch">검색</button>
								</div>
								<div class="mb-3">
									<label for="formFile" class="form-label">상품에 관한 이미지를
										선택하세요</label>
									<form id="uploadForm" enctype="multipart/form-data">
										<input class="form-control" type="file" id="imgFile"
											accept=".gif, .jpg, .png" />
									</form>
								</div>
								<div id="imgView"
									style="border: 1px solid #ccc; padding: 20px">
									<label for="floatingInput" class="form-label"
										style="display: block">상품 이미지</label>
								</div>
								<div id="floatingInputHelp" class="form-text">상품 이미지는 하나만
									등록할 수 있습니다</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Form controls -->
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">저자 정보</h5>
						<div class="card-body">
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">작가</label> <input type="text"
									class="form-control" id="author" placeholder="작가"
									aria-describedby="defaultFormControlHelp" readonly
									value="${prod.author}" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">출판사</label> <input type="text"
									class="form-control" id="publisher" placeholder="출판사"
									aria-describedby="defaultFormControlHelp" readonly
									value="${prod.publisher}" /> <label for="floatingInput"
									class="form-label" style="display: block">출판일</label> <input
									type="date" class="form-control" id="pub_date"
									placeholder="출판일" aria-describedby="defaultFormControlHelp"
									readonly style="width: 200px" value="${prod.pub_date}" />
							</div>

						</div>
					</div>
				</div>

				<!-- Input Sizing -->
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">책 정보</h5>
						<div class="card-body">
							<label class="form-label">카테고리 설정</label> <select id="category"
								class="select2 form-select" style="width: 200px">
								<option selected disabled hidden>카테고리 설정</option>
								<c:forEach var="CategoryVO" items="${category}">
									<c:choose>
										<c:when
											test="${prod.category_code == CategoryVO.category_code}">
											<option selected value="${CategoryVO.category_code}">
												<c:out value="${CategoryVO.category_name}" /></option>
										</c:when>
										<c:otherwise>
											<option value="${CategoryVO.category_code}">
												<c:out value="${CategoryVO.category_name}" /></option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select> <small class="text-light fw-semibold" style="margin-top: 10px">간략
								설명 (1000자 이하)</small>
							<div class="mb-3">
								<div>
									<textarea class="form-control" id="description" rows="3">${prod.description}</textarea>
								</div>
								<div id="addInfo"></div>
								<div class="mb-3">
									<label for="floatingInput" class="form-label"
										style="display: block">저자소개정보 작성</label>

									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#fullscreenModal">
										부가 정보 작성</button>

								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">상품 수정하기</h5>
						<div class="card-body">

							<div class="statusBox">
								<div class="displayStatus"
									style="width: 220px; display: inline-block;">
									<label class="form-label">진열 상태</label> <select
										id="display_status" class="select2 form-select"
										style="width: 200px">
											<option value="yes">진열</option>
										<c:choose>
											<c:when test="${prod.display_status == 'no'}">
												<option selected value="no">진열안함</option>
											</c:when>
											<c:otherwise>
												<option value="no">진열안함</option>
											</c:otherwise>
										</c:choose>

									</select>
								</div>
								<div class="salesStatus"
									style="width: 220px; display: inline-block;">
									<label class="form-label">판매 상태</label> <select
										id="sales_status" class="select2 form-select"
										style="width: 200px">
										<option value="sale">판매</option>
										
											<c:choose>
											<c:when test="${prod.sales_status == 'notSales'}">
												<option selected value="notSales">판매안함</option>
											</c:when>
											<c:otherwise>
												<option value="notSales">판매안함</option>
											</c:otherwise>
										</c:choose>
										
										<c:choose>
											<c:when test="${prod.sales_status == 'soldOut'}">
												<option selected value="soldOut">품절</option>
											</c:when>
											<c:otherwise>
												<option value="soldOut">품절</option>
											</c:otherwise>
										</c:choose>
									</select>
								</div>
							</div>
							<div class="endDateBox">
								<div class="selectEndDate"
									style="width: 220px; display: inline-block;">
									<label class="form-label">마감 날짜</label> <select
										id="selectEndDate" class="select2 form-select"
										style="width: 200px">
										<option selected disabled hidden>마감날짜 설정</option>
										<option>제한 없음</option>
										<option value="1year">1년</option>
										<option value="6month">6개월</option>
										<option value="3month">3개월</option>
										<option value="1month">1개월</option>
									</select>
								</div>
								<div class="EndDate"
									style="width: 220px; display: inline-block; margin-top: 20px;">
									<label class="form-label">마감 날짜(직접)</label> <input type="date"
										class="form-control" id="endDate" placeholder="출판사"
										aria-describedby="defaultFormControlHelp" style="width: 200px" />
								</div>
							</div>


							<button type="button" class="btn btn-primary"
								onclick="insertProduct()" style="margin-top: 20px">저장하기</button>
							<button type="button" class="btn btn-primary"
								onclick="insertProduct()" style="margin-top: 20px">상품
								수정</button>
						</div>
					</div>
				</div>



			</div>
		</div>
	</div>

	<div class="modal fade" id="fullscreenModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-fullscreen" role="document">
			<div class="modal-content"
				style="width: 60%; margin: 0 auto; height: 75%">
				<div class="modal-header">
					<h5 class="modal-title" id="modalFullTitle">부가 정보 작성</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<div>
							<ul class="nav nav-pills" style="width: 800px; margin: 0 auto">
								<li class="nav-item"><a class="nav-link active"
									data-bs-toggle="pill" href="#menu1">목차 설정</a></li>
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="pill" href="#menu2" id="detailBtn">상세 설명</a></li>
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="pill" href="#menu3">저자 정보 설정</a></li>
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="pill" href="#menu4">책속으로</a></li>
								<li class="nav-item"><a class="nav-link"
									data-bs-toggle="pill" href="#menu5">출판사 제공 책소개</a></li>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<div class="tab-pane container active" id="menu1">
									<div>
										<textarea class="form-control" id=index " rows="17">${prod.index}</textarea>
									</div>
								</div>
								<div class="tab-pane container fade" id="menu2">
									<div>
										<textarea class="form-control" id="detail_description"
											rows="17">${prod.detail_description}</textarea>
									</div>
								</div>
								<div class="tab-pane container fade" id="menu3">
									<div>
										<textarea class="form-control" id="author_introduce" rows="17">${prod.author_introduce}</textarea>
									</div>
								</div>
								<div class="tab-pane container fade" id="menu4">
									<div>
										<textarea class="form-control" id="inside_book" rows="17">${prod.inside_book}</textarea>
									</div>
								</div>
								<div class="tab-pane container fade" id="menu5">
									<div>
										<textarea class="form-control" id="pisOffdiscription"
											rows="17">${prod.pisOffdiscription}</textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="addConfirm">확인</button>
					<button type="button" class="btn btn-outline-secondary"
						data-bs-dismiss="modal">Close</button>

				</div>
			</div>
		</div>
	</div>




	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>