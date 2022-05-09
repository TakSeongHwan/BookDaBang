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
		searchType : "",
		startSellDate : "",
		endSellDate : "",
		orderState: "",
		confirm : "",
		all : ""
	}

	window.onload = function() {
		searchOrder(SearchCriteria, pageNo);
	}

	function search() {
		pageNo = 1;
		SearchCriteria.searchWord = $("#searchWord").val();
		SearchCriteria.searchType = $("#serachType").val();
		SearchCriteria.startSellDate = $("#startSellDate").val();
		SearchCriteria.endSellDate = $("#endSellDate").val();
		SearchCriteria.orderState = $("input[name='orderState']:checked").val();
		SearchCriteria.confirm = $("input[name='confirm']:checked").val();
		SearchCriteria.all = $("#all").is(":checked");
		JsonSearchCriteria = JSON.stringify(SearchCriteria);
		console.log(JsonSearchCriteria);
		searchOrder(SearchCriteria, pageNo);
	}

	function searchOrder(sc, pno) {

		$("#orderView")
				.html(
						'<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style ="width : 150px"></div>');
		pageNo = pno;
		$("#allcheck").prop("checked", false)

		let url = "/orderManager/getAll/" + pageNo;
		sc = JSON.stringify(sc)
		console.log(sc);
		$.ajax({
			url : url,
			dataType : "json",
			type : "POST",
			contentType : "application/json",
			data : sc,
			success : function(data) {
				console.log(data)
				searchView(data);
			}

		});

	}
	
	function stateChange(obj){
		let id = obj.id.substring(5);
		console.log(id);
		$(obj).html("<select  id='"+obj.id+"' name='orderState' onchange='state("+id+")'><option value='1'>선택</option><option value='1'>출고 준비중</option><option value='2'>배송중</option><option value='3'>배송 완료</option><option value='4'>주문 취소</option><option value='5'>상품 환불</option></select>");
	}
	
	function confirmChange(obj){
		let id = obj.id.substring(7);
		$(obj).html("<select id='"+obj.id+"' name='confirm' onchange='confirm("+id+");'><option value='N'>선택</option><option value='N'>미확정</option><option value='Y'>상태 확정</option></select>");
	}
	
	function confirm(id){
		let url = "/orderManager/confirm/"+id
		let sendData = $("#confirm"+id+" option:selected").val();
		$.ajax({
			url : url,
			data : {
				confirm : sendData
			},
			type : "put",
			headers : {
				"X-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				console.log(data);
				$("#confirm"+id).html($("#confirm"+id+" option:selected").html());
			}
		});
	}
	
	function state(id){
		let url = "/orderManager/orderState/"+id
		let sendData = $("#state"+id+" option:selected").val();
		console.log(sendData);
		$.ajax({
			url : url,
			data : {
				orderState : sendData
			},
			type : "put",
			headers : {
				"X-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				console.log(data);
				searchOrder(SearchCriteria, pageNo);
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
			output += '<td>'; 
			if(e.userId==null){
				output += '비회원'
			}else{
				output += e.userId;
			}
			output += '</td>';
			output += '<td>' + e.productNo + '</td>';
			output += '<td><img src ="' + e.cover + '" width="50" /></td>';
			output += '<td>' + e.title + '</td>';
			output += '<td>' + e.productQtt + '</td>';
			let price = e.price.toLocaleString();
			output += '<td>' + price + '원</td>'
			orderDate = new Date(+new Date(e.orderDate) + 3240 * 10000).toISOString().split("T")[0];
			output += '<td>' + orderDate + '</td>';
			output += '<td id="state'+e.orderNo+'" ondblclick="stateChange(this);">';
			if(e.orderState_code == 1){
				output += '출고 준비중';
			}else if(e.orderState_code == 2){
				output += '배송중';
			}else if(e.orderState_code == 3){
				output += '배송 완료';
			}else if(e.orderState_code == 4){
				output += '주문 취소';
			}else if(e.orderState_code == 5){
				output += '상품 환불';
			}
			output += "</td>";
			if (e.releaseDate == null) {
				output += '<td>미출고</td>'
			} else {
				releaseDate = new Date(+new Date(e.releaseDate) + 3240 * 10000).toISOString().split("T")[0];
				output += '<td>'+releaseDate+'</td>'
			}
			if(e.confirm==null||e.confirm=='N'){
				output += '<td  id="confirm'+e.orderNo+'" ondblclick="confirmChange(this);"> 미확정</td>'
			}else{
				output += '<td  id="confirm'+e.orderNo+'" ondblclick="confirmChange(this);">상태 확정</td></tr>';
			}
			
		});

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchOrder("
					+ JsonSearchCriteria
					+ ","
					+ 1
					+ ")' ><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchOrder("
					+ JsonSearchCriteria
					+ ","
					+ (pageNo - 1)
					+ ")' ><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active'><a class='page-link' onclick='searchOrder("
						+ JsonSearchCriteria
						+ ","
						+ i
						+ ")'>"
						+ i
						+ "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='searchOrder("
						+ JsonSearchCriteria
						+ ","
						+ i
						+ ")'>"
						+ i
						+ "</a></li>";
			}
		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchOrder("
					+ JsonSearchCriteria
					+ ","
					+ (pageNo + 1)
					+ ")' ><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='searchOrder("
					+ JsonSearchCriteria
					+ ","
					+ (data.pagingInfo.totalPage)
					+ ")' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'

		$("#pagingZone").append(pagingoutput);
		$("#orderView").append(output);

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
	height: 400px;
	display: inline-block;
}

.sellDateSearch {
	float: right;
	width: 500px;
}

.sellDateSearch>label {
	margin-top: 3px;
	display: block
}

.sellDateSearch>input {
	width: 150px;
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
			<span class="text-muted fw-light" style="line-height: 80px">주문
				관리 /</span> 주문 조회
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
					<option value="orderNo">주문번호</option>
					<option value="prodNo">상품번호</option>
					<option value="userId">아이디</option>
					<option value="title">제품명</option>
				</select>
			</div>
			<div class="searchZoon" style="height: 70px">

				<div class="sellDateSearch">
					<label class="form-label">판매 날짜</label> <input
						type="date" class="form-control" id="startSellDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-right: 10px;" /><span
						style="font-size: 24px">~</span><input type="date"
						class="form-control" id="endSellDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-left: 10px" />
				</div>

			</div>
			<div style="clear: both">
					<div>

						<table class="table" id="searchTable">
							<tr>
								<td style="border-right: 1px solid #ccc"><label
									class="form-check-label" for="defaultCheck3"> 전체 </label></td>
								<td><input class="form-check-input" id="all"
									type="checkbox" value="all" id="defaultCheck3" checked /></td>
							</tr>
							<tr>
								<td style="border-right: 1px solid #ccc">주문 상태</td>
								<td><input class="form-check-input sales_status"
									type="radio" value="0" id="defaultCheck3"
									name="orderState" checked/> <label class="form-check-label"
									for="defaultCheck3">전체 </label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="1" id="defaultCheck3"
									name="orderState" /> <label class="form-check-label"
									for="defaultCheck3">출고 준비중 </label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="2" id="defaultCheck3"
									name="orderState" /> <label class="form-check-label"
									for="defaultCheck3">배송중 </label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="3" id="defaultCheck3"
									name="orderState" /> <label class="form-check-label"
									for="defaultCheck3">배송 완료</label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="4" id="defaultCheck3"
									name="orderState" /> <label class="form-check-label"
									for="defaultCheck3">주문 취소</label></td>
								<td><input class="form-check-input sales_status"
									type="radio" value="5" id="defaultCheck3"
									name="orderState" /> <label class="form-check-label"
									for="defaultCheck3">상품 환불</label></td>
							</tr>
							<tr>
								<td style="border-right: 1px solid #ccc">상태 확정</td>
								<td><input class="form-check-input display_status"
									type="radio" value="" id="defaultCheck3"
									name="confirm" checked /> <label class="form-check-label"
									for="defaultCheck3">전체 </label></td>
								<td><input class="form-check-input display_status"
									type="radio" value="N" id="defaultCheck3"
									name="confirm" /> <label class="form-check-label"
									for="defaultCheck3">미확정 </label></td>
								<td><input class="form-check-input display_status"
									type="radio" value="Y" id="defaultCheck3"
									name="confirm" /> <label class="form-check-label"
									for="defaultCheck3">상태 확정</label> </td>

							</tr>
						</table>
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
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
						<th>주문 번호</th>
						<th>주문ID</th>
						<th>상품 번호</th>
						<th>이미지</th>
						<th>상품명</th>
						<th>판매수</th>
						<th>판매가</th>
						<th>판매일</th>
						<th>주문 상태</th>
						<th>출고 날짜</th>
						<th>상태 확정</th>
						
					</tr>
				</thead>
				<tbody class="table-border-bottom-0" id="orderView">
				</tbody>
			</table>
		</div>

		<div class="demo-inline-spacing" id="pagingZone"></div>

		</div>





		<jsp:include page="../../managerFooter.jsp"></jsp:include></body>
</html>