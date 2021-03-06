<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<scirpt src="${contextPath}/resources/js/jQueryRotateCompressed.js">
<meta charset="UTF-8">
<title>상품 조회</title>

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
		start_endDate : "",
		end_endDate : "",
		display_status : "",
		sales_status : "",
		sortWord : "",
		sortMethod : ""
	}

	window.onload = function() {
		searchProduct(SearchCriteria, pageNo);
		
		
		$(document).on("dblclick",".prod", function(){
			let index = $(".prod").index(this);
			let prodNo = $(".prodNo").eq(index).text();
			
			location.href= "/prodManager/prodUpdate?prodNo="+prodNo; 
		});
			
		$(document).on("keypress","#searchWord", function(e){
			if (e.keyCode === 13) {
				e.preventDefault();
				search();
			}

			
			
		});
		

		$("#allcheck").change(function() {
			if ($("#allcheck").is(":checked")) {
				$(".prodCheck").prop("checked", true);
			} else {
				$(".prodCheck").prop("checked", false);
			}
		});

		$("#allUpCheck").change(function() {
			if ($("#allUpCheck").is(":checked")) {
				$(".upProdCheck").prop("checked", true);
			} else {
				$(".upProdCheck").prop("checked", false);
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
			if(checkAry.length  <1 ){
				errView("일괄처리할 상품을 선택하세요.");
			
			}else {
				$("#myModal").modal("show");
				prodselectview(checkAry);	
			}

			

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
							let input = '<input type="text" id="a" style= "width :80px" value="'
									+ $(this).text()
									+ '" onkeyup="inputNumberFormat(this)">'
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
											thistag.next().css("color",
													"orange");

										}

									});

						});

		$(document)
				.on(
						"dblclick",
						".updateStock",
						function() {
							thistag = $(this);
							thisval = $(this).text();
							console.log(thistag, thisval);
							let input = '<input type="text" id="a" style= "width :80px" value="'
									+ $(this).text()
									+ '" onkeyup="inputNumberFormat(this)">'
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
											thistag.next().css("color",
													"orange");

										}

									});

						});

		$(document)
				.on(
						"dblclick",
						".updateDisplay",
						function() {
							thistag = $(this);
							let input = '<select id="sud"><option value="yes" selected>진열</option><option value="no">진열안함</option></select>';
							$(this).html(input);

							$(document)
									.on(
											"blur",
											"#sud",
											function() {
												if ($("#sud").val() == "yes") {
													thistag
															.html('<span class="badge bg-label-primary" id="yes">진열</span>');
												} else if ($("#sud").val() == "no") {
													thistag
															.html('<span class="badge bg-label-warning" id="no">진열안함</span>');
												}
											});

						});

		$(document)
				.on(
						"dblclick",
						".updateSales",
						function() {
							thistag = $(this);
							let input = '<select id="sus"><option value="sale" selected>판매</option><option value="notSales">판매안함</option><option value="soldOut">품절</option></select>';
							$(this).html(input);

							$(document)
									.on(
											"blur",
											"#sus",
											function() {
												if ($("#sus").val() == "sale") {
													thistag
															.html('<span class="badge bg-label-primary" id="sale">판매중</span>');
												} else if ($("#sus").val() == "notSales") {
													thistag
															.html('<span class="badge bg-label-warning" "id="notSales">판매안함</span></div>');
												} else if ($("#sus").val() == "soldOut") {
													thistag
															.html('<span class="badge bg-label-danger" id="soldOut">품절</span>');
												}
											});

						});

		$(document).on("click", "#reflashImg", function() {
			prodselectview(checkAry);

		});


		$(document)
				.on(
						"click",
						"#updateprod",
						function() {
							let updateProdAry = [];

							for (let i = 0; i < 10; i++) {
								let updateProd = {
									prodNo : "",
									updatePrice : "",
									updateStock : "",
									updateDisplay : "",
									updateSales : ""
								}
								if ($(".upProdCheck").eq(i).is(":checked")) {
									updateProd.prodNo = $(".upProdCheck").eq(i)
											.attr("id");
									updateProd.updatePrice = parseInt($(
											".updatePrice").eq(i).html()
											.replace(",", ""));
									updateProd.updateStock = parseInt($(
											".updateStock").eq(i).html()
											.replace(",", ""));

									if ($(".updateDisplay").eq(i).text() == "진열") {
										updateProd.updateDisplay = "yes";
									} else if ($(".updateDisplay").eq(i).text() == "진열안함") {
										updateProd.updateDisplay = "no";
									}

									if ($(".updateSales").eq(i).text() == "판매중") {
										updateProd.updateSales = "sale";
									} else if ($(".updateSales").eq(i).text() == "판매안함") {
										updateProd.updateSales = "notSales";
									} else if ($(".updateSales").eq(i).text() == "품절") {
										updateProd.updateSales = "soldOut";
									}
									updateProdAry.push(updateProd);
								}
							}
							if(updateProdAry.length <1) {
								errView("일괄처리할 상품을 선택해주세요");
							} else {
							updateProd(updateProdAry);								
							}

						});
		

		$(document).on("click", "#delProd", function() {
			let deleteProdAry = [];
		
			for (let i = 0; i < 10; i++) {
				let deleteProd = {
					prodNo : "",
					imagePath : ""
				}
				if ($(".upProdCheck").eq(i).is(":checked")) {
					deleteProd.prodNo = ($(".upProdCheck").eq(i).attr("id"));
					deleteProd.imagePath = ($(".imagePath").eq(i).attr("src"));
					
					deleteProdAry.push(deleteProd);
				}
				
				
			}
					
			deleteProdList(deleteProdAry);
				});
		/*410 */

		$(document)
				.on(
						"change",
						"#updAllDisplay",
						function() {
							for (let i = 0; i < 10; i++) {
								if ($(".upProdCheck").eq(i).is(":checked")) {
									if ($("#updAllDisplay").val() == "yes") {
										$(".updateDisplay")
												.eq(i)
												.html(
														'<span class="badge bg-label-primary" id="yes">진열</span>');
									} else {
										$(".updateDisplay")
												.eq(i)
												.html(
														'<span class="badge bg-label-warning" id="no">진열안함</span>');
									}
								}
							}
						});
		
		$(document)
				.on(
						"change",
						"#updAllSales",
						function() {
							for (let i = 0; i < 10; i++) {
								if ($(".upProdCheck").eq(i).is(":checked")) {
									if ($("#updAllSales").val() == "sale") {
										$(".updateSales")
												.eq(i)
												.html(
														'<span class="badge bg-label-primary" id="sale">판매중</span>');
									} else if ($("#updAllSales").val() == "notSales") {
										$(".updateSales")
												.eq(i)
												.html(
														'<span class="badge bg-label-warning" "id="notSales">판매안함</span></div>');
									} else {
										$(".updateSales")
												.eq(i)
												.html(
														'<span class="badge bg-label-danger" id="soldOut">품절</span>');
									}

								}
							}
						});

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

	function prodselectview(checkAry) {
		
		let contextPath = $
		{
			contextPath
		}
		$("#selectProdView")
				.html(
						'<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style="width : 100px" ></div>');
		let url = "/api.prod.com/prods/batch";

		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
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
		SearchCriteria.start_endDate = $("#start_endDate").val();
		SearchCriteria.end_endDate = $("#end_endDate").val();
		JsonSearchCriteria = JSON.stringify(SearchCriteria);
		console.log(JsonSearchCriteria);
		searchProduct(SearchCriteria, pageNo);

	}

	function searchProduct(sc, pno) {

		$("#productView")
				.html(
						'<div style="position : absolute; left : 50%; top :50%; transform : translate(-50%, -50%)"><img src="/resources/img/etc/loading.gif" style ="width : 150px"></div>');
		pageNo = pno;
		console.log(pageNo);
		console.log(sc);
		$("#allcheck").prop("checked", false)

		let url = "/api.prod.com/prods/" + pageNo;
		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
			data : sc,
			success : function(data) {
				console.log(data);
				if(data.product.length <1) {
					undifineSearchData()
				} else {
					searchView(data);
				}
				
			}

		});

	}

	function searchView(data) {
		console.log(data.product);
		
		if(data.pagingInfo.totalPostCnt == 0){
			alert("!");
		}
		
		if(data.product.length < 10) {
			$("#productView").height(0);
			
		}
		if(data.product.length ==10) {
			$("#productView").height(900);
			
		}
		
		
		
		/* $("#productView") */
		$("#errZone").html("");
		let output = "";
		let displayStatus = "";
		let salesStatus = "";
		let rgDate = "";
		let upDate = "";
		let endDate = "";
		JsonSearchCriteria = JSON.stringify(SearchCriteria);

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'
			
		$
				.each(
						data.product,
						function(i, e) {
							output += '<tr class="prod"><td> <input class="form-check-input prodCheck"  type="checkbox" id="'+e.isbn+'" /></td>';
							output += '<td class="prodNo">' + e.isbn + '</td>';
							output += '<td><img src ="' + e.cover + '" width="50" /></td>';
							output += '<td>' + e.title + '</td>';
							let price = e.price.toString().replace(
									/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							let sellPrice = e.sell_price.toString().replace(
									/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							output += '<td><div>￦' + price + '</div>'
							output += '<div style="color : #ccc">￦' + sellPrice
									+ '</div></td>';
							output += '<td>' + e.stock + '</td>';
							rgDate = new Date(
									+new Date(e.rg_date) + 3240 * 10000)
									.toISOString().split("T")[0];

							if (!e.update_date) {
								upDate = "수정날짜 없음";
							} else {
								upDate = new Date(
										+new Date(e.update_date) + 3240 * 10000)
										.toISOString().split("T")[0];
							}
							output += '<td><div>' + rgDate + '</div>';
							output += '<div style="color : #ccc">' + upDate
									+ '</div></td>';
							if(e.end_date == null){
								endDate = "제한 없음"
							}else{
								endDate = new Date(
										+new Date(e.end_date) + 3240 * 10000)
										.toISOString().split("T")[0];
							}
							
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

		$("#pagingZone").html(pagingoutput);

		$("#productView").html(output);

	}

	function selectProdView(data) {
	
		let output = "";
		$
				.each(
						data,
						function(i, e) {
							output += '<tr><td> <input class="form-check-input upProdCheck"  type="checkbox" id="'+e.isbn+'" /></td>';
							output += '<td>' + e.isbn + '</td>';
							output += '<td><img src ="' + e.cover + '" width="50" class ="imagePath"/></td>';
							output += '<td style=" width:200px;" >' + e.title + '</td>';
							output += '<td style="font-size : 12px">'
									+ ConversionOfcategory(e.category_code)
									+ '</td>';
							let price = e.price.toString().replace(
									/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
							output += '<td><span>￦</span><span class="updatePrice">' + price
									+ '</span></td>'
							output += '<td><span class="updateStock">'
									+ e.stock + '</span><span>권</span></td>'
							if (e.display_status == "yes") {
								displayStatus = '<div class="updateDisplay"><span class="badge bg-label-primary" id="yes">진열</span></div>';
							} else {
								displayStatus = '<div class="updateDisplay"><span class="badge bg-label-warning" id="no">진열안함</span></div>';
							}
							output += '<td>' + displayStatus + '</td>';
							if (e.sales_status == "sale") {
								salesStatus = '<div class="updateSales"><span class="badge bg-label-primary" id="sale">판매중</span></div>';
							} else if (e.sales_status == "soldOut") {
								salesStatus = '<div class="updateSales"><span class="badge bg-label-danger" id="soldOut">품절</span></div>';
							} else {
								salesStatus = '<div class="updateSales"><span class="badge bg-label-warning" id="notSales">판매안함</span></div>';
							}
							output += '<td>' + salesStatus + '</td></tr>';
							output += '</tr>';
						});
		/* 210 */

		$("#selectProdView").html(output);

	}

	function updateProd(updateProdAry) {
		let JsonUpdateProdAry = JSON.stringify(updateProdAry);
		console.log(JsonUpdateProdAry);

		let url = "/api.prod.com/put/batch";
		$.ajax({
			url : url,
			dataType : "text",
			type : "put",
			traditional : true,
			headers : {
				"content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JsonUpdateProdAry,

			success : function(data) {
				console.log(data)
				if (data == "success") {
					successView("상품을 성공적으로 수정했습니다.");
					
					setTimeout(function() {
						location.reload();
					},1300);
				}

			},
			error : function(data) {
				console.log(data)

			}

		});
	}
	
	function deleteProdList(deleteProdAry) {
		let JsonDeleteProdAry = JSON.stringify(deleteProdAry);
		console.log(deleteProdAry);
		
		let url = "/api.prod.com/delete/batch";
		$.ajax({
			url : url,
			dataType : "text",
			type : "delete",
			headers : {
				"content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			data : JsonDeleteProdAry,
			success : function(data) {
				if (data > 0) {
					successView(data + "개의 상품을 삭제했습니다.");
					setTimeout(function() {
						location.reload();
					},1300);
				}
				
			}

		});  
	}

	function ConversionOfcategory(category_code) {
		let category = "";
		switch (category_code) {
		case 10:
			category = "철학, 심리학, 윤리학";
			return category
		case 20:
			category = "종교";
			return category
		case 30:
			category = "사회과학";
			return category
		case 40:
			category = "자연과학";
			return category
		case 50:
			category = "기술과학";
			return category
		case 60:
			category = "예술";
			return category
		case 70:
			category = "언어";
			return category
		case 80:
			category = "문학";
			return category
		case 90:
			category = "역사, 지리, 과학";
			return category
		case 100:
			category = "미분류";
			return category
		}

	}
	
	function undifineSearchData() {
		$("#productView").height(0);
		let searchWord = $("#searchWord").val();
		let output = "<div class ='errbox'><div style='font-weight :bold; font-size :24px;'>'"+searchWord+"' 의 검색 결과  <span style='color:red; margin-left:1em'>'0'</span></div>";
		output += "<div style='margin-top : 30px;'>입력하신 단어의 철자가 정확한지 확인해 보세요.</div>";
		output += "<div>검색어의 단어 수를 줄이거나, 보다 일반적인 단어로 검색해 보세요.</div>";
		output += "<div>두 단어 이상의 키워드로 검색 하신 경우, 정확하게 띄어쓰기를 한 후 검색해 보세요.</div>";
		output += "</div>";
		
		$("#productView").html("");
		$("#pagingZone").html("");
		$("#errZone").html(output);
	}
	
	
	function errView(text) {
		$(".alert-danger").fadeIn(400);
		$(".alert-danger").html(text);

		setTimeout(function() {
			$(".alert-danger").fadeOut(500);
		}, 800);
	}
	
	
	function successView (text) {
		$(".alert-primary").fadeIn(400);
		$(".alert-primary").html(text);

		setTimeout(function() {
			$(".alert-primary").fadeOut(500);
		}, 800);
	}
</script>
<style>
.errbox {
	margin : 50px 0 50px 50px;
	font-size : 20px;
}
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
	width: 99%;
	margin: 0 auto;
	overflow: hidden;
	
}

td {	
	max-width: 150px;
	overflow: hidden;
	text-overflow : ellipsis;
}

th {
	
}

.searchZoon {
	width: 1200px;
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

#reflashImg {
	opacity: 0.7;
}

#reflashImg:hover {
	transform: rotate(180deg);
	transition: 0.5s;
}
.alert {
	position: absolute;
	width: 100%;
	margin: 0 auto;
	z-index: 1500;
	hegiht: -50%;
	text-align: center;
	padding: 10px;
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
						type="date" class="form-control" id="start_endDate" name="username"
						placeholder="검색할 내용을 입력하세요" autofocus style="margin-right: 10px;" /><span
						style="font-size: 24px">~</span><input type="date"
						class="form-control" id="end_endDate" name="username"
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
									type="radio" value="notSales" id="defaultCheck3"
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
			<button type="button" class="btn btn-primary" onclick="search();">
               <span class="tf-icons bx bx-search-alt"></span>검색</button>
		</div>



	</div>




	<div class="card">
		<h4 class="card-header">상품 조회</h4>
		<div>
			
			<button type="button" class="btn btn-outline-primary"
				style="float: right; margin-left: 10px"
				onclick="location.href='${contextPath}/prodManager/addProduct'">상품
				추가하기<i class='bx bxs-add-to-queue' style="margin-left :10px"></i></button>
				
				<button type="button" class="btn btn-outline-primary"
				style="float: right; margin-left: 15px" 
				 id="batchUpdate">일괄 수정 / 삭제 <i class='bx bx-pencil' style="margin-left :10px"></i></button>
				  <!-- data-bs-toggle="modal"data-bs-target="#myModal" -->
		</div>
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
						<th> <input class="form-check-input" type="checkbox"
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
				<tbody class="table-border-bottom-0" id="productView" >
				</tbody>
			</table>
		</div>

		<div class="demo-inline-spacing" id="pagingZone"></div>
		<div id="errZone"></div>


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
						<span class="text-muted fw-light">일괄 상태 /</span> 변경
						<div>
							<select class="select2 form-select" id="updAllDisplay"
								style="width: 110px; display: inline-block;">
								<option selected disabled hidden>진열 상태</option>
								<option value="yes">진열</option>
								<option value="no">진열안함</option>
							</select> <select class="select2 form-select" id="updAllSales"
								style="width: 110px; display: inline-block;">
								<option selected disabled hidden>판매 상태</option>
								<option value="sale">판매중</option>
								<option value="notSales">판매안함</option>
								<option value="soldOut">품절</option>
							</select>
							<button type="button" id="updateReset"
								style="border: none; background-color: #fff"></button>
							<img src="/resources/img/etc/reflash.png" id="reflashImg"
								width="20px">
							</button>

						</div>
						<table class="table" id="updateTable">
							<thead>
								<tr>
									<th> <input class="form-check-input" type="checkbox"
										id="allUpCheck" /></th>
									<th>상품번호</th>
									<th>이미지</th>
									<th>상품명</th>
									<th>카테고리</th>
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

						<button type="button" class="btn btn-primary" id="updateprod">상품
							수정<i class='bx bx-pencil'style="margin-left:5px"></i></button>
						<button type="button" class="btn btn-danger" id="delProd">상품
							삭제<i class='bx bx-trash' style="margin-left:5px"></i></button>
						<button type="button" class="btn btn-primary"
							data-bs-dismiss="modal"><i class='bx bx-x'></i></button>

					</div>


				</div>
			</div>
		</div>
		<div class="alert alert-danger"
		style="width: 300px; height: 70px; position: fixed; margin: 0 auto; top: 10%; left: 45%; line-height: 45px; display: none; font-weight: bold">

	</div>
	<div class="alert alert-primary"
		style="width: 300px; height: 70px; position: fixed; margin: 0 auto; top: 20%; left: 45%; display: none; line-height: 45px;" >

	</div>
    
  </div>
  





		<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>