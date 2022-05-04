<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	let pageNo = 1;
	let searchData = "";
	let order = 1;
	let deleteNoList = [];
	let deleteFileList = [];
	
	$(function() {
		starColor();
		orderChange();
		getReviewList(1);
		reviewCheck();
	});
	
	function starColor() {
		$("#startStar").on("change", function (s) {
			$("#startStar").css("color", "#fbd600");
		});
		$("#endStar").on("change", function (s) {
			$("#endStar").css("color", "#fbd600");
		});
	}
	
	function getReviewList(no) {
		pageNo = no;
		let sendData = "";
		if (searchData == "") {
			sendData = JSON.stringify({
				pageNo : pageNo, order : order
			});
		} else {
			searchData['pageNo'] = pageNo;
			searchData['order'] = order;
			sendData = JSON.stringify(searchData);
		}
		console.log(sendData);

		let url = "/reviewManager/listReview";
		$.ajax({
			url : url,
			data : sendData,
			dataType : "json",
			type : "POST",
			headers : {
				"content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			success : function(data) {
				console.log(data);
				if (data.reviewList != null) {
					parseList(data.reviewList,data.fileList);
					parsePaging(data.pagingInfo);
				} 
			},error : function(){
				alert("리뷰 가져오기 실패");
			}
		});
	}

	function parseList(rList,fList) {
		$("#reviewtList").empty();
		let output = '';
		$.each(rList,function(i, e) {
			output += '<tr onclick=location.href="${contextPath}/admin/reviewBoard/detail?no=' + e.reviewNo + '">';
			output += '<td onclick="event.stopPropagation();"><input class="form-check-input reviewCheck" type="checkbox" value="' + e.reviewNo + '">';
			if (e.fileStatus == "yes") {
				$.each(fList, function(i, file) {
					if (e.reviewNo == file.reviewNo) {
						if (file.thumbnailFile != null) {
							output += "<input type='hidden' value='" + file.thumbnailFile + "'>";
						} else if (file.notImageFile != null) {
							output += "<input type='hidden' value='" + file.notImageFile + "'>";
						}
					}
				});
			}
			output += '</td>';
			output += '<td><strong>' + e.reviewNo + '</strong></td>';
			output += '<td>' + e.productNo + '</td>';
			output += '<td class="reviewTitle">' + e.title + '</td>';
			output += '<td>' + e.writer + '</td>';
			let writeDate = new Date(e.writedate).toLocaleString();
			writeDate = writeDate.split("오")[0];
			output += '<td>' + writeDate + '</td>';
			let content = e.content.replaceAll("<br/>", "");
			output += '<td class="reviewContent">' + content + '</td>';
			let grade = "";
			for (let i = 0; i < e.grade; i++) {
				grade += "★";
			}
			for (let i = 0; i < 5-e.grade; i++) {
				grade += "☆";
			}
			output += '<td class="s">' + grade + '</td>';
			output += '<td>' + e.recommendNum + '개</td>';
			output += '<td>' + e.commentNum + '개</td>';
			output += '<td> <ul class="list-unstyled users-list m-0 avatar-group d-flex align-items-center">';
			if (e.fileStatus == "yes") {
				$.each(fList, function(i, file) {
					if (e.reviewNo == file.reviewNo) {
						output += '<li data-bs-toggle="tooltip" data-popup="tooltip-custom" data-bs-placement="top" class="avatar avatar-xs pull-up" title="" data-bs-original-title="Lilian Fuller">';
						if (file.thumbnailFile != null) {
							output += "<img class='rounded-circle thumbImgR' src='${contextPath}/resources/uploads" + file.thumbnailFile + "'>";
						} else if (file.notImageFile != null) {
							output += "<img class='rounded-circle notImgR' src='${contextPath}/resources/img/review/bx-file.svg'>";
						}
						output += '</li>';
					}
				});
			} else {
				output += '<li class="avatar avatar-xs">없음</li>';
			}
			output += '</ul></td>';
			output += '<td onclick="event.cancelBubble=true"><a href="javascript:deleteOne('+ e.reviewNo + ');"><i class="bx bx-trash me-1"></i></a></td>'
			output += '</tr>';
		});
		$("#checkAll").prop("checked", false);
		$("#reviewtList").html(output);
	}
	
	function parsePaging(data) {
		$(".pagination").empty();
		let output = "";
		let beforePageNo = pageNo;
		if (pageNo > 2) {
			output += '<li class="page-item prev"><a class="page-link" href="javascript:getReviewList(1);">'
					+ '<i class="tf-icon bx bx-chevrons-left"></i></a></li>';
		}
		if (pageNo > 1) {
			output += '<li class="page-item prev"><a class="page-link" href="javascript:getReviewList(' + (pageNo-1) + ');">'
				+ '<i class="tf-icon bx bx-chevron-left"></i></a></li>';
		}
		for (let i = data.startNoOfCurPagingBlock; i <= data.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				output += '<li class="page-item active"><a class="page-link" href="javascript:getReviewList(' + i + ');">'
						+ i + '</a></li>';
			} else {
				output += '<li class="page-item"><a class="page-link" href="javascript:getReviewList(' + i + ');">'
				+ i + '</a></li>';
			}
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item next"><a class="page-link" href="javascript:getReviewList(' + ++pageNo + ');">'
			+ '<i class="tf-icon bx bx-chevron-right"></i></a></li>';
		}
		if (pageNo < data.totalPage) {
			output += '<li class="page-item next"><a class="page-link" href="javascript:getReviewList(' + data.totalPage + ');">'
				+ '<i class="tf-icon bx bx-chevrons-right"></i></a></li>';
		}
		pageNo = beforePageNo;
		$(".pagination").html(output);
	}
	
	function searchReview() {
		let searchType = $("#serachType").val();
		let searchWord = $("#searchWord").val();
		let startDate = $("#startDate").val();
		let endDate = $("#endDate").val();
		let startStar = $("#startStar").val();
		let endStar = $("#endStar").val();
		let fileStatus = $("input[name='fileStatus']:checked").attr("id");
		
		let searchInfo = false;
		let starInfo = false;
		let dateInfo = false;
		
		if (searchType == "키워드 검색" && searchWord != "") {
			alert("키워드를 선택해주세요!");
		} else {
			 searchInfo = true;
		}
		
		if (startStar != "시작 별점" && endStar == "종료 별점") {
			alert("종료 별점을 선택해주세요!");
		} else if (startStar == "시작 별점" && endStar != "종료 별점") {
			alert("시작 별점을 선택해주세요!");
		} else if (startStar > endStar) {
			alert("시작 별점이 종료 별점보다 크면 안됩니다")
		} else {
			starInfo = true;
		}
		
		if (startDate != "" && endDate == "") {
			alert("종료일을 선택해주세요!");
		} else if (startDate == "" && endDate != "") {
			alert("시작일을 선택해주세요!");
		} else if (startDate > endDate) {
			alert("시작일은 종료일 이전이여야 합니다");
		} else {
			dateInfo = true;
		}
		
		if (searchInfo && starInfo && dateInfo) {
			searchData = {
				searchType : searchType, searchWord : searchWord,
				startDate : startDate, endDate : endDate,
				startStar : startStar, endStar : endStar,
				fileStatus : fileStatus, pageNo : 1,
				order : 0
			};
			getReviewList(1);
		}
	}
	
	function orderChange() {
		$("input[name='order']").on("change", function() {
			order = $(this).attr("id").split("order")[1];
			getReviewList(1);
		});
	}
	
	function reviewCheck() {
		$("#checkAll").on("click", function() {
			$(".reviewCheck").prop("checked", this.checked);
		});
	}
	
	function deleteOne(no) {
		$("input:checkbox[value='" + no + "']").prop("checked", true);
		$(".modalBtn").click();
	}
	
	function showModal() {
		$("#checkInfo").remove();
		let output = "";
		if ($(".reviewCheck:checked").length != 0) {
			$('.modal-body').show();
			deleteNoList = [];
			deleteFileList = [];
			output += "<h5 id='checkInfo'><strong>선택된 리뷰번호</strong><br/>";
			$(".reviewCheck:checked").each(function() {
				output += '<span class="badge bg-label-danger deleteNo">' + $(this).val() + '번</span>';
				deleteNoList.push($(this).val());
				let file = $(this).siblings("input");
				if (file.length != 0) {
					file.each(function() {
						deleteFileList.push($(this).val());
					});
				}
			});
			output += "</h5>";
			$(".modal-body h5").before(output);
			$('#deleteBtn').removeAttr("disabled");
		} else {
			$('.modal-body').hide();
			output += '<div id="checkInfo" style="height:160px; text-align:center;">';
			output += '<h5 style="padding: 54px 24px 0;"><strong>선택된 리뷰가 없습니다</strong></h5>';
			output += '<p style="margin-bottom: 25px; color:red;">(리뷰를 선택 후에 다시 눌러주세요)</p></div>';
			$('.modal-header').after(output);
			$('#deleteBtn').prop('disabled', true);
		}
		
		$("#checkAll").prop("checked", false);
		$(".reviewCheck").prop("checked", false);
	}
	
	function deleteReview() {
		console.log(deleteNoList);
		console.log(deleteFileList);
		if (deleteFileList.length == 0) {
			deleteFileList.push("파일없음");
		}
		let url = "/reviewManager/deleteReview";
		$.ajax({
			url : url,
			data : {
				deleteNoList : deleteNoList,
				deleteFileList : deleteFileList
			},
			dataType : "text",
			type : "POST",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					getReviewList(1);
					$(".btn-close").click();
				} else {
					alert("리뷰 삭제실패");
				}
			},error : function(){
				alert("리뷰 삭제실패");
			}
		});
	}
	
</script>
<title>Insert title here</title>
<style >
 .reviewTitle {
	max-width: 280px;
    overflow: hidden;
    text-overflow: ellipsis;
 }

 .reviewContent {
 	max-width: 310px;
    overflow: hidden;
    text-overflow: ellipsis;
 }
 .s {
 	color:#fbd600;
 }
 .back {
 	background: -webkit-gradient(linear, left top, right bottom, from(white), to(#fafbfc));
    background: -webkit-linear-gradient(top left, white 0%, #fafbfc 100%);
    background: -moz-linear-gradient(top left, white 0%, #fafbfc 100%);
    background: -o-linear-gradient(top left, white 0%, #fafbfc 100%);
    background: linear-gradient(to bottom right, white 0%, #fafbfc 100%);
 }
 .deleteNo {
 	margin: 15px 7px 0px 7px;
 }
 #startStar,#endStar {
 	width: 150px;
 	display: inline-block;
 	margin-right: 10px;
 }
 #startDate,#endDate {
 	width: 218px;
	display: inline-block;
 }
 .form-label {
 	display: block;
 }
</style>
</head>
<body>
	<jsp:include page="../../managerHeader.jsp"></jsp:include>
	<div class="back">
		
		<div class="card" style="margin: 50px; width: 1050px; display: inline-block;">
			<h5 class="card-header">리뷰 상세검색</h5>
			<div style="margin: 0 0 60px 37px;">
			<div style="display: inline-block;">
				<label for="searchKey" class="form-label">검색어</label>
				<select class="form-select" id="serachType" style="width: 150px; display: inline-block;" >
					<option selected="" hidden="">키워드 검색</option>
					<option value="reviewNo">리뷰번호</option>
					<option value="productNo">상품번호</option>
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" class="form-control" id="searchWord" placeholder="검색할 내용을 입력하세요" 
					style="width: 300px; display: inline-block;">	
			</div>
			<div style="display: inline-block; margin-left: 37px;" >
					<label for="searchDate" class="form-label">작성기간 (시작일 ~ 종료일)</label>
					<input type="date" class="form-control" id="startDate">
					<span style="font-size: 24px; margin: 0 10px 0 10px;">~</span>
					<input type="date" class="form-control" id="endDate">
			</div>
			<br>
			<div style="display: inline-block;">
				<label for="searchGrade" class="form-label" style="padding-top: 20px;">별점 수</label>
				<select class="form-select" id="startStar">
					<option selected="" hidden="" >시작 별점</option>
					<option value="1" class="s" >★</option>
					<option value="2" class="s" >★★</option>
					<option value="3" class="s" >★★★</option>
					<option value="4" class="s" >★★★★</option>
					<option value="5" class="s" >★★★★★</option>
				</select>
				<span style="font-size: 24px; margin-right: 10px;">~</span>
				<select class="form-select" id="endStar">
					<option selected="" hidden="">종료 별점</option>
					<option value="1" class="s" >★</option>
					<option value="2" class="s" >★★</option>
					<option value="3" class="s" >★★★</option>
					<option value="4" class="s" >★★★★</option>
					<option value="5" class="s" >★★★★★</option>
				</select>
			</div>
			<div style="display: inline-block; margin-left: 142px;">
				<label for="searchAttach" class="form-label">첨부파일 유무</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="fileStatus" id ="all" checked="" >
					<label class="btn btn-outline-primary" for="all">전체보기</label>
					<input type="radio" class="btn-check" name="fileStatus" id ="yes" >
					<label class="btn btn-outline-primary" for="yes">첨부파일 있음</label>
					<input type="radio" class="btn-check" name="fileStatus" id ="no">
					<label class="btn btn-outline-primary" for="no">첨부파일 없음</label>
				</div>
			</div>
			</div>
			<div style="text-align: center; margin-bottom: 40px;">
				<button type="button" class="btn btn-primary btn-lg" onclick="searchReview();"
				style="width: 400px;"> 검색하기 &nbsp;&nbsp;
					<span class="tf-icons bx bx-search-alt"></span>
            	</button>
            </div>
		</div>

		<div class="card" style="margin:50px 50px 50px 0; width:435px; display:inline-block;">
			<h5 class="card-header" >리뷰 정렬</h5>
			<div style="margin :0 0px 45px 27px;">
			<div style="display: inline-block; margin-top: 2px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">리뷰번호순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order1" checked="" >
					<label class="btn btn-outline-primary" for="order1">높은순</label>
					<input type="radio" class="btn-check" name="order" id="order2">
					<label class="btn btn-outline-primary" for="order2">낮은순</label>
				</div>
			</div>
			<div style="display: inline-block; margin-left: 33px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">상품번호순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order3">
					<label class="btn btn-outline-primary" for="order3">높은순</label>
					<input type="radio" class="btn-check" name="order" id="order4">
					<label class="btn btn-outline-primary" for="order4">낮은순</label>
				</div>
			</div>
			<div style="display: inline-block; margin-top: 25px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">작성날짜순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order5">
					<label class="btn btn-outline-primary" for="order5">최신순</label>
					<input type="radio" class="btn-check" name="order" id="order6">
					<label class="btn btn-outline-primary" for="order6">오래된순</label>
				</div>
			</div>
			<div style="display: inline-block; margin-left: 19px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">별점순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order7">
					<label class="btn btn-outline-primary" for="order7">높은순</label>
					<input type="radio" class="btn-check" name="order" id="order8">
					<label class="btn btn-outline-primary" for="order8">낮은순</label>
				</div>
			</div>
			<div style="display: inline-block; margin-top: 25px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">추천순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order9">
					<label class="btn btn-outline-primary" for="order9">높은순</label>
					<input type="radio" class="btn-check" name="order" id="order10">
					<label class="btn btn-outline-primary" for="order10">낮은순</label>
				</div>
			</div>
			<div style="display: inline-block; margin-left: 33px;">
				<label for="order" class="form-label" style="margin-bottom: 12px;">댓글순</label>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="order" id="order11">
					<label class="btn btn-outline-primary" for="order11">높은순</label>
					<input type="radio" class="btn-check" name="order" id="order12">
					<label class="btn btn-outline-primary" for="order12">낮은순</label>
				</div>
			</div>
			</div>
		</div>
		
		<div class="card" style="margin: 0 50px 50px 50px">
			<div>
				<h5 class="card-header" style="display: inline-block; width: 1200px;">상품 리뷰게시판</h5>
                <div style="display: inline-block; width:158px; margin: 28px 24px 24px 0; float: right;" >
               		<button type="button" class="btn btn-outline-primary modalBtn"  data-bs-toggle="modal"
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
                      		<th style="width: 90px;">리뷰번호</th>
                      		<th style="width: 90px;">상품번호</th>
                     	 	<th style="width: 280px;">제목</th>
           	            	<th style="width: 110px;">작성자</th>
          	              	<th style="width: 120px;">작성날짜</th>
                        	<th style="width: 310px;">내용</th>
                        	<th style="width:115px;">별점수</th>
                        	<th style="width: 80px;">추천수</th>
                        	<th style="width: 80px;">댓글수</th>
                        	<th>첨부파일</th>
                        	<th>삭제</th>
                    	</tr>
                    </thead>
                    <tbody class="table-border-bottom-0" id ="reviewtList">
                    </tbody>
                </table>
           	</div>
           	<nav aria-label="Page navigation">
            	<ul class="pagination justify-content-center" style="padding: 25px 0px 15px 0px;">
                </ul>
            </nav>
       	</div> 
	</div>
	<!-- 리뷰 삭제 모달창 시작 -->
	<div class="modal fade" id="modalToggle"
		aria-labelledby="modalToggleLabel" tabindex="-1"
		style="display: none;" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalToggleLabel" style="color:black;">리뷰 삭제</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="text-align: center; padding-bottom:0;">
					<h5 style="margin-top:26px;"><strong>해당 리뷰를 삭제하시겠습니까?</strong></h5>
					<p style="color:red;">(한번 삭제한 리뷰는 복원이 불가합니다)</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-danger" id="deleteBtn" onclick="deleteReview();">삭제하기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 리뷰 삭제 모달창 끝 -->
	<jsp:include page="../../managerFooter.jsp"></jsp:include>
</body>
</html>