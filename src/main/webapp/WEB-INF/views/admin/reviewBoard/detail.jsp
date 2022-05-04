<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>Insert title here</title>
<script>
	let pageNo = 1;
	let deleteNoList = [];
	
	$(function() {
		starMaker();
		parseNotImgFile();
		productInfo();
		getComment(1);
		commentCheck();
	});
	
	function starMaker() {
		let output = "";
		for (let i = 0; i < "${review.grade}"; i++) {
			output += "★";
		}
		for (let i = 0; i < 5-"${review.grade}"; i++) {
			output += "☆";
		}
		$("#star").val(output);
	}
	
	function parseNotImgFile() {
		$(".notImg").each(function(i, tag) {
			let tmpFileName = $(tag).attr("href");
			let fileName = tmpFileName.substring(tmpFileName.lastIndexOf("/") + 1);
			$(tag).text(fileName);
		});
	}
	
	function productInfo() {
		let descrip = "${product.description}";
		let frontD = descrip.split("-")[0];
		descrip = descrip.replace(frontD, "");
		descrip = descrip.replace("-", "");
		$("#prodDescrip").html(descrip);
		
		let sellPrice = $("#prodPrice").text().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$("#prodPrice").text(sellPrice);
	}
	
	function getComment(no) {
		pageNo = no;
		let url = "/reviewManager/detailComment?no=${param.no}&pageNo=" + pageNo;
		console.log(url);
		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
			success : function (data) {
				console.log(data);	
				if (data != null) {
					parseComment(data.commentList);
					parsePaging(data.pagingInfo);
				}
			},error : function() {
				alert("댓글 통신 실패!");
			}
		});	
	}
	
	
	function parseComment(list) {
		let output = '';
		if (list.length != 0) {
			$.each(list, function(i, e) {
				output += '<tr>';
				output += '<td><input class="form-check-input commentCheck" type="checkbox" value="' + e.commentNo + '"></td>';
				output += '<td>';
				for (let i=0; i< e.step; i++ ) {
					output += "<i class='bx bx-subdirectory-right'></i>";
				}
				output += '</td><td>' + e.commentNo + '</td>';
				output += '<td>' + e.commenter + '</td>';
				output += '<td>' + e.writeDate + '</td>';
				output += '<td style="white-space: break-spaces; padding-right:30px;">' + e.comment + '</td>';
				output += '<td><a href="javascript:deleteOne('+ e.commentNo + ');"><i class="bx bx-trash me-1"></i></a></td>';
				output += '</tr>';
			});
		} else {
			output += '<tr><td></td></tr>';
			let output2 = '<h5 style="height: 81px; margin-top: 55px; text-align: center;">댓글 없음</h5>';
			$(".table-responsive").next().html(output2);
		}
		$("#checkAll").prop("checked", false);
		$("#commentList").html(output);
	}
	
	function parsePaging(data) {
		$(".pagination").empty();
		let output = "";
		let beforePageNo = pageNo;
		if (pageNo > 2) {
			output += '<li class="page-item prev"><a class="page-link" href="javascript:getComment(1);">'
					+ '<i class="tf-icon bx bx-chevrons-left"></i></a></li>';
		}
		if (pageNo > 1) {
			output += '<li class="page-item prev"><a class="page-link" href="javascript:getComment(' + (pageNo-1) + ');">'
				+ '<i class="tf-icon bx bx-chevron-left"></i></a></li>';
		}
		for (let i = data.startNoOfCurPagingBlock; i <= data.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				output += '<li class="page-item active"><a class="page-link" href="javascript:getComment(' + i + ');">'
						+ i + '</a></li>';
			} else {
				output += '<li class="page-item"><a class="page-link" href="javascript:getComment(' + i + ');">'
				+ i + '</a></li>';
			}
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item next"><a class="page-link" href="javascript:getComment(' + ++pageNo + ');">'
			+ '<i class="tf-icon bx bx-chevron-right"></i></a></li>';
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item next"><a class="page-link" href="javascript:getComment(' + data.totalPage + ');">'
				+ '<i class="tf-icon bx bx-chevrons-right"></i></a></li>';
		}
		pageNo = beforePageNo;
	
		$(".pagination").html(output);
		
		if ($("#totalCommentNum").val() != data.totalPostCnt) {
			$("#totalCommentNum").val(data.totalPostCnt);
		}
	}
	
	function commentCheck() {
		$("#checkAll").on("click", function() {
			$(".commentCheck").prop("checked", this.checked);
		});
	}
	
	function deleteOne(no) {
		$("input:checkbox[value='" + no + "']").prop("checked", true);
		$(".modalBtn").click();
	}
	
	function showModal() {
		$("#checkInfo").remove();
		let output = "";
		if ($(".commentCheck:checked").length != 0) {
			$('.modal-body').show();
			deleteNoList = [];
			output += "<h5 id='checkInfo'><strong>선택된 댓글번호</strong><br/>";
			$(".commentCheck:checked").each(function() {
				output += '<span class="badge bg-label-danger deleteNo">' + $(this).val() + '번</span>';
				deleteNoList.push($(this).val());
			});
			output += "</h5>";
			$(".modal-body h5").before(output);
			$('#deleteBtn').removeAttr("disabled");
		} else {
			$('.modal-body').hide();
			output += '<div id="checkInfo" style="height:160px; text-align:center;">';
			output += '<h5 style="padding: 54px 24px 0;"><strong>선택된 댓글이 없습니다</strong></h5>';
			output += '<p style="margin-bottom: 25px; color:red;">(댓글을 선택 후에 다시 눌러주세요)</p></div>';
			$('.modal-header').after(output);
			$('#deleteBtn').prop('disabled', true);
		}
		
		$("#checkAll").prop("checked", false);
		$(".commentCheck").prop("checked", false);
	}
	
	function deleteComment() {
		console.log(deleteNoList);
		let url = "/reviewManager/deleteComment";
		$.ajax({
			url : url,
			data : {
				deleteNoList : deleteNoList,
				reviewNo : $("#reviewNo").val()
			},
			dataType : "text",
			type : "POST",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					getComment(1);
					$(".btn-close").click();
				} else {
					alert("리뷰댓글 삭제실패");
				}
			},error : function(){
				alert("리뷰댓글 삭제실패");
			}
		});
	}
	
	
</script>
<style>
	.back {
 		background: -webkit-gradient(linear, left top, right bottom, from(white), to(#fafbfc));
  	 	background: -webkit-linear-gradient(top left, white 0%, #fafbfc 100%);
   	 	background: -moz-linear-gradient(top left, white 0%, #fafbfc 100%);
    	background: -o-linear-gradient(top left, white 0%, #fafbfc 100%);
    	background: linear-gradient(to bottom right, white 0%, #fafbfc 100%);
 	}
 
	.thumbImg, .notImg {
		width: 150px;
		height: 150px;
		margin-right: 25px;
	}
	.notImg {
		border: 1px solid;
		display: inline-block;
		font-size: small;
    	line-break: anywhere;
    	padding-top: 7px;
    	vertical-align: middle;
	}
	
	.replyImg {
    	width: 20px;
    	height: 20px;
    	margin-right: 10px;
    	margin-bottom: 5px;
	}
	
	.deleteNo {
 		margin: 15px 7px 0px 7px;
 	}
</style>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
	<div class="back">	
		<div class="card" style="margin: 50px; width: 1050px; display: inline-block;">
			<h5 class="card-header">리뷰 상세조회</h5>
			<div style="margin: 0 0 60px 37px;">
				<div style="display: inline-block;">
					<label for="detail" class="form-label" style="display: block">리뷰번호</label>
					<input type="text" class="form-control" value="${review.reviewNo}" readonly
					 style="width: 82px; display: inline-block; background-color: #fafbfc;"
					>	
				</div>
				<div style="display: inline-block; margin-left: 37px;">
					<label for="detail" class="form-label" style="display: block">제목</label>
					<input type="text" class="form-control" value="${review.title}" readonly
					 style="width:400px; display: inline-block; background-color: #fafbfc;"
					>
				</div>
				<div style="display: inline-block; margin-left: 100px;">
					<label for="detail" class="form-label" style="display: block">작성자</label>
					<input type="text" class="form-control" value="${review.writer}" readonly
					 style="width:100px; display: inline-block; background-color: #fafbfc;"
					>
				</div>
				<div style="display: inline-block; margin-left: 35px;">
					<label for="detail" class="form-label" style="display: block">작성날짜</label>
					<input type="text" class="form-control" value="${review.writedate}" readonly
					style="width:210px; display: inline-block; background-color: #fafbfc;"
					>
				</div>
				<div style="display: inline-block; margin-top: 20px;">
					<label for="detail" class="form-label" style="display: block">내용</label>
					<textarea type="text" class="form-control" rows="8"  readonly
					style="width:760px; display:inline-block; background-color: #fafbfc;"
					>${review.content}</textarea>
				</div>
				<div style="display: inline-block; float: right; margin: 10px 40px 0 0;">
					<div style="margin-top: 12px">
						<label for="detail" class="form-label" style="display: block">별점수</label>
						<input type="text" class="form-control" style="width:150px; display: inline-block;
						color: #fbd600; background-color: #fafbfc;" id="star" readonly>
					</div>
					<div style="margin-top: 12px" >
						<label for="detail" class="form-label" style="display: block">추천수</label>
						<input type="text" class="form-control" value="${review.recommendNum}" readonly
						style="width:150px; display: inline-block; background-color: #fafbfc;"
						>
					</div>
					<div style="margin-top: 12px">
						<label for="detail" class="form-label" style="display: block">댓글수</label>
						<input type="text" class="form-control" id="totalCommentNum"
						 value="${review.commentNum}" readonly style="width:150px; display: inline-block;
						  background-color: #fafbfc;">
					</div>
				</div>
				<div class="attachfile" style="margin-top: 20px;">
					<label for="detail" class="form-label" style="display: block">첨부파일</label>
					<c:forEach var="file" items="${fileList}">
						<c:if test="${file.thumbnailFile != null}">
							<img class='thumbImg' src='/resources/uploads${file.originFile}'/>
						</c:if>
						<c:if test="${file.notImageFile != null}">
							<a class='notImg' href='/resources/uploads${file.notImageFile}'></a>
						</c:if>
					</c:forEach>
					<c:if test="${review.fileStatus == 'no'}">
						<h5 style="height: 81px; margin-top: 75px; text-align: center;">파일 없음</h5>
					</c:if>
				</div>
			</div>
		</div>
		<div class="card" style="margin:50px 50px 0 0; width:440px; display:inline-block; float: right;">
			<h5 class="card-header">해당 상품</h5>
			<div style="margin: 10px 0px 35px 20px; width:400px; height: 529px;">
				<div class="card mb-3">
					<img class="card-img-top" src="${product.cover}" alt="Card image cap"
					style="width:150px; height:210px; align-self:center; margin-top: 25px;">
					<div class="card-body">
						<h5 class="card-title">${product.title} (상품번호 : ${product.product_no})</h5>
						<p class="card-text" id ="prodDescrip" style="height:120px; overflow:auto;"></p>
						<p class="card-text" id="prodPrice">판매가 : ${product.sell_price}원</p>
						<p class="card-text">
							<small class="text-muted">출판사 : ${product.publisher}  |  출판일 : ${product.pub_date}</small>
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="card" style="margin: 0 50px 50px 50px">
			<div>
				<h5 class="card-header" style="display: inline-block; width: 1200px;">리뷰 댓글</h5>
				<div style="display: inline-block; width: 158px; margin: 28px 24px 24px 0; float: right;">
					<button type="button" class="btn btn-outline-primary modalBtn" data-bs-toggle="modal"
					 data-bs-target="#modalToggle" onclick="showModal();">일괄 삭제 &nbsp; 
					 <span class="tf-icons bx bx-trash me-1" style="margin-bottom: 4px;"></span>
					</button>
				</div>
			</div>
            <div class="table-responsive text-nowrap">
            	<table class="table table-hover">
                	<thead>
                      <tr>
                      	<th style="width: 0;">
                      		<input class="form-check-input" type="checkbox" id="checkAll" style="width:18px; height: 18px;">
                      	</th>
                      	<th style="width:0px;"></th>
                      	<th style="width:140px;">댓글번호</th>
                      	<th style="width:170px;">작성자</th>
                        <th style="width:240px;">작성날짜</th>
                        <th style="width:1000px;">내용</th>
                        <th style="width:180px;">삭제</th>
                      </tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id="commentList">
                    </tbody>
            	</table>
            </div>
            <nav aria-label="Page navigation">
            	<ul class="pagination justify-content-center" style="padding: 25px 0px 15px 0px;">
                </ul>
       		</nav>
    	</div>
	</div>
	
	<!-- 댓글 삭제 모달창 시작 -->
	<div class="modal fade" id="modalToggle" aria-labelledby="modalToggleLabel"
		tabindex="-1" style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalToggleLabel" style="color:black;">리뷰댓글 삭제</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="text-align: center; padding-bottom:0;">
					<h5 style="margin-top:26px;"><strong>해당 댓글을 삭제하시겠습니까?</strong></h5>
					<p style="color:red;">(한번 삭제한 댓글은 복원이 불가합니다)</p>
					<input type="hidden" id="reviewNo" value = "${review.reviewNo}">
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" id="deleteBtn" onclick="deleteComment();">삭제하기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 댓글 삭제 모달창 끝 -->
	
	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>