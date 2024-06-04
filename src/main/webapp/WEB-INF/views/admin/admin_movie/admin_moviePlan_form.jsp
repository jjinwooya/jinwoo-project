<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상영 등록폼</title>
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
</style>
</head>
<body>
<input type="hidden" value="${param.scs_num}">
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">상영일정 수정페이지</h4>
				<hr>
				<form class="validation-form" novalidate action="admin_moviePlan_pro" method="post" onsubmit="return confirm('상영일정을 등록하시겠습니까?');">
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">극장</div>
							<select name="" id="" class="form-control">
								<option value="화명점">화명점</option>
								<option value="해운대">해운대</option>
								<option value="광안리">광안리</option>
								<option value="기장">기장</option>
								<option value="서면">서면</option>
								<option value="센텀시티">센텀시티</option>
							</select>
						</div>
						<div class="col-md-6">
							<div class="subject">상영관</div>
							<select name="" id="" class="form-control">
								<option value="1관">1관</option>
								<option value="2관">2관</option>
								<option value="3관">3관</option>
								<option value="4관">4관</option>
								<option value="5관">5관</option>
								<option value="6관">6관</option>
							</select>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">영화명</div>
							<select name="" id="" class="form-control">
								<option value="영화제목">영화제목</option>
								<option value="윙카">윙카</option>
								<option value="파묘">파묘</option>
								<option value="전준혁">전준혁</option>
								<option value="센과치히로">센과치히로</option>
								<option value="현실을 살아라">현실을 살아라</option>
							</select>
						</div>
						<div class="col-md-6">
							<div class="subject">상영날짜</div>
							<input type="date" class="form-control admin_moviePlan_search">
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="subject">회차</div>
							<select name="" id="" class="form-control">
								<option value="1회차">1회차</option>
								<option value="2회차">2회차</option>
								<option value="3회차">3회차</option>
								<option value="4회차">4회차</option>
								<option value="5회차">5회차</option>
								<option value="6회차">6회차</option>
							</select>
						</div>
						<div class="col-md-6">
							<div class="subject">상영시간</div>
							<select name="" id="" class="form-control"></select>
						</div>
					</div>
					<div class="space"></div>
					<hr class="mb-4">
					<div class="mb-4" align="center">
						<input type="submit" value="수정하기"
							class="btn btn-primary btn-lg btn-block">
						<input type="button" value="돌아가기"
							class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
				</form>
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