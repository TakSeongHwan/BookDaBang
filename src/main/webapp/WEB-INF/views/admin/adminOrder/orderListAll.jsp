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
		searchOrder(SearchCriteria, pageNo);
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

	function searchOrder(sc, pno) {

		$("#orderView")
				.html(
						'<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style ="width : 150px"></div>');
		pageNo = pno;
		console.log(pageNo);
		console.log(sc);
		$("#allcheck").prop("checked", false)

		let url = "/orderManager/getAll/" + pageNo;

		$.ajax({
			url : url,
			dataType : "json",
			type : "POST",
			data : sc,
			success : function(data) {
				console.log(data)
				searchView(data);
			}

		});

	}

	function searchView(data) {
		$("#orderView").empty();
		$("#pagingZone").empty();
		let output = "";
		JsonSearchCriteria = JSON.stringify(SearchCriteria);

		/* let PageNo = parseInt(data.pageNo); */
		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		$.each(data.ManageOrder, function(i, e) {
			output += '<tr><td>' + e.orderNo + '</td>';
			output += '<td>' + e.userId + '</td>';
			output += '<td>' + e.productNo + '</td>';
			output += '<td><img src ="' + e.cover + '" width="50" /></td>';
			output += '<td>' + e.title + '</td>';
			let price = e.price.toLocaleString();
			output += '<td>' + price + '원</td>'
			orderDate = new Date(+new Date(e.orderDate) + 3240 * 10000).toISOString().split("T")[0];
			output += '<td>' + orderDate + '</td>';
			if(e.orderState_code == 1){
				output += '<td>출고 준비중</td>';
			}else if(e.orderState_code == 2){
				output += '<td>배송중</td>';
			}else if(e.orderState_code == 3){
				output += '<td>배송 완료</td>';
			}else if(e.orderState_code == 4){
				output += '<td>주문 취소</td>';
			}else if(e.orderState_code == 5){
				output += '<td>상품 환불</td>';
			}
			if (e.releaseDate == null) {
				output += '<td>미출고</td>'
			} else {
				releaseDate = new Date(+new Date(e.releaseDate) + 3240 * 10000).toISOString().split("T")[0];
				output += '<td>'+releaseDate+'</td>'
			}
			if(e.confirm==null){
				output += '<td>미확정</td>'
			}else{
				output += '<td>구매 확정</td></tr>';
			}
			
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
		$("#orderView").append(output);

	}
	
	function searchProduct(sc, pno) {

		$("#productView")
				.html(
						'<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style ="width : 150px"></div>');
		pageNo = pno;
		console.log(pageNo);
		console.log(sc);
		$("#allcheck").prop("checked", false)

		let url = "/orderManager/getAll/" + pageNo;

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
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
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

				<div class="rgDateSearch">
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
		<h4 class="card-header">주문 조회</h4>
		<div>
			<button type="button" class="btn rounded-pill btn-outline-primary"
				style="float: left; margin-left: 15px" data-bs-toggle="modal"
				data-bs-target="#myModal" id="batchUpdate">일괄 업데이트 / 삭제</button>
		</div>
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
						<th>주문 번호</th>
						<th>주문ID</th>
						<th>상품 번호</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>판매가</th>
						<th>판매일</th>
						<th>주문 상태</th>
						<th>출고 날짜</th>
						<th>구매 확정</th>
						
					</tr>
				</thead>
				<tbody class="table-border-bottom-0" id="orderView">
				</tbody>
			</table>
		</div>

		<div class="demo-inline-spacing" id="pagingZone"></div>

		</div>





		<jsp:include page="../../managerFooter.jsp"></jsp:include></ body>
</html>