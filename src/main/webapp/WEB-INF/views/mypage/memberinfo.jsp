<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="<%=request.getContextPath() %>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>My Page</title>
<!-- Page CSS -->


</head>
<script>
let pageNo = 1;

	function confirm(orderNo){
		$.ajax({
			url : "/order/confirmOrder",
			data : {
				orderNo : orderNo
			},
			type : "post",
			success : function(data){
				getOrderStatus(pageNo);
			},error : function(data){
			}
		})
	}
	function refund(orderNo){

	}
	
	function parsingOrder(data){
		console.log(data);
		let output2 = '';
		let pagingoutput = '<nav class="blog-pagination justify-content-center d-flex"><ul class="pagination">';
			$.each(data.order, function(i, e) {
				output2 += '<tr><td>'+e.orderNo+'</td>'
				output2 += '<td><div class="media"><div class="d-flex" style="width:200px"><img src="'+e.cover+'" style="width: 150px"></div><div class="media-body"><p>'+e.title+ '</p></div></div></td>'
				output2 += '<td>'+e.productQtt+'</td>'
				output2 += '<td><h5 id = "price'+e.cartNo+'">'+ e.price.toLocaleString()+'원</td>'
				output2 +='<td>';
				if(e.orderState_code == 1){
					output2 += '출고 준비중';
				}else if(e.orderState_code ==2){
					output2 += '배송중';
				}else if(e.orderState_code ==3){
					output2 += '배송완료';
				}else if(e.orderState_code == 4){
					output2 += '주문 취소';
				}else if(e.orderState_code == 5){
					output2 += '상품 환불';
				}
				output2 +='</td>';
				output2 += '<td>';
				if(e.orderState_code == 5){
					output2 += 'Y';
				}else{
					output2 += '<button type="button" id="refundBtn" onclick="refund();" class="button" value="'+e.orderNo+'">환불신청</button>';
				}
				output2 += '</td>';
				output2 += '<td>';
				if(e.confirm == 'Y'){
					output2 += "Y";
				}else if(e.orderState_code == 5 && e.confirm == 'N'){
					output2 += "환불 대기중";
				}else if(e.orderState_code == 4){
					output2 += "주문 취소";
				}
				else{
					output2 += '<button type="button" id="cofirmBtn" class="button" onclick="confirm(this.value);" value="'+e.orderNo+'">확정하기</button>';
				}
				output2 += '</td></tr>';
				});
		if (pageNo != 1) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='getOrderStatus(1)' ><<<i class='tf-icon bx bx-chevrons-left'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='getOrderStatus("+ (pageNo - 1)+ ")'><<i class='tf-icon bx bx-chevron-left'> </i></a></li>";
		}
		for (let i = data.pagingInfo.startNoOfCurPagingBlock; i <= data.pagingInfo.endNoOfCurPagingBlock; i++) {
			if (pageNo == i) {
				pagingoutput += "<li class='page-item active'><a class='page-link' onclick='getOrderStatus("+ i+ ")'>"+ i+ "</a></li>";
			} else {
				pagingoutput += "<li class='page-item'><a class='page-link' onclick='getOrderStatus("+ i+ ")'>"+ i+ "</a></li>";
			}
		}

		if (pageNo < data.pagingInfo.totalPage) {
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='getOrderStatus("+ (pageNo + 1)+ ")' >><i class='tf-icon bx bx-chevron-right'></i></a></li>";
			pagingoutput += "<li class='page-item last'><a class='page-link'onclick='getOrderStatus("+ (data.pagingInfo.totalPage)+ ")' >>><i class='tf-icon bx bx-chevrons-right'></i></a></li>";
		}

		pagingoutput += '</ul></nav>'

		$("#pagingZone").html(pagingoutput);
		$("#output").html(output2);
	}

	function orderStatus(){
		let output ='<div class="container" style= "width:1200px;"><div><div class="table-responsive"><table class="table">'
		output += '<thead><tr><th scope="col" nowrap> 주문 번호</th><th scope="col" nowrap style="width:500px;">상품</th><th scope="col" nowrap>수량</th><th scope="col" nowrap>가격</th><th scope="col" nowrap>상태</th><th scope="col" nowrap>환불</th><th scope="col" nowrap>확정</th></tr></thead>'
		output += '<tbody id="output"></tbody></table></div></div></div><div class="demo-inline-spacing" id="pagingZone">12</div></div>';
		$("#myPageOrder").html(output);
		getOrderStatus(pageNo);
	}
	
	function getOrderStatus(pno){
		$.ajax({
			url : "${contextPath}/order/orderstatus/"+pno,
			type : "get",
			data : {
				sessionId : "${sessionId}"
			},
			success : function(data) {
				pageNo = pno;
				parsingOrder(data);
			},
			error : function(data){
				console.log(data);
				
			}
		});
	}

// 비밀번호 변경
function confirmModifyPwd() {
	
	let pwd1 = $("#pwd1").val();
	let pwd2 =$("#pwd2").val();
	let ses = "${ sessionId}"
	let url = "${ contextPath}/mypage/changePassword"
	console.log(url);
	console.log(ses);
	if (pwd1 == pwd2) {
		console.log("비밀번호 일치함 ajax로 통신")
		$.ajax({
			url : url,
			dataType : "json",
			//contentType :"application/json; charset=utf-8", 
			type : "POST",
			data : {
				ses : ses,
				pwd1 : pwd1
			},
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				if (data == 1) {
					$("#yesButton").remove();
					$(".buttonCon").text('확인');
					
					$(".modal-footer").prepend("<p style = 'text-align : left;'>비밀번호 변경이 완료되었습니다.</p>");
		
				} else {
					console.log("백단에서 뭔가가 잘못되었다.")
				}
			}
		});	
	} else {
		let p = document.createElement("p")
		p.innerText = "변경할 비밀번호와 확인이 다릅니다. 확인해주세요."
		$("#pwdModi").append(p);
	}
} 

function confirmPwd(e) {
	
	let ses = "${ sessionId}"
	
	let oldPwd = document.getElementById('originalPwd').value; // 현재 모달창에 입력한 패스워드 - 계속 보내서 DB에 확인
	//document.getElementById('correctOrNot').innerHTML = oldPwd;
	
	let url = "${ contextPath}/mypage/confirmPassword";
	
	$.ajax({
				url : url,
				dataType : "json", 
				type : "POST",
				data : {
					ses : ses,
					oldPwd : oldPwd
				},
				success : function(data) { // 통신 성공시 실행될 콜백 함수
					
					if (data == true) {
						document.getElementById('correctOrNot').innerHTML = "<span style = 'color: green;'> ● 일치</span>";
						document.getElementById("yesButton").onclick = confirmModifyPwd;
						
						
					} else {
						// 확인 버튼 안넘어가게 하기.
						document.getElementById('correctOrNot').innerHTML = "<span style = 'color: red;'> ● 불일치</span>";
						document.getElementById("yesButton").onclick = null;

						
					}
					

					}, error : function() {
				}
			});	
}

// 회원 삭제

	function withdrawMember() {

		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라

		let url = "withdrawMember";

		$.ajax({
					url : url,
					dataType : "text",
					type : "POST",
					data : {
						ses : ses
					},
					success : function(data) { // 통신 성공시 실행될 콜백 함수
						console.log(data)
						if (data == 1) {
							console
									.log(document.getElementById('confirm').innerHTML);
							document.getElementById('confirm').innerHTML = "<p>탈퇴가 완료되었습니다. 삭제 후 30일 이내에 복구 신청시, 계정을 다시 사용하실 수 있습니다.</p>";
							$(".yesButton").remove();

							// 예 / 아니오를 모달창  확인 버튼 하나로 바꾸기.
							document.getElementsByClassName('buttonCon')[0].innerHTML = "확인"
						}

					}
				});
	}
	
// 사용한 적립금 조회
	function pointUsed() {
		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라
		let url = "${ contextPath}/mypage/viewPointUsed";	
		$.ajax({
			url : url,
			dataType : "json",
			//contentType :"application/json; charset=utf-8", 
			type : "GET",
			data : {
				ses : ses
			},
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".infoBox").hide();
				$(".mypostsBox").hide();
				$(".pointBox").show();
				let output = '<h3> 포인트 적립 내역</h3><div class = "board_filters"><ul><li onclick="totalPoint();">전체 내역</li><li>|</li><li onclick="pointHistory()";>적립내역</li><li>|</li><li onclick="pointUsed();">사용내역</li></ul></div><div class = "table-responsive"><table class="table"><thead><tr><th>Point</th><th>적립 사유</th><th>적립 일시</th></tr></thead><tbody>';
				// pointUsed()
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td>'+ e.point + '</td><td>' + e.pointWhy + '</td><td>' + e.pointWhen + '</td></tr>'
				})
				output += '</tbody></table></div>'
				console.log(output);
				
				$(".pointBox").html(output);
				}, error : function() {
			}
		});		
	}
	
	// 전체 적립금 조회
	function totalPoint() {
		
		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라
		let url = "${ contextPath}/mypage/pointTotal?u=" + ses;	
		$.ajax({
			url : url,
			dataType : "json",
			//contentType :"application/json; charset=utf-8", 
			type : "GET",
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".pointBox").empty();
				let output = '<h3><b> 포인트 전체 내역</b></h3><div class = "board_filters"><ul><li onclick="totalPoint();">전체</li><li>|</li><li onclick="pointHistory()";>적립</li><li>|</li><li onclick="pointUsed();">사용</li></ul></div><div class = "table-responsive"><table class="table"><thead><tr><th>Point</th><th>적립 사유</th><th>적립 일시</th></tr></thead><tbody>';
				// pointUsed()
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td>'+ e.point + '</td><td>' + e.pointWhy + '</td><td>' + e.pointWhen + '</td></tr>'
				})
				output += '</tbody></table></div>'
				console.log(output);
				
				$(".pointBox").html(output);

				}, error : function() {
			}
		});		
		
	}
	
	/* 적립금 적립 내역 조회 */
	
	function pointHistory(e) {
		let ses = "${ sessionId}"; // 세션에 담긴 ID값 가져오라
		let url = "${ contextPath}/mypage/viewPoint";	
		$.ajax({
			url : url,
			dataType : "json",
			
			type : "GET",
			data : {
				ses : ses
			},
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".infoBox").hide();
				$(".mypostsBox").hide();
				$(".pointBox").show();
				let output = '<h3><b>포인트 적립 내역</b></h3><div class = "board_filters"><ul><li onclick="totalPoint();">전체</li><li>|</li><li onclick="pointHistory()";>적립</li><li>|</li><li onclick="pointUsed();">사용</li></ul></div><div class = "table-responsive"><table class="table"><thead><tr><th>적립 일시</th><th>Point</th><th>적립 사유</th></tr></thead><tbody>';
				let sum = 0;
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td>'+ e.pointWhen + '</td><td>' + e.point + '</td><td>' + e.pointWhy + '</td></tr>'
				sum += e.point
				})
				output += '<tr><td>총 적립 포인트 : </td><td>' + sum +'</td><td></td></tr></tbody></table></div>'
				console.log(output);
				
				$(".pointBox").html(output);
				}, error : function() {
			}
		});		
	}
	

	
 /* 내 게시물 조회 */ 
 
 	function showMyPosts(e) {
 
		$(".infoBox").hide();
		$(".pointBox").hide();
		$(".mypostsBox").show(); 
		let output = '<h3> 내 게시물 조회 </h3><button type="button" class="btn btn-outline-light text-dark" data-bs-toggle="modal" data-bs-target="#modalDelete" >삭제 </button><div class = "board_filters"><ul><li><select onchange = "freeOrCS(this.value);"><option value="free"> 자유게시판 </option><option value = "cs">고객센터</option></select><span id="mypostlist" onclick="freeOrCS();"> 내 게시글 </span></li><li>|</li><li onclick="showMyReviews();">내가 남긴 리뷰</li><li>|</li><li onclick="showMyQnA();">내가 남긴 Q&A</li></ul></div><div class = "table-responsive"></div>';
		$(".mypostsBox").html(output);

		showMyAllPosts();
		
	}
	
	function showMyQnA() {
		
		
		let ses = "${ sessionId}";
		
		let url = "${ contextPath}/mypage/myqna?u="+ ses;
		
		$.ajax({
			url : url,
			dataType : "json", 
			type : "GET",
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				console.log("큐앤에이 성공");
				$(".infoBox").hide();
				$(".pointBox").hide();
				$(".mypostsBox").show();
				$(".table-responsive").empty();

				let output = '<table class="table"><thead><tr><th></th><th>문의 상품</th><th>내용</th><th>글쓴이</th><th>날짜</th><th> 답변 상태</th></tr></thead><tbody>';
				
				$.each(data,function(i, e) {
					//let date = new Date(e.pointWhen);
					output +='<tr><td><input type = "checkbox" name = "PostNo" value="'+ e.question_no + '"></td><td>'+ e.question_no + '</td><td>' + e.content + '</td><td>' + e.writer + '</td><td>' + e.write_date + '</td><td>' + e.answer_status + '</td></tr>';
					})
					output += '</tbody></table><button type="button" class="btn btn-outline-light text-dark" id = "selectAll" onclick = "selectAll()"; > 전체선택 <img src="${ contextPath}/resources/img/check1.png" style = "width : 15px" ></button></div>'
					console.log(output);
					
					$(".table-responsive").html(output);
			
				}, error : function () {
					console.log("큐앤에이 실패");
				}
		});	

	}
	
	
	function showMyAllPosts() {
		
		let ses = "${ sessionId}";
		
		
		let url = "${ contextPath}/mypage/myposts?u="+ ses;
		
		
		
		$.ajax({
			url : url,
			dataType : "json", 
			type : "GET",
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".table-responsive").empty;
				output = '<table class="table"><thead><tr><th></th><th>No</th><th>제목</th><th>글쓴이</th><th>날짜</th><th>조회수</th><th>추천수</th></tr></thead><tbody>'
				
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td><input type = "checkbox" name = "PostNo" value="'+ e.boardno + '"></td><td>' + e.boardno + '</td><td>' + e.title + '</td><td>' + e.writer + '</td><td>' + e.date + '</td><td>' + e.readcount + '</td><td>' + e.likecount + '</td></tr>';
				
				})
				output += '</tbody></table><button type="button" class="btn btn-outline-light text-dark" id = "selectAll" onclick = "selectAll()"; > 전체선택 <img src="${ contextPath}/resources/img/check1.png" style = "width : 15px" ></button>'
				
				$(".table-responsive").html(output);
				}
		});	
	}
	
	
	/* 내가 쓴 댓글 | 추천한 글 */
	
 	function showMyLike(e) {
 		 
		$(".infoBox").hide();
		$(".pointBox").hide();
		$(".mypostsBox").show(); 
		let output = '<h3> 내가 쓴 댓글 </h3><button type="button" class="btn btn-outline-light text-red" data-bs-toggle="modal" data-bs-target="#modalDelete">삭제 </button><div class = "board_filters"><ul><li><span id="mypostlist" onclick="freeOrCS();"> 내가 쓴 댓글 </span></li><li>|</li><li onclick="showMyLikeF();">내가 추천한 글</li></ul><button type="button" class="btn btn-outline-light text-dark"><img src="${ contextPath}/resources/img/alarm.png" style = "width : 16px" > 신고 처리 현황 </button></div><div class = "table-responsive"></div>';
		$(".mypostsBox").html(output);

		showMyLikeF();
		
	}
 	
	function showMyLikeF() {
		let ses = "${ sessionId}";

		let url = "${ contextPath}/mypage/mylike?u="+ ses;

		
		$.ajax({
			url : url,
			dataType : "json", 
			type : "GET",
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".table-responsive").empty;
				output = '<table class="table"><thead><tr><th></th><th>No</th><th>제목</th><th>글쓴이</th><th>날짜</th><th>조회수</th><th>추천수</th></tr></thead><tbody>'
				
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td><input type = "checkbox" name = "PostNo" value="'+ e.boardno + '"></td><td>' + e.boardno + '</td><td>' + e.title + '</td><td>' + e.writer + '</td><td>' + e.date + '</td><td>' + e.readcount + '</td></tr>';
				
				})
				output += '</tbody></table><button type="button" class="btn btn-outline-light text-dark" id = "selectAll" onclick = "selectAll()"; > 전체선택 <img src="${ contextPath}/resources/img/check1.png" style = "width : 15px" ></button>'
				
				$(".table-responsive").html(output);
				}
		});	
	}
	
 // 삭제 기능
	function deletePosts() {
	 
		let deleteTr = $(".table tbody tr");
		
		
		let postArr = []; // 배열 선언
		let td = deleteTr.children();
		let pno = 0;
		 td.each(function(i) {
			if (td.eq(i).children().prop("checked")) {
					
					postArr.push($(this).find('input').val());
					console.log(postArr)
			}
		 });
		
			let url = "${ contextPath}/mypage/delmycs";
			
			$.ajax({
				url : url,
				dataType : "json", 
				type : "GET",
				data : {
					postArr : postArr
				},
				success : function(data) { // 통신 성공시 실행될 콜백 함수
					if (data != 0) {
						$('#modalDelete').modal('hide');
						showMyCSposts();
					} else {
						console.log("통신 실패");
					}
					}
			});	
		
	};
	
	
	
	
	function freeOrCS(value) {
		
		let val = value;
		// 만약 value 가 없으면 select에서 읽어오게.
		console.log(val); 
		if (val == null) {
			val = $(".board_filters").children().find('select').val();
		}

		if (val == "free") {
			showMyAllPosts();
			
		} else if (val == "cs" ) {
			showMyCSposts();
			
		}
		
		
		
	}
	
	function showMyCSposts() {
		
		let url = "${ contextPath}/mypage/mycsposts?u="+ "${ sessionId}";
		
		$.ajax({
			url : url,
			dataType : "json",
			type : "GET",
			success : function(data) { // 통신 성공시 실행될 콜백 함수
				console.log(data)
				$(".table-responsive").empty;
				output = '<table class="table"><thead><tr><th></th><th>No</th><th>말머리</th><th>제목</th><th>글쓴이</th><th>날짜</th><th>답변상태</th></tr></thead><tbody>'
				
				$.each(data,function(i, e) {
				//let date = new Date(e.pointWhen);
				output += '<tr><td><input type = "checkbox" name = "PostNo" value="'+ e.postNo + '"></td><td>'+ e.postNo + '</td><td>' + e.categoryCode + '</td><td>' + e.title + '</td><td>' + e.writer + '</td><td>' + e.postdate + '</td><td>' + e.status + '</td></tr>';
				
				})
				output += '</tbody></table><button type="button" class="btn btn-outline-light text-dark" id = "selectAll" onclick = "selectAll()"; > 전체선택 <img src="${ contextPath}/resources/img/check1.png" style = "width : 15px" ></button>'
				console.log(output);
				$(".table-responsive").html(output);
				}
		});	
	}
	
	
	


	
	
	function showMyReviews(){
		
		let ses = "${ sessionId}";
		let url = "${ contextPath}/mypage/myreviews?u="+ ses;
		console.log(url);
		$.ajax({
					url : url,
					dataType : "json", 
					type : "GET",
					success : function(data) { // 통신 성공시 실행될 콜백 함수
						console.log(data)
						$(".table-responsive").empty();
						let output = '<table class="table"><thead><tr><th></th><th>내가 준 평점</th><th>제목</th><th>내용</th><th>글쓴이</th><th>날짜</th><th> 받은 추천 수</th></tr></thead><tbody>';
						
						$.each(data, function(i, e) {
							let starMark = "";	
							
							for (i=0; i < e.grade; i++) {
								starMark += '<i class="fa fa-star" style="font-weight : 100px; color : #fbd600;"></i>&nbsp';
							}	
	
						output +='<tr><td><input type = "checkbox" name = "PostNo" value="'+ e.reviewNo + '"></td><td><div class = "star"  style="display: inline-block; float: left; margin-right: 25px;">'+ starMark + '</div></td><td>' + e.title + '</td><td>' + e.content + '</td><td>' + e.writer + '</td><td>' + e.writedate + '</td><td>' + e.recommendNum + '</td></tr>';
							//e.writedate
	
						})
						output += '</tbody></table><button type="button" class="btn btn-outline-light text-dark" id = "selectAll" onclick = "selectAll()"; > 전체선택 <img src="${ contextPath}/resources/img/check1.png" style = "width : 15px" ></button>'
						console.log(output);
						
						
						$(".table-responsive").html(output);
						
						}
			});	
	}
	
	

	function modifyInfo(e) {
	
		$(".infoBox").show();
		$(".pointBox").hide();
		$(".mypostsBox").hide();
	
	}
	
	
	function selectAll() {
		
		console.log("클릭 되나요?")
		
		if ($("input[type=checkbox]").prop("checked")) {
			$("input[type=checkbox]").prop("checked", false);
		} else {
			$("input[type=checkbox]").prop("checked", true);
		}
		
	}
		
	
	
	window.onload = function () {
		

		
			let birthStr ="${ loginMember.birth}";
			let userBirth = birthStr.split('-');
			
			
			let year = userBirth[0];
			let month = userBirth[1];
			
			let day = userBirth[2].split(' ');
			
			day = day[0];
			console.log(year, month, day);
			console.log("${ loginMember.birth}");
			
			
			let birth = new Date(year, month, day);
			
			document.getElementById('userBirth').valueAsDate = birth;
			
			
			
			
		
		
		document.getElementById('showMyPoint').addEventListener("click", pointHistory);
		document.getElementById('originalPwd').addEventListener ("keyup", confirmPwd);
		document.getElementById('modifyInfo').addEventListener ("click", modifyInfo);
		document.getElementById('showAllMyPosts').addEventListener("click", showMyPosts);
		document.getElementById('showMyLike').addEventListener("click", showMyLike);
		//showMyLike
		
		    $('#pwdModi i').on('click',function(){
		    	
		        $('input').toggleClass('active');
		        if($('input').hasClass('active')){
		            $(this).attr('class',"fa fa-eye-slash fa-lg")
		            .prev('input').attr('type',"text");
		        } else{
		            $(this).attr('class',"fa fa-eye fa-lg")
		            .prev('input').attr('type','password');
		        }	
		    });
		
	}
	
</script>
<style>

#mypostlist {
margin-left : 5px;

}

.board_filters li {
list-style : none;
float : left;
margin : 10px;
color : grey;

}

.board_filters {
float : right;
margin-bottom : 10px;
}

#pwdModi {

    position: relative;

}

#refundBtn, #cofirmBtn{
	padding: 12px 12px;
}

#pwdModi i{
    position: absolute;
    left: 90%;
    top: 52px;
}

.deleteMember {
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1090;
	display: none;
	width: 100%;
	height: 100%;
	overflow-x: hidden;
	overflow-y: auto;
	outline: 0;
}

.modal-dialog {
	position: relative;
	width: auto;
	margin: 1.5rem;
	pointer-events: none;
}

.modal.fade .modal-dialog {
	transition: transform 0.15s ease-out;
	transform: translateY(-100px) scale(0.8);
}

@media ( prefers-reduced-motion : reduce) {
	.modal.fade .modal-dialog {
		transition: none;
	}
}

.modal.show .modal-dialog {
	transform: translateY(0) scale(1);
}

.modal.modal-static .modal-dialog {
	transform: scale(1.02);
}

.modal-dialog-scrollable {
	height: calc(100% - 3rem);
}

.modal-dialog-scrollable .modal-content {
	max-height: 100%;
	overflow: hidden;
}

.modal-dialog-scrollable .modal-body {
	overflow-y: auto;
}

.modal-dialog-centered {
	display: flex;
	align-items: center;
	min-height: calc(100% - 3rem);
}

.modal-content {
	position: relative;
	display: flex;
	flex-direction: column;
	width: 100%;
	pointer-events: auto;
	background-color: #fff;
	background-clip: padding-box;
	border: 0px solid rgba(67, 89, 113, 0.2);
	border-radius: 0.5rem;
	outline: 0;
}

.modal-backdrop {
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1089;
	width: 100vw;
	height: 100vh;
	background-color: #435971;
}

.modal-backdrop.fade {
	opacity: 0;
}

.modal-backdrop.show {
	opacity: 0.5;
}

.modal-header {
	display: flex;
	flex-shrink: 0;
	align-items: center;
	justify-content: space-between;
	padding: 1.5rem 1.5rem 0.25rem;
	border-bottom: 0px solid #d9dee3;
	border-top-left-radius: calc(0.5rem - 0px);
	border-top-right-radius: calc(0.5rem - 0px);
}

.modal-header .btn-close {
	padding: 0.125rem 0.75rem;
	margin: -0.125rem -0.75rem -0.125rem auto;
}

.modal-title {
	margin-bottom: 0;
	line-height: 1.53;
}

.modal-body {
	position: relative;
	flex: 1 1 auto;
	padding: 1.5rem;
}

.modal-footer {
	display: flex;
	flex-wrap: wrap;
	flex-shrink: 0;
	align-items: center;
	justify-content: flex-end;
	padding: 1.25rem;
	border-top: 0px solid #d9dee3;
	border-bottom-right-radius: calc(0.5rem - 0px);
	border-bottom-left-radius: calc(0.5rem - 0px);
}

.modal-footer>* {
	margin: 0.25rem;
}

@media ( min-width : 576px) {
	.modal-dialog {
		max-width: 35rem;
		margin: 1.75rem auto;
	}
	.modal-dialog-scrollable {
		height: calc(100% - 3.5rem);
	}
	.modal-dialog-centered {
		min-height: calc(100% - 3.5rem);
	}
	.modal-sm {
		max-width: 22.5rem;
	}
}

@media ( min-width : 800px) {
	.col-lg-4 {
		margin-left: -18%;
	}
}

.form-control {
	display: flex;
	width: 70%;
}
</style>
<body>
	<jsp:include page="../userHeader.jsp"></jsp:include>
	<!-- ================ start banner area ================= -->

	<section class="blog-banner-area" id="blog">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>My page</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">Home</a></li>
							<li class="breadcrumb-item active" aria-current="page">Blog
								Details</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- ================ end banner area ================= -->
	<!--================Blog Area =================-->
	<section
		class="blog_area single-post-area py-80px section-margin--small">
		<div class="container">
			<div class="row">
				<div class="col-lg-4">
					<div class="blog_right_sidebar" style = 'margin-right : 120px'  >
						<aside class="single_sidebar_widget author_widget">

							<img class="author_img rounded-circle" src="img/blog/author.png"
								alt="">
							<h4>환영합니다</h4>
							
							<p>${loginMember.userName}고객님</p>
							<div class="social_icon"></div>
						</aside>
						<aside class="single_sidebar_widget post_category_widget">
							<h4 class="widget_title">Post Catgories</h4>
							<div class="br"></div>
							<ul class="list cat-list">
								<li><span id = "modifyInfo">회원 정보 수정</span></li>
								<li><a href="#" onclick="orderStatus();" class="d-flex justify-content-between">
										<p>구매 현황</p></a>
								</li>
								<li><span id = "showAllMyPosts">내 게시물 조회</span></li>
								<li><span id="showMyLike">내가 쓴 댓글  |  추천한 글</span></li>
								<li><span id = "showMyPoint">적립금 조회</span></li>
								<li><a href="#" class="d-flex justify-content-between"
									data-bs-toggle="modal" data-bs-target="#modalCenter">
										<p>회원 탈퇴</p>
								</a></li>
							</ul>
							<br> <br>
						</aside>
						<aside class="single_sidebar_widget popular_post_widget">
							<h3 class="widget_title">최근 본 상품</h3>
							<c:forEach items="${ recentSeenProd}" var="prod">
							<div class="media post_item">
								<img style = 'width : 180px;' src="${prod.cover }" alt="post">
								<div class="media-body">
									<a href="http://localhost:8001/${contextPath }/product/detail?no=${prod.lastSeenProd}">
									<h3>${prod.title}</h3></a>					
									<p>${prod.lastSeenDate}</p>
								</div>
							</div>			
						</c:forEach>

							<div class="br"></div>
						</aside>
					</div>
				</div>

				<div class="col-lg-8 posts-list contentsBox" id="myPageOrder">
					<div class= "pointBox"></div>
					<div class= "infoBox">
					<h2>회원 정보 수정</h2>
					<div class="single-post row">
						아이디 : <input type="text" class="form-control"
							value="${loginMember.userId}" readonly/>
						비밀번호 : <input type="hidden" id ="password" value="${loginMember.userPwd }" />
						<button data-bs-toggle="modal" data-bs-target="#modalPwd">비밀번호
							변경</button>
						이름 : <input type="text" class="form-control"
							value="${loginMember.nickName }" /> 	
						닉네임 : <input type="text" class="form-control"
							value="${loginMember.nickName }" /> 
						핸드폰 번호 : <input type="text" class="form-control" value="${loginMember.phoneNum}" />
						이메일 : <input type="text" class="form-control" value="${loginMember.userEmail}" /> 
						생일 : <input type = "date" id= "userBirth"  value= "${loginMember.birth }"  /> 
 						<button type="button"  class="button button-postComment" >수정</button>
						</div>
						
					</div>
					<div class = "mypostsBox">
					
					</div>
					
				</div>
				
				<!-- 탈퇴 Modal -->
					<div class="modal fade" id="modalCenter" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalCenterTitle">북다방 회원 탈퇴</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="confirm">
									<p>정말로 탈퇴하시겠습니까?</p>
								</div>
								<div class="modal-footer">
									<button type="button"
										class="btn btn-outline-secondary yesButton"
										onclick="withdrawMember();">예</button>
									<button type="button" class="btn btn-primary buttonCon"
										data-bs-dismiss="modal">아니오</button>
								</div>
							</div>
						</div>
					</div>

				<!-- 게시글 삭제 확인 Modal -->
					<div class="modal fade" id="modalDelete" tabindex="-1"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="deletePost">
									<p>선택한 게시물을 삭제하시겠습니까?</p>
								</div>
								<div class="modal-footer">
									<button type="button"
										class="btn btn-outline-secondary yesButton"
										onclick="deletePosts();">예</button>
									<button type="button" class="btn btn-primary"
										data-bs-dismiss="modal">아니오</button>
								</div>
							</div>
						</div>
					</div>


					<!-- 비밀번호 변경 모달 -->
					<div class="modal fade" id="modalPwd" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="modalCenterTitle">비밀번호 변경</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body" id="pwdModi">
									현재 비밀번호 : <input type = "password" class="form-control" id ="originalPwd" placeholder="현재 비밀번호를 입력해주세요." />
									
								<i class="fa fa-eye fa-lg" ></i>
								
									<span id="correctOrNot"></span>
									<br/>
									변경할 비밀번호 :  <input type="text" class="form-control" id ="pwd1" placeholder="변경할 비밀번호를 입력해주세요." />
									변경할 비밀번호 확인 :  <input type="text" class="form-control" id ="pwd2"  placeholder="변경할 비밀번호를 다시 확인해주세요." />
									
								</div>
								<div class="modal-footer">
									<button type="button"
										class="btn btn-outline-secondary" id = "yesButton"
										onclick="confirmModifyPwd(); ">확인</button>
									<button type="button" class="btn btn-primary buttonCon"
										data-bs-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
			</div>
		</div>
		<!--================Blog Area =================-->
	</section>
	<jsp:include page="../userFooter.jsp"></jsp:include>
</body>

</html>