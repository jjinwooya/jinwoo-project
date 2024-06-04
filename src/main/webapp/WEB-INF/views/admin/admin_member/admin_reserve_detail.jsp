<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 등록폼</title>
<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

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
.space{
	margin-top: 50px;
}
.form-control{
	border: 1px solid #bbb;
}
</style>
</head>
<body>
<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">예매내역 - 상세</h4>
				<hr>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">결제번호</div>
							<input type="text" id="pay_num" class="form-control" value="${reserveDetail.ticket_pay_num}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">상영번호</div>
							<input type="text" id="res_code" class="form-control" value="${reserveDetail.scs_num}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">2D / 3D</div>
							<input type="text" id="member_id" class="form-control" value="${reserveDetail.screen_dimension}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">영화명</div>
							<input type="text" id="movie_name" class="form-control" value="${reserveDetail.movie_name}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">극장</div>
							<input type="text" id="theaterInfo" class="form-control" value="${reserveDetail.theater_name}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">상영관</div>
							<input type="text" id="booth_num" class="form-control" value="${reserveDetail.screen_cinema_num}관" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">예매좌석</div>
							<input type="text" id="res_seat" class="form-control" value="${seatInfo}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">상영일</div>
							<input type="date" id="movie_date" class="form-control" value="${reserveDetail.scs_date}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">상영시간</div>
							<input type="text" id="screen_round" class="form-control" value="${reserveDetail.scs_start_time} - ${reserveDetail.scs_end_time}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">결제상태</div>
							<input type="text" id="pay_status" class="form-control" value="${reserveDetail.ticket_pay_status}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">결제날짜</div>
							<input type="datetime-local" id="pay_date" class="form-control" value="${reserveDetail.ticket_pay_date}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">결제취소날짜</div>
							<input type="datetime-local" id="pay_cancel_date" class="form-control" 
							value="${reserveDetail.ticket_pay_cancel_date}" readonly />
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">결제방식</div>
							<input type="text" id="pay_type" class="form-control" value="${reserveDetail.ticket_pay_type}" readonly />
						</div>
						<div class="col-md-6">
							<div class="subject">결제금액</div>
							<input type="text" id="pay_amount" class="form-control" value="${reserveDetail.ticket_pay_price}원" readonly />
						</div>
					</div>
		
					<div class="space"></div>
					<hr class="mb-4">
					<div class="mb-4" align="center">
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
			</div>
		</div>
	</div>
	
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Boogi Movie</p>
		</footer>
	<script>
	    window.addEventListener('load', () => {
	      const forms = document.getElementsByClassName('validation-form');
	
	      Array.prototype.filter.call(forms, (form) => {
	        form.addEventListener('submit', function (event) {
	          if (form.checkValidity() === false) {
	            event.preventDefault();
	            event.stopPropagation();
	          }
	
	          form.classList.add('was-validated');
	        }, false);
	      });
	    }, false);
 	</script>
</body>
</html>