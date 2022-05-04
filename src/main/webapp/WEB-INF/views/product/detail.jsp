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
	let rPageNo = 1;
	let rno = 0;
	let cno = 0;
	let modCno = 0;
	let delCno = 0;
	let userId = "";
	let prevTitle = "";
	let prevContent = "";
	let prevGrade = "";
	let prevAttach = "";
	
	$(function() {
		priceReplace();
		quantityChange(1);
		infoReplace();
		navColor();
		starMaker();
		reviewStatus();	
		getUserId();
		parseNotImgFile();
		uploadFile("#reviewModal");
		uploadFile("#modifyModal");
		
		parsePaging();
	});
	
	function insertCart2(no){
		let quantity = $("#sst").val();
		console.log($("#sst").val());
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : quantity
			},
			success : function(data) {
				console.log(data);
				$("#sst").val(1);
				quantityChange(1);
				$("#cartBox").show();
				setTimeout(function() {
					$("#cartBox").fadeOut(1500);
				}, 3000);
			},
			error : function(data){
				console.log(data);
			}
		});
		
	}
	
	function goOrder2(no){
		let quantity = $("#sst").val();
		console.log(quantity);
		let url = "${contextPath}/userCart/addCart"
		$.ajax({
			url : url,
			type : "post",
			data : {
				productNo : no,
				productQtt : quantity
			},
			success : function(data) {
				$("#sst").val(1);
				quantityChange(1);
				console.log(data);
			},
			error : function(data){
				console.log(data);
			}
		});
		location.href = "${contextPath}/order/checkOut"
	}
	
	function priceReplace() {
		let sellPrice = $(".s_product_text h2").text().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$(".s_product_text h2").text(sellPrice);
		
		let listPrice = $("#listPrice").html().replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
		$("#listPrice").html(listPrice);
	}
	
	function quantityChange(quantity) {
		let output = "";
		if (quantity > 1) {
			let price = String(${product.sell_price}*quantity);
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
		$(".comments-area").remove();
		if (rno == no) {
			rno = 0;
			return;
		} else {
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
		let output = '<div class="comments-area" style="display:none;" >';
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
				
				output += '<p class="comment" value="' + e.commentNo +'">' + e.comment + '</p></div></div>';
				output += '<div class="reply-btn"><a href="javascript:replyMaker(' + e.commentNo + ');" class="btn-reply text-uppercase">'
				+ 'reply</a></div></div></div>';
			});
		}
		 output += '<hr/><textarea class="form-control" name="comment" id= "commentText" rows="3" placeholder="comment"></textarea>';
		 let rno = $(obj).val();
		 output += '<button type="" class="button button--active button-contactForm" onclick="addComment(' + rno + ');" style="float:right;">댓글 작성</button></div>';
		 
		 $(obj).parent().after(output);
		 parseCommentOption();
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
	
	function replyMaker(no) { //$(".comments-area").html().indexOf("replyForm") == -1) // $("#replyForm").length != 1
		$("#replyForm").remove();
		if (cno == no) {
			cno = 0;
			return;
		} else {
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
							changeCommentNum(1);
							successAlert("* 댓글이 등록되었습니다 *");
						} else if(data == "fail") {
							failAlert("* 댓글 등록 실패 ! *");
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
							changeCommentNum(1);
							successAlert("* 답글이 등록되었습니다 *");
						} else if(data == "fail") { 
							failAlert("* 답글 등록 실패 ! *");
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
	
	function changeCommentNum(version) {
		let n = $("button[value=" + rno + "]").text().split(" ")[1];
		if (version == 1) {
			++n;
		} else if (version == 2) {
			--n;
		}
		$("button[value=" + rno + "]").text("댓글 " + n);
		$("button[value=" + rno + "]").click();
		$("#createReview").focus();
		
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
		
		if (obj == "#commentModifyText") {
			$("#commentModifyBtn").css("margin-top","65px");
		} else {
			$("#commentModifyBtn").css("margin-top","25px");
		}
		
		$(obj).before(output);
		$(obj).focus();
	}
	
	function showLike() {
		let url = "/review/showLike";
		console.log(url);	
		let sendData = JSON.stringify({
			userId : userId
		});
		$.ajax({
			url : url,
			data : sendData,
			dataType : "text",
			type : "post",
			headers : {
				"content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},success : function (data) {
				console.log(data);
				if (data != null) {
					$(".likeBtn").each(function () {
						let reviewNo = $(this).next().attr("value");
						if (data.indexOf(reviewNo) != -1) {
							let newText = $(this).text().replace("♡","♥");
							$(this).text(newText);
							$(this).css("color", "red");
						}
					});
				}
			}
		});
	}
	
	function changeLike(obj) {
		if ("${sessionId}") {
			let reviewNo = $(obj).next().attr("value");
			let change = 1;
			if ($(obj).text().indexOf("♥") != -1) {
				change = 2;
			}
			let url = "/review/changeLike";
			console.log(url);	
			let sendData = JSON.stringify({
				userId : userId, reviewNo : reviewNo, change: change
			});
			$.ajax({
				url : url,
				data : sendData,
				dataType : "text",
				type : "post",
				headers : {
					"content-type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},success : function (data) {
					console.log(data);	
					if (data == "success") {
						let newText = $(obj).text().split(" ")[0];
						let n = $(obj).text().split(" ")[1];
						if (change == 1) {
							newText = newText.replace("♡","♥");
							++n;
							$(obj).css("color", "red");
						} else if (change == 2) {
							newText = newText.replace("♥","♡");
							--n;
							$(obj).css("color", "black");
						}
						$(obj).text(newText + " " + n);
					} else if(data == "fail") { 
						failAlert("* 좋아요 실패 ! *");
					}
				}
			});
		} else {
			loginAlarm();
		}
	}
	
	function showAddModal() {
		if ("${sessionId}") {
			$(".newStar").css("font-weight", 100);
			$("#msg").remove();
			$("#modalBack").fadeIn(400);
			$('body').css("overflow", "hidden");
			reviewStar(1);
		} else {
			loginAlarm();
		}
	}
	
	function reviewStar(starId) {
		$(document).on("mouseover", ".newStar", function(){
			let n = $(this).attr("id").split("star")[1];
			$(".newStar").css("font-weight", 100);
			for (let i = starId; i <= n; i++) {
				$("#star" + i).css("font-weight", 900);
			}
			if (starId == 1) {
				$("#starCount").val(n);
			} else if (starId == 6) {
				$("#starCount2").val(n-5);
			}
		});
	}
	
	function addReview() {
		if ($(".newStar").css("font-weight") == 100) {
			validate($(".rating_list div"), 2);
			return false;
		}
	}
	
	function cancleModal(obj) {
		if(obj == "#reviewModal") {
			$("#modalBack").fadeOut(400);
			$("#addFileBtn").text("추가하기");
		} else {
			$("#modalBack2").fadeOut(400);
			$("#modiFileBtn").text("수정하기");
		}
		$('body').css("overflow", "scroll");
		$(".fDropList").html("");
		 $(".fileDrop").hide();
		 $(obj).css("top","13%");
		 $(obj).css("height","700px");
	}
	
	function reviewStatus() {
		let addStatus = '${addResult}';
		let modifyStatus = '${modifyResult}';
		let deleteResult = '${deleteResult}';
		
		if(addStatus == "success") {
			$("#alertText1").text("* 리뷰가 등록되었습니다 *")
		} else if (addStatus == "fail") {	
			$("#alertText2").text("* 리뷰 등록 실패 ! *")
		}
		if(modifyStatus == "success") {
			$("#alertText1").text("* 리뷰가 수정되었습니다 *")
		} else if (modifyStatus == "fail") {
			$("#alertText2").text("* 리뷰 수정 실패 ! *")
		}
		if(deleteResult == "success") {
			$("#alertText1").text("* 리뷰가 삭제되었습니다 *")
		} else if (deleteResult == "fail") {
			$("#alertText2").text("* 리뷰 삭제 실패 ! *")
		}
		
		if ($("#alertText1").text() != "") {
			$("#successAlert").fadeIn(300);
			$("#successAlert").fadeOut(5000);
		} else if ($("#alertText2").text() != "") {
			$("#failAlert").fadeIn(500);
			$("#failAlert").fadeOut(7000);
		}
	}
	
	function successAlert(message) {
		$("#alertText3").text(message);
		$("#commentSuccessAlert").fadeIn(300);
		$("#commentSuccessAlert").fadeOut(5000);
	}
	
	function failAlert(message) {
		$("#alertText4").text(message);
		$("#commentFailAlert").fadeIn(500);
		$("#commentFailAlert").fadeOut(7000);
	}
	
	function getUserId() {
		let sessionId = "${sessionId}";
		if (sessionId) {
			let url = "/review/" + sessionId; 
			$.ajax({
				url : url,
				dataType : "text",
				type : "get",
				success : function(data) {
					userId = data;
					parseReviewOption(userId);
					showLike();
				}
			});
		}
	}
	
	function parseReviewOption(userId) {
		$(".reviewTitle").each(function(i, e) {
			let output = '';
			if (userId == $(this).next().attr("value")) {
				let starVal = $(this).parent().prev().attr("value");
				output = '<div style="display: inline-block;"><a href="javascript:;" onclick="showModifyModal(this,'+starVal+');">';
				output += '<i class="ti-pencil-alt" style="color:#384aeb;font-size:18px;"></i></a>';
				let reviewNo = $(this).attr("value");
				output += '<a data-bs-toggle="modal" data-bs-target="#myModal" onclick="deleteModal(' + reviewNo + ');">' +
						  '<i class="ti-trash" style="color:#384aeb;font-size:18px;margin-left:5px;"></i></a></div>';
			}
			$(this).after(output);
		});
	}
	
	function parseCommentOption() {
		$(".commenter").each(function(i, e) {
			let output = '';
			if (userId == $(this).text()) {
				output = '<div style="display: inline-block;">';
				output += '<a onclick="showCommentModify(this);"><i class="ti-pencil-alt" style="color:#384aeb;font-size:18px;margin-left: 10px;"></i></a>';
				let commentNo = $(this).siblings(".comment").attr("value");
				output += '<a data-bs-toggle="modal" data-bs-target="#commentModal" onclick="deleteCommentModal(' + commentNo + ');">' +
				'<i class="ti-trash" style="color:#384aeb;font-size:18px;margin-left:5px;"></i></a></div>';
			}
			$(this).next().after(output);
		});
	}
	
	function showModifyModal(obj,starVal) {
		$("#modalBack2").fadeIn(400);
		$('body').css("overflow", "hidden");
		
		// 수정할 리뷰정보 가져오기
		prevTitle = $(obj).parent().siblings("h4").text();
		prevContent = $(obj).parent().siblings("p").text();
		prevGrade = starVal;
		$("#modifyReviewNo").val($(obj).parent().siblings("h4").attr("value"));
		$("#modifyTitle").val(prevTitle);
		$("#modifyContent").text(prevContent);
		$(".newStar").css("font-weight", 100);
		for (let i = 6; i <= starVal+5; i++) {
			$("#star" + i).css("font-weight", 900);
		}
		$("#starCount2").val(prevGrade);
		
		// 리뷰 수정 등급 변화이벤트
		reviewStar(6);
		
		// 첨부파일 가져오기
		let attachfile = $(obj).parent().siblings("div").html();
		if (attachfile != null) {
			attachfile = attachfile.replaceAll("thumbImgR","thumbImg");
			attachfile = attachfile.replaceAll("notImgR","notImg");
			$("#modifyModal .fDropList").append(attachfile);
		}
		$(".thumbImg:visible").each(function() {
			prevAttach += $(this).attr('src');
		});
		$(".notImg:visible").each(function() {
			prevAttach += $(this).attr('href');
		});
	}
	
	function modifyReview() {
		let afterAttach = "";
		$(".thumbImg:visible").each(function() {
			afterAttach += $(this).attr('src');
		});
		$(".notImg:visible").each(function() {
			afterAttach += $(this).attr('href');
		});
		
		if (prevTitle == $("#modifyTitle").val() && prevContent == $("#modifyContent").val() &&
			prevGrade == $("#starCount2").val() && prevAttach == afterAttach) {
			$("#modifyAlert").fadeIn(1000);
			$("#modifyAlert").fadeOut(1500);
			return false;	
			
		} else if ($(".thumbImg:hidden").length != 0 || $(".notImg:hidden").length != 0){
			return delPrevAttach(".thumbImg:hidden",".notImg:hidden");
		}
		
	}
	
	function delPrevAttach(img,notImg) {
		let attachArray = [];
		attachArray.push("0,파일들");
		
		$(img).each(function(){
			attachArray.push($(this).attr("value") + "," + $(this).attr("src").replace("/",""));
        });
        $(notImg).each(function(){
			attachArray.push($(this).attr("value") + "," + $(this).attr("href").replace("/",""));
        }); 
        console.log(attachArray);
		
		let url = "/review/delPrevFile";
		$.ajax({
			url : url,
			data : {
				targetList : attachArray
			},
			dataType : "text",
			type : "POST",
			success : function(data) {
				console.log(data);
				if(data == "success") {
					return true;
				} else { 
					alert("기존 파일 삭제실패");
					return false;
				}
			}
		});
	}
	
	function deleteModal(reviewNo) {
		$("#deleteNo").val(reviewNo);
	}
	
	function deleteReview() {
		let dno = $("#deleteNo").val();
		console.log(dno);
		let attach = $("h4[value=" + dno + "]").siblings(".attachfile");
		if (attach.html().indexOf("<") != -1) {
			return delPrevAttach(attach.children(".thumbImgR"), attach.children(".notImgR"));
		}
	}
	
	function showCommentModify(obj) {
		let commentNo = $(obj).parent().next().attr("value");
		// 이전 상태로 되돌리기
		let prevComment2 = $("#commentModifyText").text();
		$("#commentModifyText").parent().text(prevComment2);
		$("#commentModifyText").remove();
		$("#commentModifyBtn").remove();
		
		if (commentNo == modCno) {
			modCno = 0;
			return;
		} else {
			let prevComment = $(obj).parent().next().text();
			let output = '<textarea type="text" class="form-control" required="" id="commentModifyText" rows="3" style="border-radius : 20px;">' + prevComment;
			output += '</textarea>';
			let output2 = '<button class="button button--active button-contactForm" id = "commentModifyBtn" onclick="modifyComment(' + commentNo + ')"' +
						'style="float:right; width: 70px;padding: 10px; margin-top: 25px; border-radius: 5px;">댓글 수정</button>';
						
			$(obj).parent().next().html(output);
			$("#"+commentNo).children(".reply-btn").children().after(output2);
		}
		modCno = commentNo;	
	}
	
	function modifyComment(cno) {
		let comment = $("#commentModifyText").val();
		if (comment == $("#commentModifyText").text()) {
			$("#modifyAlert").fadeIn(1000);
			$("#modifyAlert").fadeOut(1500);
		} else if (comment == "") {
			validate("#commentModifyText",1);
		} else {
			let sendData = JSON.stringify({
				commentNo : cno, comment : comment
			});
			let url = '/Rcomment/'+ cno;
			$.ajax({
				url : url,
				data : sendData,
				dataType : "text",
				type : "put",
				headers : {
					"content-type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				success : function (data) {
					console.log(data);	
					if(data == "success") {
						$("button[value=" + rno + "]").click();
						$("#createReview").focus();
						successAlert("* 댓글이 수정되었습니다 *");
					} else if(data == "fail") { 
						failAlert("* 댓글 수정 실패 ! *");
					}
				}
			});
		}
	}
	
	function deleteCommentModal(commentNo) {
		delCno = commentNo;
	}
	
	function deleteComment() {	
		let sendData = JSON.stringify({
			commentNo : delCno, reviewNo : rno
		});
		let url = '/Rcomment/'+ delCno;  
		$.ajax({
			url : url,
			data : sendData,
			dataType : "text",
			type : "delete",
			headers : {
				"content-type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			success : function (data) {
				console.log(data);	
				if(data == "success") {
					$("#deleteCancle").click();
					changeCommentNum(2);
					successAlert("* 댓글이 삭제되었습니다 *");
				} else if(data == "fail") { 
					failAlert("* 댓글 삭제 실패 ! *");
				}	
			}
		});
	}
	
	function openArea() {
		$(".fileDrop").toggle(300);
		
		if ($("#reviewModal").css("height") == "925px") {
			$("#addFileBtn").text("추가하기");
			$("#reviewModal").css("top","13%");
			$("#reviewModal").css("height","700px");
		} else {
			$("#addFileBtn").text("접기");
			$("#reviewModal").css("top","5%");
			$("#reviewModal").css("height","925px");
		}
	}
	
	function modifyArea() {
		$(".fileDrop").toggle(300);
		
		if ($("#modifyModal").css("height") == "925px") {
			$("#modiFileBtn").text("수정하기");
			$("#modifyModal").css("top","13%");
			$("#modifyModal").css("height","700px");
			$(".prevFileBtn").remove();
		} else {
			$("#modiFileBtn").text("접기");
			$("#modifyModal").css("top","5%");
			$("#modifyModal").css("height","925px");
			
			if ($(".fDropList").html() != null) {
				let output = "<span class='prevFileBtn' onclick='tempDelete(this)'><img class='closeImg' src= '/resources/ImgClose.svg'/></span>";
				$(".thumbImg:visible").after(output);
				$(".notImg:visible").after(output);
			}
		}
	}
	
	function tempDelete(obj) {
		$(obj).prev().css("display","none");
		$(obj).remove();
	}
	
	function uploadFile(obj) {
		$(obj + " .fileDrop").on("dropenter dragover", function(evt){
			evt.preventDefault(); //영역에 드래그 될때는 이벤트 멈춤
		});
		
		$(obj + " .fileDrop").on("drop", function(evt){
			evt.preventDefault(); //이벤트가 전파되어 드롭된 파일이 웹브라우저에성 열리는 것을 방지
			
			let files = evt.originalEvent.dataTransfer.files; // 드랍된 파일을 얻어옴
			console.log(files);
			
			let formData = new FormData(); //form 객체 생성
			formData.append("upfile", files[0]); // form객체에 파일 첨부
			
			let url = "/review/uploadFile";
			$.ajax({
				url : url,
				data : formData,
				datatype : "json",
				type : "post",
				processData : false, // 전송 하는 데이터를 쿼리스트링 형태로 변환하지 않는다
				contentType : false, // 기본값(application/x-www.from-urlencoded) 사용하지 않음
				success : function(data) {
					console.log(data);
					let output = "";
					
					if (data.thumbnailFileName != null) {
						// 이미지 파일이다
						output += "<img class='thumbImg' src='${contextPath}/resources/uploads" + data.thumbnailFileName + "'/>"
						output += "<span id='" + data.thumbnailFileName + "' onclick='deleteFile(this)'>";
					} else if (data.notImageFileName != null) { // 이미지 파일 아님
						let fn = data.notImageFileName.substring(data.notImageFileName.lastIndexOf("/") + 1);
						output += "<a class='notImg' href='${contextPath}/resources/uploads" + data.notImageFileName + "'>" + fn + "</a>";
						output += "<span id='" + data.notImageFileName + "' onclick='deleteFile(this)'>";
					}

					output += "<img class='closeImg' src= '${contextPath}/resources/img/review/ImgClose.svg'/></span>";

					$(obj + " .fDropList").append(output);
				},
				error : function(e) {
					console.log(e);
					alert("파일업로드 실패");
				}
			});
			
		});
	}
	
	function deleteFile(obj) {
		let targetFile = $(obj).attr("id");
		let url = "/review/deleteFile";
		$.ajax({
			url : url,
			data : {
				targetFile : targetFile
			},
			dataType : "text",
			type : "POST",
			success : function(data) {
				console.log(data);
				if (data == "success") {
					$(obj).prev().remove();
					$(obj).remove();
				}
			}
		});
	}
	
	function writeCancel(version) {
		let url = "/review/writeCancel";
		$.ajax({
			url : url,
			dataType : "text",
			type : "POST",
			success : function(data) {
				console.log(data);
				if (data == "success") {	
					if (version == 1) {
						cancleModal("#reviewModal");
					} else if (version == 2) {
						cancleModal("#modifyModal");
					}
				}
			}
		});
	}
	
	function parseNotImgFile() {
		$(".notImgR").each(function(i, tag) {
			let tmpFileName = $(tag).attr("href");
			let fileName = tmpFileName.substring(tmpFileName.lastIndexOf("/") + 1);
			$(tag).text(fileName);
		});
	}
	
	function parsePaging(pagingInfo) {
		let pInfo = "";
		let startBlock = "";
		let endBlock = "";
		let totalPage = "";
		
		if (pagingInfo == null) {
			pInfo = "${pagingInfo}";
			startBlock = "${pagingInfo.startNoOfCurPagingBlock}";
			endBlock = "${pagingInfo.endNoOfCurPagingBlock}";
			totalPage = "${pagingInfo.totalPage}";
		} else {
			$(".pagination").empty();
			pInfo = pagingInfo;
			startBlock = pagingInfo.startNoOfCurPagingBlock;
			endBlock = pagingInfo.endNoOfCurPagingBlock;
			totalPage = pagingInfo.totalPage;
		}
		console.log(pInfo);
		console.log(startBlock + ", " + endBlock + ", " + totalPage);
		
		let output = '';
		if (rPageNo > 2) {
			output += '<li class="page-item"><button onclick="getReview(1)"'
				 + 'class="page-link" aria-label="Previous"><span aria-hidden="true">' +
				'<span class="lnr lnr-chevron-left"><<</span></span></button></li>';
		}
		if (rPageNo > 1) {
			output += '<li class="page-item"><button onclick="getReview(' + (rPageNo-1) +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left"><</span></span></button></li>';
		
		}
		for (let i = startBlock; i <= endBlock; i++) {
			if (rPageNo == i) {
				output += '<li class="page-item active"><button onclick="getReview(' + i + ')"class="page-link">' + i + '</button></li>';
			} else {
				output += '<li class="page-item"><button onclick="getReview(' + i + ')"class="page-link">' + i + '</button></li>';
			}
			
		}
		if (rPageNo < totalPage ) {
			output += '<li class="page-item"><button onclick="getReview(' + ++rPageNo +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left">></span></span></button></li>';
		
		}
		if (rPageNo < totalPage) {
			output += '<li class="page-item"><button onclick="getReview(' + totalPage +
					')"class="page-link" aria-label="Previous"><span aria-hidden="true">' +
					'<span class="lnr lnr-chevron-left">>></span></span></button></li>';
		
		}

		$(".pagination").html(output);
		//$(".filter-bar").attr("tabindex", -1).focus();
	}
	
	function getReview(pageNo) {
		rPageNo = pageNo;
		let url = "/review/read?no=${param.no}&pageNo=" + rPageNo;
		console.log(url);
		$.ajax({
			url : url,
			dataType : "json",
			type : "get",
			success : function (data) {
				console.log(data);	
				if (data != null) {
					parseReview(data.reviewList,data.fileList);
					parsePaging(data.pagingInfo);
					$("#createReview").focus();
				}
			},error : function() {
				//parseComment(null,obj);
			}
		});	
	}
	
	function parseReview(rList,fList) {
		let output = "";
		$.each(rList, function(i, review) {
			output += '<div class="review_item"><div class="media"><div class="d-flex"><img src="" alt=""></div><div class="media-body">';
			output += '<div class="star" value = "' + review.grade + '"style="display:inline-block; float:left; margin-right:25px;"></div>';
			output += '<div style="display:inline-block; width:750px;"><h4 style="display:inline-block; margin-right:20px" class="reviewTitle"'
					+ ' value="' + review.reviewNo + '">' + review.title + '</h4>';
			let writeDate = new Date(review.writedate).toLocaleString();
			output += '<h5 style="float:right; margin-top:1px" value="' + review.writer + '">' + review.writer + ' | ' + writeDate + '</h5>';
			output += '<p>' + review.content + '</p><div class="attachfile">';
			$.each(fList, function(i, file) {
				if (review.reviewNo == file.reviewNo) {
					if (file.thumbnailFile != null) {
						output += "<img class='thumbImgR' src='${contextPath}/resources/uploads" + file.thumbnailFile + "' value='" + file.attachFileNo + "'/>";
					} else if (file.notImageFile != null) {
						output += "<a class='notImgR' href='${contextPath}/resources/uploads" + file.notImageFile + "' value='" + file.attachFileNo + "'></a>";
					}
				}
			});
			output += '</div></div><div style="display: inline-block; float: right; width: 100px;">';
			output += '<button type="submit" class="button button-header reviewBtn likeBtn" style="padding:5px" onclick="changeLike(this)">'
					+ '♡ ' + review.recommendNum + '</button>';
			output += '<button class="button button-header reviewBtn" style="padding:8px" value="' + review.reviewNo + '" onclick="getComment('
					+ review.reviewNo +',this)">댓글 ' + review.commentNum + '</button>';
			output += '</div><hr style="border-style:dotted; margin-top:35px; margin-bottom:4px"/></div></div></div>';
		});
		
		$(".review_list").html(output);
		starMaker();
		parseNotImgFile();
		
		if (userId) {
			parseReviewOption(userId);
			showLike();
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
 
 .commenter, .date{
 	display: inline-block;
 }
 
 .date {
 	margin-left: 14px;
 }
 
 #replyImg {
 	width : 20px;
 	height : 20px;
 	margin-right: 10px;
 	margin-bottom: 5px;
 }
 
 #modalBack, #modalBack2 {
 	position: fixed;
 	top:0; left: 0; bottom: 0; right: 0;
 	background:rgba(0,0,0,.3);
 	z-index: 999;
 	display: none;
 }
 
 #reviewModal, #modifyModal {
		position: absolute;
  		top: 13%; left: 31%;
  		overflow: auto;
  		width: 800px; height: 700px;
  		border-radius : 25px;
  		box-shadow : 10px 10px 10px 10px;
}
 
 .newStar {
 	color : #fbd600;
 	font-size: 30px;
 }
 

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

#successAlert, #failAlert, #modifyAlert,#commentSuccessAlert,#commentFailAlert {
	width: 300px; text-align: center; display: none;
	position: fixed; top: 19%; left: 42.8%;
    z-index: 999;
}

#successAlert {
	text-align: end;	
}

.fileDrop {
	width : 100%;
	height : 300px;
	border : 1px dotted blue;
	display : none;
	background-color: white;
    border-radius: 20px;
}
	
.fileDrop .fileContent {
	padding : 20px;
	text-align : center;
	margin : 10px auto;
}

.fDropList {
	padding: 20px;
	margin-top: 10px;
	background-color: white;
	border: 1px solid #384aeb;
	border-radius: 20px;
}

.thumbImg,.notImg,.thumbImgR,.notImgR {
	border: 1px dotted;
	width: 100px; height: 100px;
	margin-left: 7px;
}

.thumbImgR,.notImgR {
	float: right;
	text-align: center;
}

.notImg,.notImgR {
	font-size: small;
    line-break: anywhere;
    padding-top: 7px;
    vertical-align: middle;
}

.closeImg {
	width: 20px;
    margin-bottom: 100px;
    margin-right: 7px;
}

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
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++; quantityChange(result.value);"
                                    class="increase items-count" type="button" style="top: -2px;">
                                    <i class="lnr lnr-chevron-up:before"><img src="//image.aladin.co.kr/img/shop/2018/icon_Aup.png" border="0"></i>
                                    
                                </button>
                                <button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 1 ) result.value--;quantityChange(result.value);"
                                    class="reduced items-count" type="button" style="bottom: -1.5px;">
                                    <i class="lnr lnr-chevron-down"><img src="//image.aladin.co.kr/img/shop/2018/icon_Adown.png" border="0"></i>
                                </button>
                               
							</div>
							 <div style="display: inline-block; margin-left: 50px;" id="totalPrice">
							
							</div>
							<div>
								<a class="button button--active button-contactForm" href="javascript:insertCart2(${product.product_no});">장바구니 담기</a>&nbsp;
								<a class="button button--active button-contactForm" href="javascript:goOrder2(${product.product_no});">바로구매</a>
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
											<button id ="createReview" class="button button--active button-review"
											style="float: right;" onclick="showAddModal()"> 리뷰 작성</button>
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
													<div style="display: inline-block; width: 750px;">
														<h4 style="display: inline-block; margin-right: 20px"
														class="reviewTitle" value="${review.reviewNo }">${review.title }</h4>
														<h5 style="float: right; margin-top: 1px" value="${review.writer}">
														${review.writer } | ${review.writedate}</h5>
														<p>${review.content }</p>
														<div class="attachfile">
														<c:forEach var="file" items="${fileList }">
															<c:if test="${review.reviewNo == file.reviewNo }">
																<c:if test="${file.thumbnailFile != null}">
																	<img class='thumbImgR' src='/resources/uploads${file.thumbnailFile}' value="${file.attachFileNo}"/>
																</c:if>
																<c:if test="${file.notImageFile != null}">
																	<a class='notImgR' href='/resources/uploads${file.notImageFile}' value="${file.attachFileNo}"></a>
																</c:if>
															</c:if>
														</c:forEach>
														</div>
													</div>
													<div style="display: inline-block; float: right; width: 100px;">
														<button type="submit" class="button button-header reviewBtn likeBtn"
														style="padding: 5px" onclick="changeLike(this)">♡ ${review.recommendNum}</button>
														<button class="button button-header reviewBtn" style="padding: 8px" value="${review.reviewNo}"
														onclick="getComment(${review.reviewNo},this)">댓글 ${review.commentNum}</button>
													</div>
													<hr style="border-style: dotted; margin-top: 35px; margin-bottom: 4px" />
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
								
								<nav class="blog-pagination justify-content-center d-flex" style="padding-bottom: 25px;">
                          			<ul class="pagination" style="place-content: center;">
                          			
                          			</ul>
                      			</nav>
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
									alert("등록에 실패하였습니다.");
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
									alert("삭제에 성공하였습니다. ");
									location.reload();
									
									} else {
									alert("삭제에 실패하였습니다.");
									
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
				<form action="/review/add" method="post">
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
						<textarea class="form-control mb-10" rows="4" name="content"
							placeholder="content" required=""
							style="border-radius : 20px;"></textarea>
					</div>
					<input type="hidden" name ="productNo" value="${product.product_no }">
					<div class="form-group">
						<h4 style="text-align: left; margin-bottom: 15px;">첨부파일</h4>
						<button type="button" class="button button-header reviewBtn" id = "addFileBtn"
						 style="padding: 8px" onclick="openArea();">추가하기</button>
						<div class="fileDrop">
							<div class="fileContent">이 영역에 업로드 할 파일을 드래그 드롭 해 주세요!</div>
						</div>
						<div class="fDropList"></div>
					</div>
					
					<button type="submit" class="button button--active"
					 onclick="return addReview();" style="margin: 25px;"> 작성하기 </button>
					<button type="reset" class="button button--active"
					 onclick="writeCancel(1)" style="margin: 25px;"> 취소하기 </button>
				</form>
			</div>
		</div>
		<!-- 리뷰 작성 모달창 끝 -->
		<!-- 리뷰 수정 모달창 -->
		<div id="modalBack2">
			<div class="comment-form" id="modifyModal">
				<h3 style="margin-bottom: 50px;">리뷰 수정</h3>
				<form action="/review/modify" method="post">
					<div class="form-group form-inline">
						<input type="hidden" id ="modifyReviewNo" name ="reviewNo">
						<div class="form-group col-lg-8 col-md-8 name">
							<h4 style="margin-bottom: 15px;">제목 </h4>
							<input type="text" class="form-control" id="modifyTitle" name = "title"
								placeholder="Enter title" required=""
								style="border-radius : 20px;">
						</div>
						<div class="form-group col-lg-4 col-md-4 rating_list2">
							<h4 style="margin-bottom: 15px;">등급 </h4>
							<div>
								<i class="fa fa-star newStar" id="star6" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star7" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star8" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star9" style="font-weight: 100"></i>
								<i class="fa fa-star newStar" id="star10" style="font-weight: 100"></i>
							</div>
							<input type="hidden" id ="starCount2" name ="grade">
						</div>
					</div>
					<div class="form-group">
						<h4 style="text-align: left; margin-bottom: 15px;">내용</h4>
						<textarea class="form-control mb-10" rows="4" name="content"
							placeholder="content" required=""  id="modifyContent" 
							style="border-radius : 20px;"></textarea>
					</div>
					<input type="hidden" name ="productNo" value="${product.product_no }">
					
					<div class="form-group">
						<h4 style="text-align: left; margin-bottom: 15px;">첨부파일</h4>
						<button type="button" class="button button-header reviewBtn" id = "modiFileBtn"
						 style="padding: 8px" onclick="modifyArea();">수정하기</button>
						<div class="fileDrop">
							<div class="fileContent">이 영역에 업로드 할 파일을 드래그 드롭 해 주세요!</div>
						</div>
						<div class="fDropList"></div>
					</div>
					
					<button type="submit" class="button button--active"
					 onclick="return modifyReview()" style="margin: 25px;"> 수정하기 </button>
					<button type="reset" class="button button--active"
					 onclick="writeCancel(2)" style="margin: 25px;"> 취소하기 </button>
				</form>
			</div>
		</div>
		<!-- 리뷰 수정 모달창 끝 -->
		<!-- 리뷰 삭제 모달창 -->
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title" style="margin: 10px;font-size: 25px;">리뷰 삭제</h3>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<!-- Modal body -->
					<div class="modal-body" style="margin: 20px;text-align: center;">
						<h4>해당 리뷰를 삭제하시겠습니까?</h4>
						(한번 삭제한 리뷰는 복원이 불가합니다)
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="margin: 10px;">
						<form action="/review/delete" method="post">
							<input type="hidden" id="deleteNo" name="reviewNo">
							<input type="hidden" name ="productNo" value="${product.product_no }">
							<button type="submit" class="btn btn-danger" onclick="return deleteReview()">삭제하기</button>
						</form>
						<button type="button" class="btn btn-light"
							data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 리뷰 삭제 모달창 끝 -->
		<!-- 댓글 삭제 모달창 -->
		<div class="modal fade" id="commentModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<!-- Modal Header -->
					<div class="modal-header">
						<h3 class="modal-title" style="margin: 10px;font-size: 25px;">댓글 삭제</h3>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>
					<!-- Modal body -->
					<div class="modal-body" style="margin: 20px;text-align: center;">
						<h4>해당 댓글을 삭제하시겠습니까?</h4>
						(한번 삭제한 댓글은 복원이 불가합니다)
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="margin: 10px;">
						<button type="button" class="btn btn-danger" onclick="deleteComment();">삭제하기</button>
						<button type="button" class="btn btn-light" id = "deleteCancle"
							data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 리뷰 삭제 모달창 끝 -->
		
		<!-- 알림들 -->
		<div class="alert alert-warning" id ="modifyAlert">
			<strong> * 변경된 사항이 없습니다 *</strong>
			</br> 내용을 수정후에 눌러주세요
		</div>

		<div class="alert alert-primary alert-dismissible fade show" id="successAlert">
			<button type="button" class="btn-close" data-bs-dismiss="alert" style="padding-top: 10px"></button>
			<strong id = "alertText1"></strong>
		</div>

		<div class="alert alert-danger alert-dismissible fade show" id="failAlert">
			<button type="button" class="btn-close" data-bs-dismiss="alert" style="padding-top: 10px"></button>
			<strong id ="alertText2"></strong>
		</div>
		
		<div class="alert alert-primary" id="commentSuccessAlert">
			<strong id ="alertText3"></strong>
		</div>
		
		<div class="alert alert-danger" id="commentFailAlert">
			<strong id ="alertText4"></strong>
		</div>
		
		<!-- 알림들 끝 -->

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
										<button onclick="insertCart(${product.product_no})"><i class="ti-shopping-cart"></i></button>
									</li>
									<li>
										<button onclick="goOrder(${product.product_no})"><i class="ti-money"></i></button>
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