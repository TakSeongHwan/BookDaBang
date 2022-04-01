<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 추가</title>

<script>
	window.onload = function() {
		$("#applyDiscount").on("click", function() {
			$("#applyDiscount").hide();
			$("#discount").css("display", "inline-block");
		});
	}
</script>
</head>
<body>
	<jsp:include page="../managerHeader.jsp"></jsp:include>
	<div class="content-wrapper">
		<!-- Content -->

		<div class="container-xxl flex-grow-1 container-p-y">
			<h4 class="fw-bold py-3 mb-4">
				<span class="text-muted fw-light">상품 관리 /</span> 상품 등록
			</h4>

			<div class="row">
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">상품 정보</h5>
						<div class="card-body">
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">상품번호 / ISBN</label> <input type="text"
									class="form-control" id="defaultFormControlInput"
									placeholder="ISBN(상품번호)을 입력해주세요"
									aria-describedby="defaultFormControlHelp" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">상품 명</label> <input type="text"
									class="form-control" id="defaultFormControlInput"
									placeholder="상품 명을 입력해주세요"
									aria-describedby="defaultFormControlHelp" />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">판매가격 설정</label> <input type="text"
									class="form-control" id="defaultFormControlInput"
									placeholder="50,000" aria-describedby="defaultFormControlHelp"
									style="width: 500px; display: inline-block;" />
								<button type="button" class="btn btn-outline-primary"
									id="applyDiscount">할인 적용</button>
									<input type="text"
									class="form-control" id="discount"
									placeholder="10%" aria-describedby="defaultFormControlHelp"
									style="width: 80px; display: none;" />
							</div>

							<div id="defaultFormControlHelp" class="form-text">We'll
								never share your details with anyone else.</div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">상품 이미지</h5>
						<div class="card-body">
							<div class="form-floating">

								<div class="mb-3">
									<label for="floatingInput" class="form-label"
										style="display: block">URI로 등록하세요!</label> <input type="text"
										class="form-control" id="defaultFormControlInput"
										placeholder="URI로 이미지 검색"
										aria-describedby="defaultFormControlHelp"
										style="width: 550px; display: inline-block;" />
									<button type="button" class="btn btn-outline-primary">검색</button>
								</div>
								<div class="mb-3">
									<label for="formFile" class="form-label">상품에 관한 이미지를
										선택하세요</label> <input class="form-control" type="file" id="formFile" />
								</div>
								<div id="floatingInputHelp" class="form-text">We'll never
									share your details with anyone else.</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Form controls -->
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">저자 정보</h5>
						<div class="card-body">
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">작가</label> <input type="text"
									class="form-control" id="defaultFormControlInput"
									placeholder="ISBN을 입력해주세요"
									aria-describedby="defaultFormControlHelp" readonly />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">출판사</label> <input type="text"
									class="form-control" id="defaultFormControlInput"
									placeholder="ISBN을 입력해주세요"
									aria-describedby="defaultFormControlHelp" readonly />
							</div>
							<div class="mb-3">
								<label for="floatingInput" class="form-label"
									style="display: block">저자소개정보 작성</label>

								<button type="button" class="btn btn-primary"
									data-bs-toggle="modal" data-bs-target="#fullscreenModal">
									저자 정보 작성</button>

							</div>
						</div>
					</div>
				</div>

				<!-- Input Sizing -->
				<div class="col-md-6">
					<div class="card mb-4">
						<h5 class="card-header">책 정보</h5>
						<div class="card-body">
							<label class="form-label">카테고리 설정</label> <select id="category"
								class="select2 form-select" style="width: 200px"></select> <small
								class="text-light fw-semibold" style="margin-top: 10px">간략
								설명 (1000자 이하)</small>
							<div class="mb-3">
								<div>
									<textarea class="form-control" id="exampleFormControlTextarea1"
										rows="3"></textarea>
								</div>
								<small class="text-light fw-semibold">추가 설정</small>
								<div style="margin-top: 20px">
									<button type="button"
										class="btn rounded-pill btn-outline-primary">목차 설정</button>
									<button type="button"
										class="btn rounded-pill btn-outline-primary">상세 소개</button>
									<button type="button"
										class="btn rounded-pill btn-outline-primary">책속으로</button>
									<button type="button"
										class="btn rounded-pill btn-outline-primary">출판사 제공
										책소개</button>
								</div>
							</div>
						</div>
					</div>
				</div>




			</div>
		</div>
	</div>

	<div class="modal fade" id="fullscreenModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-fullscreen" role="document">
			<div class="modal-content" style="width: 1000px;">
				<div class="modal-header">
					<h5 class="modal-title" id="modalFullTitle">저자 정보 소개</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<div>
							<textarea class="form-control" id="exampleFormControlTextarea1"
								rows="30"></textarea>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>




	<jsp:include page="../managerFooter.jsp"></jsp:include>
</body>
</html>