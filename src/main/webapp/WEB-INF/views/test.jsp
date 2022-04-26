<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="tab-pane fade" id="review" role="tabpanel"
						aria-labelledby="review-tab">
			
								<div class="review_list">
										<div class="review_item">
											<div class="media">
												<div class="media-body" >
													<div class = "star"  value = "${review.grade }"
													style="display: inline-block; float: left; margin-right: 25px;">														
													</div>
													<div style="display: inline-block;">
														<h4 style="display: inline-block; margin-right: 20px">${review.title }</h4>
														
														
														<h5 style="float: right; margin-top: 1px">
														${review.writer } | ${review.writedate}</h5>
														<p style="width: 750px">${review.content }</p>
													</div>
													<div style="display: inline-block; float: right; width: 100px;">
														<button type="submit" class="button button-header reviewBtn"
														style="padding: 5px" onclick="like(${review.reviewNo},this)">♡ ${review.recommendNum}</button>
														<button class="button button-header reviewBtn" style="padding: 8px" value="${review.reviewNo}"
														onclick="getComment(${review.reviewNo},this)">댓글 ${review.commentNum}</button>
													</div>
													<hr style="border-style: dotted; margin-top: 35px; margin-bottom: 4px" />
												</div>
											</div>
										</div>
								</div>
							</div>

</body>
</html>