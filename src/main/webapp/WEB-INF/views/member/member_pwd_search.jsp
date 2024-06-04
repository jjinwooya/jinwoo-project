<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부기무비 비밀번호 찾기</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Gowun+Dodum&family=Hahmlet:wght@100..900&family=Nanum+Gothic&display=swap');

* {
  font-family: "Nanum Gothic", sans-serif;
  font-weight: 400;
  font-style: normal;
}
</style>
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/member_default.css" rel="stylesheet" type="text/css">
<body>
<header>
	<jsp:include page="../inc/admin_header.jsp"></jsp:include>
</header>
<section class="member_section">
<div class="member_title">
    <h3>비밀번호 찾기</h3>
    <hr>
    </div>
<form action="member_search_pwd_pro" method="post">
<div class="member_row">


    <div class="form_item">
    	<label for="id"><b>아이디</b></label>
    	<input type="text"  name="member_id" id="member_id" required>
    	<span id="msg_id"></span>
    </div>
    
    <div class="form_item">
    	<label for="email"><b>이메일</b></label>
    	<input type="text"  name="member_email" id="member_email" required>
    	<span id="msg_email"></span>
    </div>
</div>
<div class="regist_final">
	<hr>
	<button type="submit" class="btn btn-outline-primary">비밀번호 찾기</button>
</div>
</form>
</section>
<footer>
	<jsp:include page="../inc/admin_footer.jsp"></jsp:include>
</footer>
	<script>
	
	$(document).ready(function() {
	    // 아이디 입력값 변경 시
	    $("#member_id").on("input", function() {
	        let id = $("#member_id").val();
	        let regex = /^[a-zA-Z0-9]{8,20}$/g;
	        
	        if (!regex.test(id)) {
	            $("#member_id").css("background-color", "red");
	            $("#msg_id").text("특수문자, 한글 제외 8~20글자를 입력해주세요");
	        } else {
	            $("#member_id").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
	            $("#msg_id").empty();
	        }
	
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });
	    
	    
	    // 이메일 입력값 변경 시
	    $("#member_email").on("input", function() {
	        let email = $("#member_email").val();
	        let regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/g;
	        
	        if (!regex.test(email)) {
	            $("#member_email").css("background-color", "red");
	            $("#msg_email").text("이메일 형식을 맞춰 입력해주세요 (example@example.exam)");
	        } else {
	            $("#member_email").css("background-color", ""); // 원래의 배경색으로 돌아갑니다 (빈 문자열로 설정)
	            $("#msg_email").empty();
	        }
		
	        checkFormValidity(); // 폼 유효성 검사 실행
	    });

		    // 폼 유효성 검사 함수
		    function checkFormValidity() {
		        let idIsValid = /^[a-zA-Z가-힣0-9]{2,10}$/.test($("#member_id").val());
		        let emailIsValid = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test($("#member_email").val());
			
		        if (idIsValid && emailIsValid) {
		            $("button[type='submit']").prop("disabled", false); // submit 버튼 활성화
		        } else {
		        	$("button[type='submit']").prop("disabled", true); // submit 버튼 비활성화
		        }
			}
	});
	
</script>
</body>
</html>

