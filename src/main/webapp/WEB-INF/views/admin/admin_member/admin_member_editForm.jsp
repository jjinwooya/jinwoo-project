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
	max-width: 500px;
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
.col-md-6>input {
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
.form-control{
	border: 1px solid #bbb;
}
</style>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-4">회원정보상세</h4>
					<div class="mb-3">
						<label for="member_name">이름</label> 
						<input type="text" id="member_name" class="form-control" readonly value="${member.member_name}" />
					</div>
					<div class="mb-3">
						<label for="member_id">아이디</label> 
						<input type="text" id="member_id" class="form-control" readonly value="${member.member_id}"/>
					</div>
					<div class="mb-3">
						<label for="member_birth">생년월일</label> 
						<input type="text" id="member_birth" class="form-control" readonly value="${member.member_birth}"/>
					</div>
					<div class="mb-3">
						<label for="member_addr">주소</label> 
						<input type="text" id="member_addr" class="form-control" readonly value="${member.member_addr}"/>
						<div class="invalid-feedback">주소를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="member_email">Email</label> 
						<input type="text" id="member_email" class="form-control" readonly value="${member.member_email}"/>
					</div>
					<div class="mb-3">
						<label for="member_tel">전화번호</label> 
						<input type="text" id="member_tel" class="form-control" readonly value="${member.member_tel}"/>
					</div>
					<div class="mb-3">
						<label for="member_reg_date">가입일</label> 
						<input type="text" id="member_reg_date" class="form-control" readonly value="${member.member_reg_date}"/>
					</div>
					<div class="mb-3">
						<label for="member_withdraw_date">탈퇴일</label>  
						<input type="text" id="member_withdraw_date" class="form-control" readonly value="${member.member_withdraw_date}"/>
					</div>
					<div class="mb-3">
						<label for="member_status">회원상태</label> 
						<input type="text" id="member_status" class="form-control" readonly value="${member.member_status}">
					</div>
					
					<hr class="mb-4">
					
					<div class="mb-4" align="center">
<%-- 						<input type="button" value="회원삭제" class="btn btn-danger btn-lg btn-block" onclick="if (confirm('정말로 삭제하시겠습니까?')) location.href='admin_member_withdraw?member_id=${member.member_id}';"> --%>
						<input type="button" value="돌아가기" class="btn btn-primary btn-lg btn-block" onclick="history.back()">
					</div>
			</div>
		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; Boogi Movie</p>
		</footer>
	</div>
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