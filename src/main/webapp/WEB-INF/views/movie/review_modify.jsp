<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap')
	;

* {
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	font-style: normal;
}

body {
	min-height: 50vh;
	background: -webkit-gradient(linear, left bottom, right top, from(#92b5db),
		to(#1d466c));
	background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
	background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%);
}

.input-form {
	max-width: 600px;
	margin-top: 80px;
	padding: 32px;
	background: #fff;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}

.mb-3>select {
	width: 250px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}

.subject {
	margin-bottom: 5px;
	width: 300px;
}

.mb-3 {
	margin: 0 auto;
}

.mb-3>input {
	width: 250px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}

.review-text {
	width: 500px;
	padding: 5px;
	border: 1px solid #999;
	font-family: url('http://i.ibb.co/98Vbb8L/gnb-bg.gif') no-repeat 95% 50%;
	border-radius: 2px;
	-webkit-appearance: none;
	-mox-appearance: none;
	appearance: none;
	text-align: center;
}

.space {
	margin-top: 50px;
}

.form-control {
	border: 1px solid #bbb;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>

	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4>리뷰수정 페이지</h4>
				<h6>${reviews.member_id} 님의 별점과 관람평</h6>
				<hr>
				<div class="showReview">

					<form action="reviewUpdate" method="post">
						<div class="ratingCover mb-4">
							<div class="subject">내가 선택한 별점 : ${reviews.review_rating} 점</div>
							<div class="subject">변경할 별점</div>
							<select id="review_rating" name="review_rating"
								class="form-select">
								<option value="0" selected>별점 선택(미선택시 0점 ☆)</option>
								<option value="1">★ 1점</option>
								<option value="2">★★ 2점</option>
								<option value="3">★★★ 3점</option>
								<option value="4">★★★★ 4점</option>
								<option value="5">★★★★★ 5점</option>
							</select>
						</div>

						<div class="mb-4">
							<div class="reviewTexts">
								<div class="subject">내가 적은 관람평</div>
								<textarea class="review-text" name="review_text">${reviews.review_text}</textarea>
								<input type="hidden" name="member_id"
									value="${sessionScope.sId}"> <input type="hidden"
									name="review_num" value="${reviews.review_num}">
							</div>
						</div>

						<div class="space"></div>
						<hr>
						<div class="mb-4" align="center">
							<div class="buttonBottom">
								<button type="submit" class="btn btn-outline-primary">수정</button>
								<button onclick="closeWindow()" class="btn btn-outline-primary">취소하기</button>
							</div>
						</div>

					</form>

				</div>
			</div>
		</div>
	</div>



</body>
<script>
	function closeWindow() {
		window.close();
	}
</script>
</html>