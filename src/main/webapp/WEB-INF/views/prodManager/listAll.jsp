<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminHome</title>

<script>
	let pageNo = 1;
	let JsonSearchCriteria = "";
	let checkAry = [];
	let SearchCriteria = {
		searchWord : "",
		category_code : "",
		searchType : "",
		startRgDate : "",
		endRgDate : "",
		startUpdate : "",
		endUpDate : "",
		display_status : "",
		sales_status : "",
		sortWord : "",
		sortMethod : ""
	}

	window.onload = function() {
		searchProduct(SearchCriteria, pageNo);

		$("#allcheck").change(function() {
			if ($("#allcheck").is(":checked")) {
				$(".prodCheck").prop("checked", true);
			} else {
				$(".prodCheck").prop("checked", false);
			}
		});

		$(".sortBtn").on("click", function() {
			$(".sortBtn").not(this).html("▽");
			if ($(this).html() == "▽") {
				$(this).html("△");
				SearchCriteria.sortWord = $(this).attr("id");
				SearchCriteria.sortMethod = "desc";
				JsonSearchCriteria = JSON.stringify(SearchCriteria);
				searchProduct(SearchCriteria, pageNo);

			} else {
				$(this).html("▽");
				SearchCriteria.sortWord = $(this).attr("id");
				SearchCriteria.sortMethod = "asc";
				JsonSearchCriteria = JSON.stringify(SearchCriteria);
				searchProduct(SearchCriteria, pageNo);
			}

		});

		$("#all_status").change(function() {
			if ($("#all_status").is(":checked")) {
				$("input[name='sales_status']").prop("checked", false);
				$("input[name='display_status']").prop("checked", false);
				SearchCriteria.display_status = "";
				SearchCriteria.sales_status = "";

			}
		});

		$(".display_status").change(function() {
			if ($(".display_status").is(":checked")) {
				SearchCriteria.display_status = $(this).val();
				$("#all_status").prop("checked", false);
			}
		});
		$(".sales_status").change(function() {
			if ($(".sales_status").is(":checked")) {
				SearchCriteria.sales_status = $(this).val();
				$("#all_status").prop("checked", false);
			}
		});

		$("#batchUpdate").on("click", function() {
			checkAry = [];
			for (let i = 0; i < 10; i++) {
				if ($(".prodCheck").eq(i).is(":checked")) {
					checkAry.push($(".prodCheck").eq(i).attr("id"));
					console.log(checkAry[i]);
				}

			}

			prodselectview(checkAry);

		});

		let thistag = "";
		let thisval = "";
		$(document)
				.on(
						"dblclick",
						".updatePrice",
						function() {
							thistag = $(this);
							thisval = $(this).text();
							console.log(thistag, thisval);
							let input = '<input type="text" id="a" style= "width :60px" value="'
									+ $(this).text() + '">'
							$(this).html(input);

							$(document).on(
									"blur",
									"#a",
									function() {
										if ($(this).val() == thisval
												|| $(this).val() == "") {
											console.log($(this).val());
											thistag.html(thisval);
										} else if ($(this).val() != thisval) {
											thistag.html($("#a").val());
											thistag.css("color", "orange");
										}

									});

						});

		$(document).on("click", "#updateReset", function() {
			prodselectview(checkAry);
		});

	}

	function prodselectview(checkAry) {
		$("#selectProdView").empty();
		let contextPath = ${contextPath}
		$("#selectProdView").html('<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style="width : 100px" ></div>');
		let url = "/prodRest/up";
		
		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : {
				checkBoxs : checkAry
			},
			success : function(data) {
				console.log(data);

				selectProdView(data);
			}

		});
	}

	function search() {
		pageNo = 1;

		$(".sortBtn").html("▽");
		SearchCriteria.sortWord = "";
		SearchCriteria.sortMethod = "";
		SearchCriteria.searchWord = $("#searchWord").val();
		SearchCriteria.category_code = parseInt($("#category").val());
		SearchCriteria.searchType = $("#serachType").val();
		SearchCriteria.startRgDate = $("#startRgDate").val();
		SearchCriteria.endRgDate = $("#endRgDate").val();
		SearchCriteria.startUpdate = $("#startUpdate").val();
		SearchCriteria.endUpDate = $("#endUpDate").val();

		JsonSearchCriteria = JSON.stringify(SearchCriteria);
		console.log(JsonSearchCriteria);
		searchProduct(SearchCriteria, pageNo);

	}

	function searchProduct(sc, pno) {
		
		$("#productView").html('<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style ="width : 150px"></div>');
		pageNo = pno;
		console.log(pageNo);
		console.log(sc);
		$("#allcheck").prop("checked", false)

		let url = "/prodRest/all/" + pageNo;

		$.ajax({
			url : url,
			dataType : "json",
			type : "post",
			data : sc,
			success : function(data) {
				console.log(data)
				searchView(data);
			}

		});

	}

	function searchView(data) {
		$("#productView").empty();
		$("#pagingZone").empty();
		let output = "";
		let displayStatus = "";
		let salesStatus = "";
		let rgDate = "";
		let upDate = "";
		let endDate = "";
		JsonSearchCriteria = JSON.stringify(SearchCriteria);

		/* let PageNo = parseInt(data.pageNo); */
		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		$
				.each(
						data.product,
						function(i, e) {
							output += '<tr><td> <input class="form-check-input prodCheck"  type="checkbox" id="'+e.isbn+'" /></td>';
							output += '<td>' + e.isbn + '</td>';
							output += '<td><img src ="' + e.cover + '" width="50" /></td>';
							output += '<td>' + e.title + '</td>';
							output += '<td><div>' + e.price + '</div>'
							output += '<div style="color : #ccc">'
									+ +e.sell_price + '</div></td>';
							output += '<td>' + e.stock + '</td>';
							rgDate = new Date(
									+new Date(e.rg_date) + 3240 * 10000)
									.toISOString().split("T")[0];

							if (!e.update_date) {
								upDate = "수정날짜 없음";
							} else {

							}
							output += '<td><div>' + rgDate + '</div>';
							output += '<div style="color : #ccc">' + upDate
									+ '</div></td>';
							endDate = new Date(
									+new Date(e.end_date) + 3240 * 10000)
									.toISOString().split("T")[0];
							output += '<td>' + endDate + '</td>';
							output += '<td>' + e.sales_count + '</td>';
							output += '<td>' + e.read_count + '</td>';
							if (e.display_status == "yes") {
								displayStatus = '<span class="badge bg-label-primary">진열</span>';
							} else {
								displayStatus = '<span class="badge bg-label-warning">진열안함</span>';
							}
							output += '<td>' + displayStatus + '</td>';
							if (e.sales_status == "sale") {
								salesStatus = '<span class="badge bg-label-primary">판매중</span>';
							} else if (e.sales_status == "soldOut") {
								salesStatus = '<span class="badge bg-label-danger">품절</span>';
							} else {
								salesStatus = '<span class="badge bg-label-warning">판매안함</span>';
							}
							output += '<td>' + salesStatus + '</td></tr>';

						});

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchProduct("
					+ JsonSearchCriteria
					+ ","
					+ 1
					+ ")' ><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchProduct("
					+ JsonSearchCriteria
					+ ","
					+ (pageNo - 1)
					+ ")' ><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active'><a class='page-link' onclick='searchProduct("
						+ JsonSearchCriteria
						+ ","
						+ i
						+ ")'>"
						+ i
						+ "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='searchProduct("
						+ JsonSearchCriteria
						+ ","
						+ i
						+ ")'>"
						+ i
						+ "</a></li>";
			}
		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchProduct("
					+ JsonSearchCriteria
					+ ","
					+ (pageNo + 1)
					+ ")' ><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchProduct("
					+ JsonSearchCriteria
					+ ","
					+ (data.pagingInfo.totalPage)
					+ ")' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'

		$("#pagingZone").append(pagingoutput);

		$("#productView").append(output);

	}

	function selectProdView(data) {
		$("#selectProdView").empty();
		let output = "";
		$
				.each(
						data,
						function(i, e) {
							output += '<tr><td> <input class="form-check-input prodCheck"  type="checkbox" id="'+e.isbn+'" /></td>';
							output += '<td>' + e.isbn + '</td>';
							output += '<td><img src ="' + e.cover + '" width="50" /></td>';
							output += '<td>' + e.title + '</td>';
							output += '<td><div class="updatePrice">' + e.price
									+ '</div></td>'
							output += '<td><div class="updatePrice">' + e.stock
									+ '</div></td>'
							if (e.display_status == "yes") {
								displayStatus = '<span class="badge bg-label-primary">진열</span>';
							} else {
								displayStatus = '<span class="badge bg-label-warning">진열안함</span>';
							}
							output += '<td>' + displayStatus + '</td>';
							if (e.sales_status == "sale") {
								salesStatus = '<span class="badge bg-label-primary">판매중</span>';
							} else if (e.sales_status == "soldOut") {
								salesStatus = '<span class="badge bg-label-danger">품절</span>';
							} else {
								salesStatus = '<span class="badge bg-label-warning">판매안함</span>';
							}
							output += '<td>' + salesStatus + '</td></tr>';
							output += '</tr>';
						});

		$("#selectProdView").append(output);

	}
</script>
<style>
.container {
	width: 100%;
	height: 80px;
	line-height: 80px;
}

.searchContainer {
	width: 100%;
	padding: 30px;
	height: 470px;
	display: inline-block;
}

.searchText {
	margin: 0 auto;
	width: 1200px;
}

.card {
	width: 100%;
}

td {
	max-width: 200px;
	overflow: hidden;
}

th {
	
}

.searchZoon {
	width: 1300px;
	margin: 0 auto;
}

.searchZoon>div {
	float: left;
}

.categorySearch {
	width: 180px;
	display: inline-block;
	margin-top: 3px;
}

.rgDateSearch {
	width: 350px;
}

.rgDateSearch>label {
	margin-top: 3px;
	display: block
}

.rgDateSearch>input {
	width: 150px;
	display: inline-block;
}

.upDateDateSearch {
	float: right;
	width: 500px;
}

.upDateDateSearch>label {
	margin-top: 3px;
	display: block
}

.upDateDateSearch>input {
	width: 150px;
	display: inline-block;
}

#pagingZone {
	width: 700px;
	margin: 0 auto;
}

.pagination {
	width: 300px;
	margin: 0 auto;
}

#sortBar {
	width: 100px;
	float: right;
}

.sortBtn {
	border: 0px;
	background-color: #fff;
}

#searchTable {
	border: 1px solid #fff;
	background-color: #fff;
	margin-top: 20px;
}
</style>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>
	<div class="container">
		<h4 class="fw-bold py-3 mb-4">
			<span class="text-muted fw-light" style="line-height: 80px">상품
				관리 /</span> 상품 조회
		</h4>
	</div>
	<div class="searchContainer">
		<div class="mb-3 searchText">
			<div style="width: 1200px;">
				<label for="username" class="form-label" style="display: block">검색</label>
				<input type="text" class="form-control" id="searchWord"
					name="username" placeholder="검색할 내용을 입력하세요" autofocus
					style="width: 1000px; display: inline-block;" /> <select
					class="select2 form-select"
					style="width: 150px; display: inline-block;" id="serachType">
					<option value="title" selected hidden>키워드 검색</option>
					<option value="title">제목</option>
					<option value="isbn">ISBN</option>
					<option value="author">작가</option>
					<option value="content">내용</option>
				</select>
			</div>
			<div class="searchZoon" style="height: 200px">
				<div class="categorySearch">
					<label for="rgDate" class="form-label">카테고리</label> <select
						id="category" class="select2 form-select">
						<option selected disabled hidden>카테고리 검색</option>
						<option>전체</option>
						<c:forEach var="CategoryVO" items="${category}">
							<option value="${CategoryVO.category_code}">
								<c:out value="${CategoryVO.category_name}" /></option>
						</c:forEach>
					</select>
				</div>

				<div class="rgDateSearch" style="margin-left: 10px;">
					<label for="rgDate" class="form-label">등록 날짜</label> <input
						type="date" class="form-control" id="startRgDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-right: 10px;" /><span
						style="font-size: 24px">~</span><input type="date"
						class="form-control" id="endRgDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-left: 10px" />
				</div>

				<div class="upDateDateSearch">
					<label for="rgDate" class="form-label">수정 날짜</label> <input
						type="date" class="form-control" id="startUpdate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-right: 10px;" /><span
						style="font-size: 24px">~</span><input type="date"
						class="form-control" id="endUpDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-left: 10px" />
				</div>

				<div class="upDateDateSearch">
					<label for="rgDate" class="form-label">마감 날짜</label> <input
						type="date" class="form-control" id="startUpdate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-right: 10px;" /><span
						style="font-size: 24px">~</span><input type="date"
						class="form-control" id="endUpDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-left: 10px" />
				</div>

				<div style="clear: both">
					<div>

						<table class="table" id="searchTable">
							<tr>
								<td style="border-right: 1px solid #ccc"><label
									class="form-check-label" for="defaultCheck3"> 전체 </label></td>
								<td><input class="form-check-input" id="all_status"
									type="checkbox" value="sale" id="defaultCheck3" checked /></td>
							</tr>
							<tr>
								<td style="border-right: 1px solid #ccc">판매 상태</td>
								<td><input class="form-check-input sales_status"
									type="radio" value="sale" id="defaultCheck3"
									name="sales_status" /> <label class="form-check-label"
									for="defaultCheck3">판매중 </label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="notSale" id="defaultCheck3"
									name="sales_status" /> <label class="form-check-label"
									for="defaultCheck3">판매안함 </label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="soldOut" id="defaultCheck3"
									name="sales_status" /> <label class="form-check-label"
									for="defaultCheck3">품절</label></td>
							</tr>
							<tr>
								<td style="border-right: 1px solid #ccc">진열 상태</td>
								<td><input class="form-check-input display_status"
									type="radio" value="yes" id="defaultCheck3"
									name="display_status" /> <label class="form-check-label"
									for="defaultCheck3">진열 </label></td>
								<td><input class="form-check-input display_status"
									type="radio" value="no" id="defaultCheck3"
									name="display_status" /> <label class="form-check-label"
									for="defaultCheck3">진열안함 </td>

							</tr>
						</table>


					</div>
				</div>


			</div>
		</div>





		<div
			style="width: 1200px; margin: 0 auto; margin-top: 25px; clear: both">
			<button type="button" class="btn btn-primary" onclick="search();">검색</button>
		</div>



	</div>




	<div class="card">
		<h4 class="card-header">상품 조회</h4>
		<div>
			<button type="button" class="btn rounded-pill btn-outline-primary"
				style="float: left; margin-left: 15px" data-bs-toggle="modal"
				data-bs-target="#myModal" id="batchUpdate">일괄 업데이트 / 삭제</button>

			<button type="button" class="btn rounded-pill btn-outline-primary"
				style="float: left; margin-left: 10px"
				onclick="location.href='${contextPath}/prodManager/addProduct'">상품
				추가하기</button>
		</div>
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
						<th>모두체크 <input class="form-check-input" type="checkbox"
							id="allcheck" /></th>
						<th>상품번호</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>판매가
							<button class="sortBtn" id="price">▽</button>/할인가
							<button class="sortBtn" id="sellPrice">▽</button>
						</th>
						<th>재고
							<button class="sortBtn" id="stock">▽</button>
						</th>
						<th>등록일/업데이트
							<button class="sortBtn" id="rgDate">▽</button>
						</th>
						<th>마감일
							<button class="sortBtn" id="endDate">
						</th>
						<th>판매량
							<button class="sortBtn" id="salesCount">▽</button>
						</th>
						<th>조회수
							<button class="sortBtn" id="readCount">▽</button>
						</th>
						<th>진열 상태</th>
						<th>판매 상태</th>
						<th></th>
					</tr>
				</thead>
				<tbody class="table-border-bottom-0" id="productView">
				</tbody>
			</table>
		</div>

		<div class="demo-inline-spacing" id="pagingZone"></div>


		<!-- The Modal -->
		<div class="modal" id="myModal">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="fw-bold py-3 mb-4">
							<span class="text-muted fw-light">일괄 수정 /</span> 삭제
						</h4>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<table class="table">
							<thead>
								<tr>
									<th>모두체크 <input class="form-check-input" type="checkbox"
										id="allcheck" /></th>
									<th>상품번호</th>
									<th>이미지</th>
									<th>상품명</th>
									<th>판매가 /할인가</th>
									<th>재고
									<th>진열 상태</th>
									<th>판매 상태</th>
									<th></th>
								</tr>
							</thead>
							<tbody class="table-border-bottom-0" id="selectProdView">
							
							</tbody>
						</table>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="updateReset">리셋</button>
						<button type="button" class="btn btn-primary" id="updateprod">상품
							수정</button>
						<button type="button" class="btn btn-danger" id="delProd"  data-bs-toggle="modal" data-bs-target="#Modal">상품
							삭제</button>
						<button type="button" class="btn btn-primary"
							data-bs-dismiss="modal">닫기 X</button>
					</div>
						
					
				</div>
			</div>
		</div>




		<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>