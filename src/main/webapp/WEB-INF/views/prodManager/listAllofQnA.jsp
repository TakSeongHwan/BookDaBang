<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 QnA 관리</title>

<script>
	let pageNo = 1;
	let questionNo = 0;
	window.onload = function() {

		ViewSelectQnA(1, pageNo);
		ViewSelectQnA(2, pageNo);

		$(document).on("click", ".answerBtn", function() {
			$("#answerContent").val("");
			let index = $(".answerBtn").index(this);
			let questionNo = $(".questionNo").eq(index).text();
			let productNo = $(".productNo").eq(index).text();
			let writer = $(".writer").eq(index).text();
			$(".modal-title").html(questionNo + "번 글 답변");

			$(document).on("click", "#insertAnswer", function() {
				let answerContent = $("#answerContent").val();
				console.log(questionNo);

				let answer = {
					
					question_no : questionNo,
					product_no : productNo,
					content : answerContent,
					writer : writer
					
				}

				url = "/prodQna/insertAnswer";
				$.ajax({
					url : url,
					dataType : "text",
					type : "post",
					data : answer,
					success : function(data) {
						if (data == "success") {
							
							$(".alert").fadeIn(400);
							$(".alert").html("답변이 정상적으로 등록되었습니다.");
							setTimeout(function() {
								$(".alert").fadeOut(500);	
							},700);
							
							setTimeout(function() {
								location.reload();
							},1300);
							
						} else {
							
							$(".alert").fadeIn(400);
							$(".alert").html("답변이 등록되지 않았습니다.");
							setTimeout(function() {
								$(".alert").fadeOut(500);	
							},700);
							
							setTimeout(function() {
								location.reload();
							},1300);
							
							
						}
					}

				});
			});

		});
		
		$(document).on("click", ".remove", function() {
			$("#deleteModal").modal('show');
			let index = $(".bx-trash").index(this);
			questionNo = $(".questionNo").eq(index).text();
			
			$(".removeQnA-title").html(questionNo + "번 Q&A");
			$(".removeQnA-body").html("Q&A를 정말로 삭제하시겠습니까?");
					
		});
		
		
		$(document).on("click", "#removeQnA", function(e) {
			e.stopPropagation();
			console.log(questionNo);
			 let url = "/prodQna/deleteQnA" ;
			 $.ajax({
				url : url,
				dataType : "text",
				type : "post",
				data : {question_no : questionNo},
				success : function(data) {
					
					if(data == "success"){
					alert("삭제에 성공하였습니다. ");
					location.reload();
					
					} else {
					alert("삭제에 실패하였습니다.");
					
					}
				}

			});
		});
		
		
		
		
		

	}

	function ViewSelectQnA(answerStatus, tmp) {

		pageNo = tmp;

		url = "/prodQnARest/list?pageNo=" + pageNo + "&answerStatus="
				+ answerStatus;
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
				}

			}

		});
	}

	function viewNotAnswer(data) {
		$("#viewNotAnswer").empty();
		$("#notAnswerPagingZone").empty();

		let output = "";
		$
				.each(
						data.qnaList,
						function(i, e) {
							output += '<tr class="prodQnA">';
							output += '<td class="questionNo">' + e.question_no
									+ '</td>';
							output += '<td class="productNo">' + e.product_no
									+ '</td>';
							output += '<td style ="text-align :left">'
									+ e.content + '</td>';
							output += '<td class="writer">' + e.writer + '</td>';
							writeDate = new Date(
									+new Date(e.write_date) + 3240 * 10000)
									.toISOString().split("T")[0];
							output += '<td>' + writeDate + '</td>';
							output += '<td><span class="badge bg-label-warning">답변대기</span></td>';
							output += '<td><button type="button" class="btn rounded-pill btn-outline-primary answerBtn" data-bs-toggle="modal" data-bs-target="#myModal" >답변하기<i class="bx bx-pencil"style="margin-left:5px"></i></button><i class="bx bx-trash remove" style="margin-left:10px; width:80px"></i></td>';
							output += '</tr>';
						});

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(1,1)'><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(1,"
					+ (pageNo - 1)
					+ ")'><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active' onclick='ViewSelectQnA(1,"
						+ i + ")'><a class='page-link'>" + i + "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='ViewSelectQnA(1,"
						+ i + ")'>" + i + "</a></li>";
			}

		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='ViewSelectQnA(1,"
					+ (pageNo + 1)
					+ ")'><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last' onclick='ViewSelectQnA(1,"
					+ data.pagingInfo.totalPage
					+ ")'><a class='page-link' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'

		$("#viewNotAnswer").append(output);
		$("#notAnswerPagingZone").append(pagingoutput);

	}

	function viewAnswer(data) {

		$("#viewAnswer").empty();
		$("#answerPagingZone").empty();

		let output = "";

		$
				.each(
						data.qnaList,
						function(i, e) {
							writeDate = new Date(
									+new Date(e.write_date) + 3240 * 10000)
									.toISOString().split("T")[0];
							if (e.ref_order == 0) {
								output += '<tr class="prodQnA">';
								output += '<td class="questionNo">' + e.question_no + '</td>';
								output += '<td class="productNo">' + e.product_no
										+ '</td>';
								output += '<td style ="text-align :left">'
										+ e.content + '</td>';
								output += '<td>' + e.writer + '</td>';

								output += '<td>' + writeDate + '</td>';
								output += '<td><span class="badge bg-label-primary">답변완료</span></td>';
								output += '<td><i class="bx bx-trash remove" style="margin-left:10px; width:80px"></i></td>';
								output += '</tr>';
							} else {
								output += '<tr class="answer"><td></td>';
								output += '<td></td>'
								output += '<td style="text-align: left;">ㄴ<span class="badge bg-label-secondary">답변</span>'
										+ e.content + '</td>';
								output += '<td></td>';
								output += '<td>'+writeDate+'</td>';
								output += '<td></td>';
								output += '<td></td>';
								output += '<td></td>';
								output += '</tr>';
							}
						});

		let pagingoutput = '<nav aria-label="Page navigation"><ul class="pagination">'

		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(2,1)'><i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link' onclick='ViewSelectQnA(2,"
					+ (pageNo - 1)
					+ ")'><i class='tf-icon bx bx-chevron-left'></i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active' onclick='ViewSelectQnA(2,"
						+ i + ")'><a class='page-link'>" + i + "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='ViewSelectQnA(2,"
						+ i + ")'>" + i + "</a></li>";
			}

		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'  onclick='ViewSelectQnA(2,"
					+ (pageNo + 1)
					+ ")'><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last' onclick='ViewSelectQnA(2,"
					+ data.pagingInfo.totalPage
					+ ")'><a class='page-link' ><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'

		$("#viewAnswer").append(output);

		$("#answerPagingZone").append(pagingoutput);

	}
</script>
<style>
.qnaTable>thead>tr, .qnaTable>tbody>tr {
	text-align: center;
}

.table-responsive {
	width: 80%;
	margin: 0 auto;
}

#notAnswerPagingZone, #answerPagingZone {
	width: 700px;
	margin: 0 auto;
}

.pagination {
	width: 300px;
	margin: 0 auto;
}

.alert {
	position: absolute;
	width: 100%;
	margin: 0 auto;
	z-index: 3000;
	hegiht: -50%;
	opacity: 0.9;
	text-align: center;
	padding: 10px;
	
}

.bx-trash {
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>
	<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">상품 관리 /</span> 상품 QnA 관리
	</h4>



	</h5>
	<div class="table-responsive text-nowrap">
		<h5 class="fw-bold py-3 mb-4">미답변 QnA</h5>
		<table class="table qnaTable">
			<thead>
				<tr>
					<th>글번호</th>
					<th>상품번호</th>
					<th>글내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>답변상태</th>
					<th>비고</th>

				</tr>
			</thead>
			<tbody class="table-border-bottom-0" id="viewNotAnswer">

			</tbody>
		</table>
		<div id="notAnswerPagingZone">
		</div>

	</div>

	<div class="table-responsive text-nowrap">
		<h5 class="fw-bold py-3 mb-4">답변 QnA</h5>
		<table class="table qnaTable">
			<thead>
				<tr>
					<th>글번호</th>
					<th>상품번호</th>
					<th>글내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>답변상태</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody class="table-border-bottom-0" id="viewAnswer">

			</tbody>
		</table>

	</div>

	<div id="answerPagingZone"></div>



	<!-- The Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title"></h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<textarea class="form-control" id="answerContent" rows="5"></textarea>
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="insertAnswer">답변달기</button>
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">Close</button>
				</div>

			</div>
		</div>
	</div>
	
	
	
<div class="modal" id="deleteModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title removeQnA-title"></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class=" modal-body removeQnA-body">
        Modal body..
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
         <button type="button" class="btn btn-danger" id="removeQnA"><i class="bx bx-trash" style="margin-right:7px;"></i>삭제 </button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
		
	</button>
	<div class="alert alert-primary" style="width:300px;  height:70px;position: fixed; margin: 0 auto; top:10%; left : 45%; line-height: 45px; display: none;">
    
  </div>
	<jsp:include page="../managerFooter.jsp"></jsp:include>

</body>


</html>